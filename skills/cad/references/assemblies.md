# Assemblies

Assemblies combine multiple parts with positioning and constraints.

## Basic Assembly (Explicit Locations)

```python
import cadquery as cq

base = cq.Workplane("XY").box(20, 20, 5)
peg = cq.Workplane("XY").cylinder(10, 3)

assy = (
    cq.Assembly()
    .add(base, name="base", color=cq.Color("gray"))
    .add(peg, name="peg",
         loc=cq.Location((0, 0, 7.5)),
         color=cq.Color("red"))
)

assy.save("assembly.step")
```

## Location Objects

```python
cq.Location((x, y, z))                          # translation only
cq.Location((x, y, z), (ax, ay, az), angle)     # translation + rotation
cq.Location(cq.Vector(x, y, z))                 # from Vector
```

## Constrained Assembly

```python
base = cq.Workplane("XY").box(20, 20, 5)
lid = cq.Workplane("XY").box(20, 20, 2)

assy = (
    cq.Assembly()
    .add(base, name="base")
    .add(lid, name="lid")
    .constrain("base@faces@>Z", "lid@faces@<Z", "Plane")
    .solve()
)
```

## Constraint Selector Syntax

```
"part_name@faces@>Z"       — select the top face of part_name
"part_name@edges@|Z"       — select vertical edges of part_name
"part_name@vertices@>(1,1,1)" — select vertex nearest (1,1,1)
"part_name?tag_name"       — select tagged geometry on part_name
```

## Constraint Types

| Constraint | Description | `param` default |
|------------|-------------|-----------------|
| `"Point"` | Coincident points (or specified distance apart) | 0 |
| `"Axis"` | Anti-parallel normals (mate) or specified angle | 180 (degrees) |
| `"Plane"` | Point + Axis combined (full mate) | 180 (degrees) |
| `"PointInPlane"` | Point lies in specified plane | 0 (offset) |
| `"PointOnLine"` | Point lies on specified line | 0 |
| `"FixedPoint"` | Lock position to `(x, y, z)` | required |
| `"FixedRotation"` | Lock rotation to `(rx, ry, rz)` degrees | required |
| `"FixedAxis"` | Lock axis direction to vector | required |
| `"Fixed"` | Lock all degrees of freedom | none |

## Tagging for Constraints

```python
# Tag features on parts BEFORE adding to assembly
base = cq.Workplane("XY").box(20, 20, 5)
base.faces(">Z").tag("top")
base.faces("<Z").tag("bottom")

lid = cq.Workplane("XY").box(20, 20, 2)
lid.faces("<Z").tag("mate_face")

assy = (
    cq.Assembly()
    .add(base, name="base")
    .add(lid, name="lid")
    .constrain("base?top", "lid?mate_face", "Plane")
    .solve()
)
```

## Colors

```python
cq.Color("red")                  # named color (700+ names supported)
cq.Color(1, 0, 0)               # RGB floats (0-1)
cq.Color(0, 0, 1, 0.5)          # RGBA with transparency
```
