# Sketch API

The Sketch API provides more powerful 2D operations than basic Workplane drawing.

## Face-Based Sketching

```python
result = (
    cq.Workplane("XY")
    .box(10, 10, 5)
    .faces(">Z")
    .workplane()
    .sketch()
    .rect(8, 8)                              # outer rectangle
    .circle(2, mode="s")                     # subtract circle from center
    .vertices()                              # select vertices of the rectangle
    .fillet(1)                               # fillet rectangle corners
    .finalize()                              # return to Workplane context
    .cutBlind(-2)                            # cut 2mm deep
)
```

## Sketch Modes

| Mode | Effect |
|------|--------|
| `"a"` | **Add** — union with existing sketch geometry (default) |
| `"s"` | **Subtract** — remove from existing sketch geometry |
| `"i"` | **Intersect** — keep only overlapping area |
| `"r"` | **Replace** — replace existing geometry entirely |
| `"c"` | **Construction** — store for reference only (requires `tag`) |

## Primitive Shapes

```python
s = cq.Sketch()
s.rect(width, height)
s.circle(radius)
s.ellipse(a, b)
s.trapezoid(width, height, angle1)
s.slot(width, height)
s.regularPolygon(radius, n_sides)
s.polygon([(x1,y1), (x2,y2), ...])
```

## Arrays

```python
s = (
    cq.Sketch()
    .rarray(xs=4, ys=4, nx=3, ny=3)    # 3x3 rectangular array, 4mm spacing
    .circle(1)                           # circle at each array point
    .reset()                             # reset selection to full sketch
)

s = (
    cq.Sketch()
    .parray(r=5, a1=0, da=360, n=6)    # 6-element polar array, radius 5
    .circle(1)
    .reset()
)
```

## Edge-Based Sketching

```python
s = (
    cq.Sketch()
    .segment((0, 0), (10, 0))       # bottom edge
    .segment((10, 0), (10, 5))      # right edge
    .arc((10, 5), (5, 7), (0, 5))   # arc across top
    .segment((0, 5), (0, 0))        # left edge
    .assemble()                      # assemble edges into face
)
```

## Placing Sketches on Workplanes

```python
s = cq.Sketch().circle(5).rect(3, 3, mode="s")

result = (
    cq.Workplane("XY")
    .box(20, 20, 5)
    .faces(">Z")
    .workplane()
    .placeSketch(s)
    .cutBlind(-2)
)
```
