# Simulated time series explorer
# Packages: shiny, bslib, plotly (called as plotly::, no library() needed)
# Deploy:   rsconnect::deployApp()  (shinyapps.io / Posit Connect)
#           rsconnect::writeManifest() for Posit Connect Cloud (Git-based)

library(shiny)
library(bslib)

# ---- Simulation -------------------------------------------------------------

N     <- 1095L                      # three years of daily data
START <- as.Date("2023-01-01")
END   <- START + N - 1L

series_info <- list(
  rw = list(
    label = "Random walk with drift",
    desc  = "Cumulative sum of N(0.05, 1) increments. Non-stationary; the ACF decays very slowly."
  ),
  ar1 = list(
    label = "AR(1), phi = 0.8",
    desc  = "Stationary autoregressive process that reverts to zero. The ACF decays geometrically."
  ),
  seasonal = list(
    label = "Trend + weekly and yearly seasonality",
    desc  = "Linear trend plus a yearly and a weekly sine wave with Gaussian noise."
  ),
  garch = list(
    label = "GARCH(1,1) returns",
    desc  = "Mean-zero returns with volatility clustering. The series is uncorrelated, but its variance is not constant."
  ),
  regime = list(
    label = "Two-state Markov regime switching",
    desc  = "Alternates between a calm low-mean state and a volatile high-mean state."
  ),
  break_ = list(
    label = "Level shift (structural break)",
    desc  = "Mean-stationary noise with a permanent jump in level 55% of the way through."
  ),
  counts = list(
    label = "Poisson counts with seasonality",
    desc  = "Daily counts whose intensity varies with a yearly and a weekly cycle."
  ),
  outliers = list(
    label = "AR(1) with additive outliers",
    desc  = "A persistent AR(1) series with about 1% of observations hit by large one-off shocks."
  )
)

series_choices <- setNames(
  names(series_info),
  vapply(series_info, function(x) x$label, character(1))
)

simulate_series <- function(seed = 1L, n = N, start = START) {
  set.seed(seed)
  t     <- seq_len(n)
  dates <- start + t - 1L
  year  <- 2 * pi * t / 365.25
  week  <- 2 * pi * t / 7

  # Random walk with drift
  rw <- cumsum(rnorm(n, mean = 0.05, sd = 1))

  # AR(1)
  ar1 <- as.numeric(arima.sim(list(ar = 0.8), n = n))

  # Trend + seasonality
  seasonal <- 0.03 * t + 10 * sin(year) + 3 * sin(week) + rnorm(n, 0, 1.5)

  # GARCH(1,1)
  omega <- 0.05; alpha <- 0.10; beta <- 0.85
  h <- numeric(n); r <- numeric(n)
  h[1] <- omega / (1 - alpha - beta)
  r[1] <- sqrt(h[1]) * rnorm(1)
  for (i in 2:n) {
    h[i] <- omega + alpha * r[i - 1]^2 + beta * h[i - 1]
    r[i] <- sqrt(h[i]) * rnorm(1)
  }

  # Markov regime switching
  P <- matrix(c(0.98, 0.02,
                0.04, 0.96), nrow = 2, byrow = TRUE)
  s <- integer(n); s[1] <- 1L
  for (i in 2:n) s[i] <- sample.int(2L, 1L, prob = P[s[i - 1], ])
  regime <- c(0, 4)[s] + rnorm(n, 0, c(1, 2.5)[s])

  # Level shift
  break_ <- 20 + 8 * (t > round(0.55 * n)) + rnorm(n, 0, 1.5)

  # Poisson counts
  counts <- rpois(n, exp(2 + 0.5 * sin(year) + 0.3 * sin(week)))

  # AR(1) with additive outliers
  outliers <- as.numeric(arima.sim(list(ar = 0.7), n = n))
  idx <- sample.int(n, max(1L, round(0.01 * n)))
  outliers[idx] <- outliers[idx] + sample(c(-1, 1), length(idx), replace = TRUE) * runif(length(idx), 6, 10)

  data.frame(
    date = dates, rw = rw, ar1 = ar1, seasonal = seasonal, garch = r,
    regime = regime, break_ = break_, counts = counts, outliers = outliers
  )
}

# ---- Helpers ----------------------------------------------------------------

INK    <- "#1d3557"
ACCENT <- "#d1603d"

