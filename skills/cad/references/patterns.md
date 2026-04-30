# Patterns & Best Practices

## Always Parametric

Define dimensions as variables at the top. Never hardcode dimensions inline:

```python
# GOOD
width = 80.0
height = 60.0
thickness = 10.0
hole_d = 22.0
fillet_r = 2.0

result = (
    cq.Workplane("XY")
    .box(width, height, thickness)
    .faces(">Z").workplane()
    .hole(hole_d)
    .edges("|Z").fillet(fillet_r)
)
```

## Point Arrays for Repeated Features

```python
# Rectangular array of holes
result = (
    cq.Workplane("XY")
    .box(40, 40, 5)
    .faces(">Z").workplane()
    .rarray(10, 10, 3, 3)         # 3x3 grid, 10mm spacing
    .hole(3)
)

# Polar array of holes
result = (
    cq.Workplane("XY")
    .cylinder(5, 20)
    .faces(">Z").workplane()
    .polarArray(15, 0, 360, 6)    # 6 holes on radius 15
    .hole(3)
)

# Arbitrary point placement
result = (
    cq.Workplane("XY")
    .box(40, 40, 5)
    .faces(">Z").workplane()
    .pushPoints([(5,5), (-5,5), (0,-7)])
    .hole(3)
)
```

## Construction Geometry for Feature Placement

```python
result = (
    cq.Workplane("XY")
    .box(80, 60, 10)
    .faces(">Z").workplane()
    .rect(60, 40, forConstruction=True)    # invisible guide rectangle
    .vertices()                             # select its 4 corners
    .cboreHole(2.4, 4.4, 2.1)             # hole at each corner
)
```

## Tagging for Complex Models

```python
result = (
    cq.Workplane("XY")
    .box(20, 20, 10)
    .faces(">Z").workplane().tag("top")
    .hole(5)
    .workplaneFromTagged("top")
    .rect(15, 15, forConstruction=True)
    .vertices()
    .hole(2)
)
```

## Reusable Part Functions

```python
def make_mounting_plate(width, height, thickness, hole_d, hole_spacing):
    """Parametric mounting plate with corner holes."""
    return (
        cq.Workplane("XY")
        .box(width, height, thickness)
        .faces(">Z").workplane()
        .rect(width - hole_spacing, height - hole_spacing, forConstruction=True)
        .vertices()
        .cboreHole(hole_d, hole_d * 1.8, thickness * 0.3)
        .edges("|Z").fillet(thickness * 0.2)
    )
```

## Shell Then Add Features

When making enclosures, shell first, then add mounting features:

```python
result = (
    cq.Workplane("XY")
    .box(40, 30, 20)
    .faces(">Z").shell(-2)                 # hollow out, keep top open
    .faces("<Z[1]").workplane()            # select interior bottom
    .rarray(10, 10, 2, 2)
    .circle(2).extrude(5)                  # add mounting posts
)
```
