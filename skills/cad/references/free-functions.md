# Free Function API

The `cadquery.func` module provides a functional alternative to the Fluent API. Functions return shapes directly without method chaining.

## Primitives

```python
from cadquery.func import box, cylinder, sphere, cone, segment, circle, rect, plane, compound

b = box(1, 2, 3)                   # Solid box
c = cylinder(radius=1, height=2)   # Solid cylinder
s = sphere(1)                      # Solid sphere
cn = cone(1, 1.5)                  # Solid cone

e = segment((0, 0), (0, 1))       # Edge (line segment)
cr = circle(1)                     # Wire (circle)
r = rect(1, 0.5)                  # Wire (rectangle)
f = plane(1, 1.5)                 # Face (rectangle)
```

## Moving and Placing

```python
b = box(1, 1, 1)
b_moved = b.move(x=2)             # move by offset
b_at = b.move(x=2, y=3, z=1)     # move to position

# Multiple placements at once
s = sphere(1).moved((0, -1, 0), (0, 1, 0))

# Compound from multiple shapes
result = compound(b, s.move(x=3))
```

## Boolean Operations with Operators

```python
c1 = cylinder(1, 2)
c2 = cylinder(0.5, 3)

union        = c1 + c2    # fuse
difference   = c1 - c2    # cut
intersection = c1 * c2    # intersect
split        = c1 / plane(2, 2).move(z=1)  # split
```

## Shape Construction (Bottom-Up)

```python
from cadquery.func import segment, circle, wire, face, solid, extrude, fill

# Wire from edges
w = wire(segment((0,0), (1,0)), segment((1,0), (1,1)))

# Face from wire
f = face(circle(1))

# Face with holes
r = rect(1, 0.5)
f_with_holes = face(r, circle(0.2).moved(0.2))  # outer wire + inner holes

# Extrude wire -> shell, face -> solid
shell = extrude(r, (0, 0, 2))           # wire extrusion -> shell surface
s = extrude(fill(r), (0, 0, 1))          # face extrusion -> solid
```

## Operations

```python
from cadquery.func import rect, circle, face, spline, extrude, sweep, loft, revolve, fill

r = rect(1, 0.5)
f = face(r)
path = spline([(0,0,0), (0,-1,2)], [(0,0,1), (0,-1,1)])

# Sweep along path
s1 = sweep(r, path)          # wire sweep -> shell
s2 = sweep(f, path)          # face sweep -> solid

# Loft between profiles
s3 = loft(r, circle(0.2).moved(z=2))           # open loft
s4 = loft(r, circle(0.2).moved(z=1), cap=True) # capped loft

# Revolve
s5 = revolve(fill(r), (0.5, 0, 0), (0, 1, 0), 90)
```

## Mixing with Fluent API

```python
import cadquery as cq
from cadquery.func import box

solid_box = box(10, 10, 10)
result = cq.Workplane(obj=solid_box).faces(">Z").circle(2).cutThruAll()
```