hline <- function(y) {
  list(type = "line", xref = "paper", x0 = 0, x1 = 1, y0 = y, y1 = y,
       line = list(color = ACCENT, dash = "dash", width = 1))
}

fmt <- function(x) formatC(x, format = "f", digits = 2, big.mark = ",")

# ---- UI ---------------------------------------------------------------------

ui <- page_sidebar(
  title = "Time series explorer",
  theme = bs_theme(version = 5, primary = INK),
  sidebar = sidebar(
    width = 320,
    selectInput("series", "Series", choices = series_choices, selected = "rw"),
    textOutput("desc"),
    dateRangeInput("dates", "Date range", start = START, end = END,
                   min = START, max = END, weekstart = 1),
    sliderInput("ma", "Moving average window (days)", min = 1, max = 90,
                value = 1, step = 1),
    helpText("A window of 1 turns the moving average off."),
    hr(),
    numericInput("seed", "Random seed", value = 1, min = 1, step = 1),
    actionButton("reseed", "Simulate new data", class = "btn-outline-primary")
  ),
  layout_columns(
    fill = FALSE,
    value_box("Mean",    textOutput("v_mean")),
    value_box("Std. dev.", textOutput("v_sd")),
    value_box("Min",     textOutput("v_min")),
    value_box("Max",     textOutput("v_max"))
  ),
  navset_card_tab(
    nav_panel("Time series",     plotly::plotlyOutput("ts_plot", height = "100%")),
    nav_panel("Distribution",    plotly::plotlyOutput("hist_plot", height = "100%")),
    nav_panel("Autocorrelation", plotly::plotlyOutput("acf_plot", height = "100%"))
  )
)

# ---- Server -----------------------------------------------------------------

server <- function(input, output, session) {

  observeEvent(input$reseed, {
    updateNumericInput(session, "seed", value = sample.int(10000L, 1L))
  })

  sim <- reactive({
    seed <- input$seed
    req(is.numeric(seed), !is.na(seed))
    simulate_series(seed = as.integer(seed))
  })

  dat <- reactive({
    req(input$series, input$dates)
    d <- sim()
    keep <- d$date >= input$dates[1] & d$date <= input$dates[2]
    validate(need(sum(keep) > 10, "Select a longer date range."))
    data.frame(date = d$date[keep], value = d[[input$series]][keep])
  })

  output$desc <- renderText(series_info[[input$series]]$desc)

  output$v_mean <- renderText(fmt(mean(dat()$value)))
  output$v_sd   <- renderText(fmt(sd(dat()$value)))
  output$v_min  <- renderText(fmt(min(dat()$value)))
  output$v_max  <- renderText(fmt(max(dat()$value)))

  output$ts_plot <- plotly::renderPlotly({
    d <- dat()
    k <- input$ma
    p <- plotly::plot_ly(d, x = ~date, y = ~value, type = "scatter", mode = "lines",
                 name = "Series", line = list(color = INK, width = 1.2))
    if (k > 1) {
      d$ma <- as.numeric(stats::filter(d$value, rep(1 / k, k), sides = 1))
      p <- p |> plotly::add_lines(data = d, x = ~date, y = ~ma,
                           name = paste0(k, "-day average"),
                           line = list(color = ACCENT, width = 2.5))
    }
    p |> plotly::layout(
      xaxis = list(title = ""),
      yaxis = list(title = ""),
      hovermode = "x unified",
      legend = list(orientation = "h", y = -0.12)
    )
  })

  output$hist_plot <- plotly::renderPlotly({
    plotly::plot_ly(dat(), x = ~value, type = "histogram",
            marker = list(color = INK, line = list(color = "white", width = 0.5))) |>
      plotly::layout(xaxis = list(title = "Value"), yaxis = list(title = "Count"),
             bargap = 0.02)
  })

  output$acf_plot <- plotly::renderPlotly({
    d  <- dat()
    a  <- acf(d$value, lag.max = 40, plot = FALSE)
    df <- data.frame(lag = as.numeric(a$lag)[-1], acf = as.numeric(a$acf)[-1])
    ci <- 1.96 / sqrt(nrow(d))
    plotly::plot_ly(df, x = ~lag, y = ~acf, type = "bar",
            marker = list(color = INK)) |>
      plotly::layout(xaxis = list(title = "Lag (days)"),
             yaxis = list(title = "ACF", range = c(-1, 1)),
             shapes = list(hline(ci), hline(-ci)))
  })
}

shinyApp(ui, server)
