# Complete Examples

## Bearing Pillow Block

```python
import cadquery as cq

height = 60.0
width = 80.0
thickness = 10.0
diameter = 22.0
padding = 12.0

result = (
    cq.Workplane("XY")
    .box(height, width, thickness)
    .faces(">Z").workplane()
    .hole(diameter)
    .faces(">Z").workplane()
    .rect(height - padding, width - padding, forConstruction=True)
    .vertices()
    .cboreHole(2.4, 4.4, 2.1)
    .edges("|Z").fillet(2.0)
)

cq.exporters.export(result, "pillow_block.step")
```

## Flanged Coupling

```python
import cadquery as cq

od = 40.0
bore_d = 12.0
flange_od = 60.0
flange_t = 5.0
hub_l = 20.0
bolt_circle_d = 50.0
bolt_d = 5.0
n_bolts = 6
keyway_w = 4.0
keyway_d = 2.5

result = (
    cq.Workplane("XY")
    .circle(od / 2)
    .extrude(hub_l)
    .faces(">Z").workplane()
    .circle(flange_od / 2)
    .extrude(flange_t)
    .faces(">Z").workplane()
    .hole(bore_d)
    .faces(">Z").workplane()
    .polarArray(bolt_circle_d / 2, 0, 360, n_bolts)
    .hole(bolt_d)
    .faces("<Z").workplane()
    .center(bore_d / 2 - keyway_d / 2, 0)
    .rect(keyway_d, keyway_w)
    .cutBlind(hub_l)
)
```

## Box Enclosure with Lid

```python
import cadquery as cq

length = 80
width = 50
height = 30
wall = 2.5
lip = 1.5
screw_d = 2.5
post_d = 6
corner_r = 3

# Bottom shell
bottom = (
    cq.Workplane("XY")
    .box(length, width, height)
    .edges("|Z").fillet(corner_r)
    .faces(">Z").shell(-wall)
    .faces("<Z").workplane(invert=True)
    .rect(length - post_d - wall*2, width - post_d - wall*2, forConstruction=True)
    .vertices()
    .circle(post_d / 2).extrude(height - wall)
    .faces(">Z").workplane()
    .rect(length - post_d - wall*2, width - post_d - wall*2, forConstruction=True)
    .vertices()
    .hole(screw_d)
)

# Lid
lid = (
    cq.Workplane("XY")
    .box(length, width, wall)
    .edges("|Z").fillet(corner_r)
    .faces("<Z").workplane()
    .rect(length - wall*2 - 0.3, width - wall*2 - 0.3)
    .extrude(lip)
    .faces(">Z").workplane()
    .rect(length - post_d - wall*2, width - post_d - wall*2, forConstruction=True)
    .vertices()
    .hole(screw_d + 0.5)
)
```

## Pipe Fitting (Revolve)

```python
import cadquery as cq

result = (
    cq.Workplane("XZ")
    .moveTo(10, 0)
    .lineTo(15, 0)
    .lineTo(15, 5)
    .lineTo(18, 5)
    .lineTo(18, 7)
    .lineTo(15, 7)
    .lineTo(15, 20)
    .lineTo(10, 20)
    .close()
    .revolve(360, (0, 0, 0), (0, 1, 0))
)
```

## Multi-Part Assembly

```python
import cadquery as cq

base = (
    cq.Workplane("XY")
    .box(40, 40, 5)
    .faces(">Z").workplane()
    .pushPoints([(10,10), (-10,10), (10,-10), (-10,-10)])
    .hole(4)
)
base.faces(">Z").tag("top")

column = cq.Workplane("XY").cylinder(30, 5)
column.faces("<Z").tag("bottom")
column.faces(">Z").tag("top")

cap = (
    cq.Workplane("XY")
    .cylinder(4, 8)
    .faces(">Z").fillet(3)
)
cap.faces("<Z").tag("bottom")

assy = (
    cq.Assembly()
    .add(base, name="base", color=cq.Color("gray"))
    .add(column, name="column", color=cq.Color("steelblue"))
    .add(cap, name="cap", color=cq.Color("firebrick"))
    .constrain("base?top", "column?bottom", "Plane")
    .constrain("column?top", "cap?bottom", "Plane")
    .constrain("base", "Fixed")
    .solve()
)

assy.save("monument.step")
```
