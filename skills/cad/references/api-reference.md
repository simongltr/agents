# API Quick Reference

## Workplane — 2D Drawing

| Method | Description |
|--------|-------------|
| `moveTo(x, y)` | Move cursor without drawing |
| `move(dx, dy)` | Relative move without drawing |
| `lineTo(x, y)` | Line to absolute point |
| `line(dx, dy)` | Line by relative offset |
| `hLine(d)` / `vLine(d)` | Horizontal/vertical line |
| `hLineTo(x)` / `vLineTo(y)` | Horizontal/vertical to coordinate |
| `polarLine(d, angle)` | Line at angle |
| `rect(w, h)` | Rectangle |
| `circle(r)` | Circle |
| `ellipse(rx, ry)` | Ellipse |
| `slot2D(length, d)` | Slot/stadium shape |
| `regularPolygon(r, n)` | Regular polygon |
| `polyline(pts)` | Polyline through points |
| `spline(pts)` | Spline through points |
| `bezier(pts)` | Bezier curve |
| `threePointArc(p1, p2)` | Arc through 3 points |
| `sagittaArc(end, sag)` | Arc by sagitta |
| `radiusArc(end, r)` | Arc by radius |
| `tangentArcPoint(end)` | Tangent arc |
| `close()` | Close wire to start point |
| `mirrorX()` / `mirrorY()` | Mirror pending edges |
| `offset2D(d)` | Offset wires |

## Workplane — 3D Operations

| Method | Description |
|--------|-------------|
| `extrude(d)` | Linear extrusion |
| `cutBlind(d)` | Cut into solid |
| `cutThruAll()` | Cut through entire solid |
| `revolve(angle)` | Revolve around axis |
| `sweep(path)` | Sweep along path |
| `loft()` | Loft between profiles |
| `twistExtrude(d, angle)` | Twisted extrusion |
| `box(l, w, h)` | Box primitive |
| `sphere(r)` | Sphere primitive |
| `cylinder(h, r)` | Cylinder primitive |
| `hole(d)` | Through hole |
| `cboreHole(d, cd, cdepth)` | Counterbore hole |
| `cskHole(d, cd, angle)` | Countersink hole |
| `shell(t)` | Hollow out solid |
| `fillet(r)` | Round selected edges |
| `chamfer(l)` | Bevel selected edges |
| `union(other)` | Boolean add |
| `cut(other)` | Boolean subtract |
| `intersect(other)` | Boolean intersect |
| `text(txt, size, d)` | 3D text |
| `translate(vec)` | Move solid |
| `rotate(start, end, angle)` | Rotate solid |
| `mirror(plane)` | Mirror solid |

## Workplane — Selection & Navigation

| Method | Description |
|--------|-------------|
| `faces(sel)` | Select faces |
| `edges(sel)` | Select edges |
| `vertices(sel)` | Select vertices |
| `wires(sel)` | Select wires |
| `solids(sel)` | Select solids |
| `workplane()` | New workplane on selection |
| `center(x, y)` | Shift workplane origin |
| `transformed(rotate, offset)` | Transform workplane |
| `tag(name)` | Tag current state |
| `workplaneFromTagged(name)` | Return to tagged state |
| `end()` | Go back one chain step |
| `val()` / `vals()` | Get underlying objects |

## Workplane — Point Arrays

| Method | Description |
|--------|-------------|
| `rarray(xs, ys, nx, ny)` | Rectangular array |
| `polarArray(r, start, span, n)` | Polar array |
| `pushPoints(pts)` | Arbitrary points |

## Sketch Methods

| Method | Description |
|--------|-------------|
| `rect(w, h)` | Rectangle |
| `circle(r)` | Circle |
| `ellipse(a, b)` | Ellipse |
| `trapezoid(w, h, a)` | Trapezoid |
| `slot(w, h)` | Slot shape |
| `regularPolygon(r, n)` | Regular polygon |
| `polygon(pts)` | Polygon from points |
| `segment(p1, p2)` | Line segment |
| `arc(...)` | Arc |
| `spline(pts)` | Spline |
| `assemble()` | Edges to face |
| `fillet(r)` | Fillet selected vertices |
| `chamfer(d)` | Chamfer selected vertices |
| `rarray(xs, ys, nx, ny)` | Rectangular array |
| `parray(r, a1, da, n)` | Polar array |
| `finalize()` | Return to parent Workplane |

## Assembly Methods

| Method | Description |
|--------|-------------|
| `Assembly(obj, loc, name, color)` | Create assembly |
| `.add(obj, name, loc, color)` | Add part |
| `.constrain(q1, q2, kind, param)` | Add constraint |
| `.solve()` | Solve constraints |
| `.save(path)` | Export to file |

## Common Import

```python
import cadquery as cq
from cadquery import Vector, Location, Color, Assembly
```
