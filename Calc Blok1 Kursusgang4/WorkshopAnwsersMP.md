# Workshop, Blok 1: Potentialstrømning — Answers (teacher's version)

> Notation used throughout:
> - $v = v_1\,\mathbf i + v_2\,\mathbf j$ is the velocity field.
> - Short-hand: $\rho := x^2 + y^2$ (so $\rho = r^2$). This makes the derivatives much easier to read.
> - Subscripts mean partial derivatives: $\varphi_x = \frac{\partial \varphi}{\partial x}$, $\varphi_{xy} = \frac{\partial^2 \varphi}{\partial y\,\partial x}$.

**The four conditions we need to check (the "checklist"):**

| Eq. | Name | Formula | Meaning |
|---|---|---|---|
| (2) | Rotation-free | $\dfrac{\partial v_1}{\partial y} = \dfrac{\partial v_2}{\partial x}$ | the water does not swirl |
| (3) | Incompressible | $\dfrac{\partial v_1}{\partial x} + \dfrac{\partial v_2}{\partial y} = 0$ | water cannot be squeezed |
| (4) | Far-field | $v \to U\,\mathbf i$ far away | far away it flows straight right with speed $U$ |
| (5) | Wall condition | $v\cdot n = 0$ when $r = R$ | no water goes through the cylinder wall |

Tasks 1.4–1.7 are just ticking off this checklist one at a time.

---

## Delopgave 1

### 1.1 — The cylinder boundary is $r = R$, $0 \le \theta \le 2\pi$

**Step 1. What is $r$?** Compute the distance from $(x,y)$ to the origin:
$$
x^2 + y^2 = r^2\cos^2\theta + r^2\sin^2\theta = r^2(\underbrace{\cos^2\theta + \sin^2\theta}_{=1}) = r^2
\quad\Rightarrow\quad r = \sqrt{x^2+y^2}.
$$
So $r$ **is** the distance to the origin.

**Step 2. What is the boundary?** The cylinder has centre $(0,0)$ and radius $R$. Its boundary is all points at distance exactly $R$ from the origin, i.e. $r = R$.

**Step 3. What does $\theta$ do?** With $r = R$ fixed, the point $(R\cos\theta, R\sin\theta)$ walks around the circle. $\theta = 0$ is the point $(R,0)$, and one full turn is $\theta$ going from $0$ to $2\pi$.

**Conclusion:** boundary = $\{(R\cos\theta, R\sin\theta) : 0 \le \theta \le 2\pi\}$. ✅

> Teaching tip: draw the circle, mark a point, draw $r$ as the line to the origin and $\theta$ as the angle from the x-axis.

---

### 1.2 — The normal vector is $n(\theta) = \cos\theta\,\mathbf i + \sin\theta\,\mathbf j$

**Step 1. Use a geometric fact about circles:** the radius always meets the circle at a right angle. So the vector from the centre to the boundary point points straight *out* of the circle; it is a normal vector:
$$
\text{(point)} - \text{(centre)} = R\cos\theta\,\mathbf i + R\sin\theta\,\mathbf j.
$$

**Step 2. Make it a unit vector** by dividing by its length $R$:
$$
n(\theta) = \cos\theta\,\mathbf i + \sin\theta\,\mathbf j, \qquad |n| = \sqrt{\cos^2\theta+\sin^2\theta} = 1.
$$
$R$ cancelled out, so $n$ **only depends on $\theta$**. ✅

**Step 3 (optional check).** The tangent to the circle is the derivative of the position in $\theta$:
$$
T(\theta) = \frac{d}{d\theta}(R\cos\theta, R\sin\theta) = (-R\sin\theta,\; R\cos\theta).
$$
$$
T\cdot n = -R\sin\theta\cos\theta + R\cos\theta\sin\theta = 0. 
$$
So $n$ really is perpendicular to the boundary. ✅

---

### 1.3 — Why the wall condition is $v(R\cos\theta, R\sin\theta)\cdot n(\theta) = 0$

**Step 1.** "Water can't go in or out of the cylinder" means: at the wall, the velocity must point **along** the wall (tangent), never through it.

**Step 2.** Tangent to the wall $\iff$ perpendicular to the normal $n$.

**Step 3.** Two vectors are perpendicular exactly when their dot product is $0$:
$$
v \perp n \iff v\cdot n = 0.
$$

**Step 4.** "At the wall" means $r = R$, i.e. evaluate $v$ at the point $(R\cos\theta, R\sin\theta)$. That gives Eq. (5). ✅

