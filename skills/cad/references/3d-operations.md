# 3D Operations

## Primitives

```python
.box(length, width, height)                          # box centered on workplane
.box(length, width, height, centered=(True,True,False))  # box on workplane surface
.sphere(radius)                                       # sphere at each stack point
.cylinder(height, radius)                             # cylinder at each stack point
.wedge(dx, dy, dz, xmin, zmin, xmax, zmax)           # wedge/pyramid
```

## Extrusion

```python
.extrude(distance)                    # extrude pending wires by distance
.extrude(distance, both=True)         # extrude in both directions
.extrude(distance, taper=5)           # extrude with 5-degree taper
.extrude("next")                      # extrude until next face
.extrude("last")                      # extrude until last face
```

## Cutting

```python
.cutBlind(distance)                   # cut into solid by distance
.cutBlind(-distance)                  # cut in opposite direction
.cutBlind(distance, taper=5)          # tapered cut
.cutThruAll()                         # cut all the way through
.cut(other_solid)                     # boolean subtract another solid
```

## Holes

```python
.hole(diameter)                                          # through hole
.hole(diameter, depth)                                   # blind hole
.cboreHole(diameter, cboreDiameter, cboreDepth)          # counterbore hole
.cskHole(diameter, cskDiameter, cskAngle)                # countersink hole
.cskHole(diameter, cskDiameter, cskAngle, depth)         # blind countersink
```

## Loft, Sweep, Revolve

```python
# Loft — smooth transition between profiles on different workplanes
result = (
    cq.Workplane("XY")
    .rect(2, 2)       # bottom profile
    .workplane(offset=1)
    .circle(0.5)      # top profile
    .loft()            # loft between them
)

# Sweep — extrude a profile along a path
path = cq.Workplane("XZ").spline([(0,0), (1,2), (2,4)])
result = (
    cq.Workplane("XY")
    .circle(0.5)
    .sweep(path)
)

# Revolve — rotate a profile around an axis
result = (
    cq.Workplane("XZ")
    .moveTo(1, 0)
    .lineTo(2, 0)
    .lineTo(2, 1)
    .close()
    .revolve(360)                          # full revolution around Z
    .revolve(180, (0,0,0), (0,1,0))        # partial revolve, custom axis
)

# Twist extrude
result = (
    cq.Workplane("XY")
    .rect(5, 5)
    .twistExtrude(10, 45)    # 10mm tall, 45 degree twist
)
```

## Boolean Operations

```python
.union(other)          # add another solid
.cut(other)            # subtract another solid
.intersect(other)      # keep only intersection
.combine()             # combine all stack items into one solid
```

## Text

```python
.text("HELLO", fontsize=10, distance=2)             # embossed text
.text("HELLO", fontsize=10, distance=-1)             # engraved text
.text("HELLO", fontsize=10, distance=2, cut=True)    # cut text into solid
.text("HELLO", fontsize=10, distance=2, font="Arial") # custom font
```

## Transformations

```python
.translate((dx, dy, dz))                              # move
.rotate((0,0,0), (0,0,1), 45)                         # rotate 45 deg around Z axis
.rotateAboutCenter((0,0,1), 45)                        # rotate around center
.mirror("XY")                                          # mirror about XY plane
.mirror("XY", basePointVector=(0,0,5))                 # mirror about offset plane
```

## Fillets, Chamfers & Shell

```python
# Fillet specific edges
result.edges("|Z").fillet(2.0)          # fillet all vertical edges, radius 2mm
result.edges(">Z").fillet(1.0)          # fillet top edges only
result.edges().fillet(0.5)              # fillet ALL edges

# Chamfer
result.edges("|Z").chamfer(1.0)               # symmetric chamfer
result.edges("|Z").chamfer(1.0, 2.0)          # asymmetric chamfer

# Shell (hollow out)
result.faces(">Z").shell(2.0)       # remove top face, 2mm wall thickness
result.faces(">Z").shell(-2.0)      # negative = shell outward
result.faces(">Z or <Z").shell(1.0) # remove top and bottom
```
