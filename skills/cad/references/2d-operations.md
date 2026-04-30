# 2D Drawing Operations

These operations draw on the current workplane, creating pending wires consumed by 3D operations.

## Primitive Shapes

```python
.rect(width, height)                           # centered rectangle
.rect(width, height, centered=False)           # corner-origin rectangle
.circle(radius)                                # centered circle
.ellipse(x_radius, y_radius)                   # centered ellipse
.slot2D(length, diameter)                       # slot (stadium) shape
.regularPolygon(radius, n_sides)               # regular polygon
.polygon([(x1,y1), (x2,y2), ...])             # arbitrary polygon (via Sketch)
```

## Line Drawing

```python
.moveTo(x, y)                 # move without drawing
.lineTo(x, y)                 # absolute line
.line(dx, dy)                  # relative line
.hLine(distance)               # horizontal line
.vLine(distance)               # vertical line
.hLineTo(x)                    # horizontal to x coordinate
.vLineTo(y)                    # vertical to y coordinate
.polarLine(distance, angle)    # line at angle
.close()                       # close the wire back to start
```

## Curves

```python
.threePointArc((x1,y1), (x2,y2))              # arc through 3 points (current + 2)
.sagittaArc((end_x, end_y), sag)               # arc by sagitta (bulge height)
.radiusArc((end_x, end_y), radius)             # arc by radius
.tangentArcPoint((end_x, end_y))               # arc tangent to previous edge
.spline([(x1,y1), (x2,y2), ...])              # spline through points
.spline(pts, tangents=[(dx1,dy1),(dx2,dy2)])   # spline with tangent control
.bezier([(x1,y1), (x2,y2), ...])              # bezier curve (control points)
```

## Construction Geometry

Construction geometry is used for positioning but is not part of the final solid:

```python
.rect(w, h, forConstruction=True)    # rectangle used only for point placement
.circle(r, forConstruction=True)     # circle used only for point placement
```

## Mirroring & Offset

```python
.mirrorX()    # mirror pending edges around X axis
.mirrorY()    # mirror pending edges around Y axis

.offset2D(distance)              # offset all wires outward (positive) or inward (negative)
.offset2D(distance, kind="arc")  # offset with arc corners (default)
.offset2D(distance, kind="intersection")  # sharp corners
```