> Intuition: $v\cdot n$ = "how much of the velocity points straight through the wall". It must be zero.

---

### 1.4 — Compute $v = \nabla\varphi$ and check the far-field (Eq. 4)

Given
$$
\varphi(x,y) = Ux\left(1 + \frac{R^2}{x^2+y^2}\right) = Ux + UR^2\,\frac{x}{\rho}, \qquad \rho = x^2+y^2.
$$
Useful: $\dfrac{\partial\rho}{\partial x} = 2x$, $\dfrac{\partial\rho}{\partial y} = 2y$.

**Step 1. $v_1 = \partial\varphi/\partial x$.** The first term gives $U$. For $\frac{x}{\rho}$ use the quotient rule:
$$
\frac{\partial}{\partial x}\left(\frac{x}{\rho}\right) = \frac{1\cdot\rho - x\cdot 2x}{\rho^2} = \frac{1}{\rho} - \frac{2x^2}{\rho^2}.
$$
So
$$
v_1 = U + \frac{UR^2}{\rho} - \frac{2UR^2x^2}{\rho^2}
= U\left(1+\frac{R^2}{x^2+y^2}\right) - \frac{2Ux^2R^2}{(x^2+y^2)^2}. 
$$

**Step 2. $v_2 = \partial\varphi/\partial y$.** $Ux$ has no $y$, so it gives $0$. In $\frac{x}{\rho}$ only $\rho$ depends on $y$:
$$
\frac{\partial}{\partial y}\left(x\,\rho^{-1}\right) = x\cdot(-1)\rho^{-2}\cdot 2y = -\frac{2xy}{\rho^2}.
$$
So
$$
v_2 = -\frac{2UR^2xy}{(x^2+y^2)^2}.
$$
This matches the given $v(x,y)$. ✅

**Step 3. Far-field (Eq. 4).** "Far away" means $\rho = x^2+y^2 \to \infty$. Look at each extra term:
- $\dfrac{R^2}{\rho} \to 0$.
- $\dfrac{x^2}{\rho^2} = \dfrac{x^2}{\rho}\cdot\dfrac{1}{\rho} \le 1\cdot\dfrac1\rho \to 0$ (because $x^2 \le x^2+y^2 = \rho$).
- $\dfrac{|xy|}{\rho^2} \le \dfrac{\tfrac12\rho}{\rho^2} = \dfrac{1}{2\rho} \to 0$ (because $|xy| \le \tfrac12(x^2+y^2)$).

So $v_1 \to U$ and $v_2 \to 0$, i.e. $v \to U\,\mathbf i = v_\infty$. ✅

> Quick way to say it in class: every extra term is "length² over length⁴" $\sim 1/r^2$, so it dies far away.

---

### 1.5 — Polar form and the wall condition (Eq. 5)

**Step 1. Insert $x = r\cos\theta,\ y = r\sin\theta$.** We know $x^2+y^2 = r^2$, so
$$
\Phi(r,\theta) = U\,r\cos\theta\left(1 + \frac{R^2}{r^2}\right). \tag{6}
$$
✅

**Step 2. Chain rule.** $\Phi(r,\theta) = \varphi(x(r,\theta),\, y(r,\theta))$, so
$$
\frac{\partial\Phi}{\partial r} = \frac{\partial\varphi}{\partial x}\frac{\partial x}{\partial r} + \frac{\partial\varphi}{\partial y}\frac{\partial y}{\partial r}.
$$
Now fill in the pieces:
- $\dfrac{\partial\varphi}{\partial x} = v_1$, $\dfrac{\partial\varphi}{\partial y} = v_2$ (because $v = \nabla\varphi$),
- $\dfrac{\partial x}{\partial r} = \cos\theta$, $\dfrac{\partial y}{\partial r} = \sin\theta$.

So
$$
\frac{\partial\Phi}{\partial r} = v_1\cos\theta + v_2\sin\theta = (v_1,v_2)\cdot(\cos\theta,\sin\theta) = v\cdot n.
$$
**Key insight:** "$v\cdot n$" is just "$\partial\Phi/\partial r$". So instead of a messy dot product we only need one derivative in $r$.

**Step 3. Differentiate Eq. (6) in $r$.** First rewrite: $\Phi = U\cos\theta\left(r + \dfrac{R^2}{r}\right)$. Then ($\theta$ is constant):
$$
\frac{\partial\Phi}{\partial r} = U\cos\theta\left(1 - \frac{R^2}{r^2}\right).
$$

**Step 4. Put $r = R$:**
$$
\frac{\partial\Phi}{\partial r}\Big|_{r=R} = U\cos\theta\,(1 - 1) = 0.
$$
So $v\cdot n = 0$ on the wall, which is Eq. (5). ✅

---

### 1.6 — Mixed partials are equal ⇒ rotation-free (Eq. 2)

**Step 1. Why $\varphi_{xy} = \varphi_{yx}$?** Clairaut's/Schwarz's theorem: if the second partial derivatives are continuous, the order of differentiation doesn't matter. Here $\varphi$ is built from polynomials divided by $\rho = x^2+y^2$, which is never $0$ in our region ($\sqrt{x^2+y^2} \ge R > 0$). So all derivatives are continuous there. ✅

**Step 2. Use it.**
$$
\frac{\partial v_1}{\partial y} = \frac{\partial}{\partial y}\left(\frac{\partial\varphi}{\partial x}\right) = \frac{\partial^2\varphi}{\partial y\,\partial x}
= \frac{\partial^2\varphi}{\partial x\,\partial y} = \frac{\partial}{\partial x}\left(\frac{\partial\varphi}{\partial y}\right) = \frac{\partial v_2}{\partial x}.
$$
That is Eq. (2). ✅

**Step 3 (optional: check by direct computation).**
$$
\frac{\partial v_1}{\partial y} = -\frac{2UR^2y}{\rho^2} + \frac{8UR^2x^2y}{\rho^3} = \frac{2UR^2y\,(3x^2 - y^2)}{\rho^3},
$$
$$
\frac{\partial v_2}{\partial x} = -2UR^2y\cdot\frac{\rho^2 - x\cdot 2\rho\cdot 2x}{\rho^4} = -2UR^2y\cdot\frac{\rho - 4x^2}{\rho^3} = \frac{2UR^2y\,(3x^2-y^2)}{\rho^3}.
$$
Same. ✅

---

### 1.7 — Incompressible (Eq. 3)

**Step 1. $\partial v_1/\partial x$.** Write $v_1 = U + UR^2\rho^{-1} - 2UR^2\,x^2\rho^{-2}$ and differentiate term by term:
- $U \;\to\; 0$
- $UR^2\rho^{-1} \;\to\; UR^2\cdot(-1)\rho^{-2}\cdot 2x = -\dfrac{2UR^2x}{\rho^2}$
- $-2UR^2\,x^2\rho^{-2}$: product rule:
  $-2UR^2\left[2x\,\rho^{-2} + x^2\cdot(-2)\rho^{-3}\cdot 2x\right] = -\dfrac{4UR^2x}{\rho^2} + \dfrac{8UR^2x^3}{\rho^3}$

Add:
$$
\frac{\partial v_1}{\partial x} = -\frac{6UR^2x}{(x^2+y^2)^2} + \frac{8UR^2x^3}{(x^2+y^2)^3}. 
$$
✅

**Step 2. $\partial v_2/\partial y$.** $v_2 = -2UR^2\,xy\,\rho^{-2}$, product rule in $y$:
$$
\frac{\partial v_2}{\partial y} = -2UR^2x\left[\rho^{-2} + y\cdot(-2)\rho^{-3}\cdot 2y\right]
= -\frac{2UR^2x}{(x^2+y^2)^2} + \frac{8UR^2xy^2}{(x^2+y^2)^3}.
$$
✅

**Step 3. Add them:**
$$
\frac{\partial v_1}{\partial x} + \frac{\partial v_2}{\partial y}
= -\frac{8UR^2x}{\rho^2} + \frac{8UR^2x\,(x^2+y^2)}{\rho^3}
= -\frac{8UR^2x}{\rho^2} + \frac{8UR^2x\,\rho}{\rho^3}
= -\frac{8UR^2x}{\rho^2} + \frac{8UR^2x}{\rho^2} = 0.
$$
The trick: $x^3 + xy^2 = x(x^2+y^2) = x\rho$. So Eq. (3) holds. ✅

**Maple version (if students want to check):**
```maple
phi := U*x*(1 + R^2/(x^2+y^2)):
v1 := diff(phi, x):  v2 := diff(phi, y):
simplify(diff(v1, x));  simplify(diff(v2, y));
simplify(diff(v1, x) + diff(v2, y));   # -> 0  (Eq. 3)
simplify(diff(v1, y) - diff(v2, x));   # -> 0  (Eq. 2)
```

**Checklist complete:** (2) ✅ (1.6), (3) ✅ (1.7), (4) ✅ (1.4), (5) ✅ (1.5).
So $v = \nabla\varphi$ really describes water flowing around the cylinder.

---

### 1.8 — The Python code

What each block does:

| Lines | What happens |
|---|---|
| 1–3 | Load `numpy` (numbers/arrays) and `matplotlib` (plotting). |
| 5–14 | Make an $N\times N = 25\times 25$ grid of points in the square $[-2,2]\times[-2,2]$. `x[i,j]`, `y[i,j]` are the coordinates of grid point $(i,j)$. |
| 16–20 | Choose $U$, $R$ and compute $\varphi$ at every grid point. |
| 22–24 | `np.gradient` approximates the partial derivatives of $\varphi$ **numerically** (finite differences), so we get $\nabla\varphi = v$ without doing calculus. `fart` = speed $= \lvert v\rvert$. |
| 26–33 | Points inside the cylinder ($r \le R$) have no water, so the arrows there are set to `nan` (= "don't draw"). `nan` is used instead of `0` because `0` would still draw a tiny dot. |
| 36–44 | `quiver` draws an arrow at every grid point, coloured by the speed. |

> ⚠️ **Heads-up for the teacher: there is a bug on line 23.**
> `np.gradient(phi)` returns the derivatives **in array-axis order**: first along axis 0 (rows = the **y**-direction for a `meshgrid`), then along axis 1 (columns = the **x**-direction).
> So `v, w = np.gradient(phi)` actually gives `v` $=\partial\varphi/\partial y$ and `w` $=\partial\varphi/\partial x$ — the components are swapped. Far from the cylinder the arrows would point **up** instead of to the right.
> **Fix:**
> ```python
> w, v = np.gradient(phi)   # w = dphi/dy, v = dphi/dx
> ```
> (A nice discussion question: "Does the plot satisfy Eq. 4? Why not?")
> Also note: `np.gradient` doesn't know the grid spacing, so the arrow lengths are scaled by a constant $\Delta x = 4/24$. The directions and colours are still fine. Passing the spacing (`np.gradient(phi, dy, dx)` with `dx = dy = (x_end - x_start)/(N-1)`) gives the real speeds.
> The origin $(0,0)$ is a grid point, so $\varphi$ divides by 0 there (a warning). It's inside the cylinder and masked anyway.

**Things to try / observe:**
- **Change $U$:** same picture, all arrows scale by $U$. The colour bar changes, the shape doesn't. (Every term of $v$ has a factor $U$.)
- **Change $R$:** a bigger hole means the flow bends earlier and more strongly.
- **Where is the water fastest?** At the top and bottom of the cylinder, $\theta = \pm\pi/2$. There the speed is $2U$, double the far-field speed. (On $r=R$: $\partial\Phi/\partial r = 0$ and $\frac1r\frac{\partial\Phi}{\partial\theta} = -2U\sin\theta$, so the speed is $2U\lvert\sin\theta\rvert$.)
- **Where is it slowest?** At the front and back points $(\pm R, 0)$, where $v = 0$. These are the *stagnation points*.

---

## Delopgave 2

Setting: $v = \nabla\varphi$ ("conservative", and $\varphi$ is called the potential).

### 2.1 — Conservative ⇒ rotation-free

Exactly the same argument as 1.6:
$$
\frac{\partial v_1}{\partial y} = \frac{\partial^2\varphi}{\partial y\,\partial x} \overset{\text{Clairaut}}{=} \frac{\partial^2\varphi}{\partial x\,\partial y} = \frac{\partial v_2}{\partial x}.
$$
(We assume $\varphi$ has continuous second partial derivatives.) ✅

---

**Now the converse.** Suppose $v$ is rotation-free on all of $\mathbb R^2$ (no holes). Define
$$
\varphi(x,y) := \int_0^x v_1(t,y)\,dt + \int_0^y v_2(0,s)\,ds.
$$
> Intuition: walk from $(0,0)$ **up** the y-axis to $(0,y)$, then **right** to $(x,y)$, and add up "velocity along the path". (This is the "integrate $v$ along a path" idea, like work = force · distance.)

### 2.2 — Show $\partial\varphi/\partial x = v_1$

**Step 1.** The second integral $\int_0^y v_2(0,s)\,ds$ does **not** contain $x$, so its $x$-derivative is $0$.

**Step 2.** The first integral is a function of its upper limit $x$. By the **fundamental theorem of calculus** ($\frac{d}{dx}\int_0^x f(t)\,dt = f(x)$), with $y$ held fixed:
$$
\frac{\partial}{\partial x}\int_0^x v_1(t,y)\,dt = v_1(x,y).
$$

**Conclusion:** $\dfrac{\partial\varphi}{\partial x}(x,y) = v_1(x,y) + 0 = v_1(x,y)$. ✅

---

### 2.3 — Show $\partial\varphi/\partial y = v_2$

Start from the given formula:
$$
\frac{\partial\varphi}{\partial y}(x,y) = \int_0^x \frac{\partial v_1}{\partial y}(t,y)\,dt + \frac{\partial}{\partial y}\int_0^y v_2(0,s)\,ds.
$$

**Step 1. Second term, by the fundamental theorem of calculus:**
$$
\frac{\partial}{\partial y}\int_0^y v_2(0,s)\,ds = v_2(0,y).
$$

**Step 2. First term: use rotation-free (Eq. 2)** to swap $\frac{\partial v_1}{\partial y}$ for $\frac{\partial v_2}{\partial x}$:
$$
\int_0^x \frac{\partial v_1}{\partial y}(t,y)\,dt = \int_0^x \frac{\partial v_2}{\partial t}(t,y)\,dt.
$$

**Step 3.** Now we integrate a derivative, so the fundamental theorem of calculus applies again ("integral of a derivative = difference of endpoint values"):
$$
\int_0^x \frac{\partial v_2}{\partial t}(t,y)\,dt = v_2(x,y) - v_2(0,y).
$$

**Step 4. Add the two terms:**
$$
\frac{\partial\varphi}{\partial y}(x,y) = v_2(x,y) - v_2(0,y) + v_2(0,y) = v_2(x,y).
$$
✅ Together with 2.2: $\nabla\varphi = v$, so **rotation-free (no holes) ⇒ conservative.**

> Why "no holes" matters: the path from $(0,0)$ to $(x,y)$ must stay inside the domain. Around the cylinder (a hole!) this can fail in general. That's why in Delopgave 1 we were *given* $\varphi$ instead of constructing it this way.

---

### 2.4 — Example: $v = -\sin x\,(e^y+e^{-y})\,\mathbf i + \cos x\,(e^y-e^{-y})\,\mathbf j$

**Step 1. Check rotation-free (Eq. 2).**
$$
\frac{\partial v_1}{\partial y} = -\sin x\,(e^y - e^{-y}), \qquad
\frac{\partial v_2}{\partial x} = -\sin x\,(e^y - e^{-y}).
$$
Equal ⇒ rotation-free ✅. The domain is all of $\mathbb R^2$ (no holes), so by 2.2–2.3 a potential exists.

**Step 2. Use the formula. First integral** ($y$ is a constant here):
$$
\int_0^x v_1(t,y)\,dt = -(e^y+e^{-y})\int_0^x \sin t\,dt = -(e^y+e^{-y})\big[-\cos t\big]_0^x = (e^y+e^{-y})(\cos x - 1).
$$

**Step 3. Second integral** (on the y-axis $x = 0$, so $\cos 0 = 1$):
$$
\int_0^y v_2(0,s)\,ds = \int_0^y (e^s - e^{-s})\,ds = \big[e^s + e^{-s}\big]_0^y = e^y + e^{-y} - 2.
$$

**Step 4. Add:**
$$
\varphi(x,y) = (e^y+e^{-y})\cos x - (e^y+e^{-y}) + (e^y+e^{-y}) - 2 = \boxed{\cos x\,(e^y+e^{-y}) - 2}
$$
(equivalently $2\cos x\cosh y - 2$).

**Step 5. Check (always do this!):**
$$
\frac{\partial\varphi}{\partial x} = -\sin x\,(e^y+e^{-y}) = v_1 \;✅, \qquad
\frac{\partial\varphi}{\partial y} = \cos x\,(e^y-e^{-y}) = v_2 \;✅
$$

**Step 6. Other potentials?** Yes: $\varphi + C$ for **any constant** $C$, because the gradient of a constant is $0$. For example $\varphi = \cos x\,(e^y+e^{-y})$ (with $C = 2$) works just as well.
And those are the **only** ones: if $\nabla\varphi_1 = \nabla\varphi_2$, then $\nabla(\varphi_1-\varphi_2) = 0$, so $\varphi_1 - \varphi_2$ is constant (on a connected domain like $\mathbb R^2$).

> Bonus: this flow is also incompressible: $\frac{\partial v_1}{\partial x} + \frac{\partial v_2}{\partial y} = -\cos x(e^y+e^{-y}) + \cos x(e^y+e^{-y}) = 0$. So it is a valid potential flow, just like the cylinder flow.
