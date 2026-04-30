# Core Concepts

## BREP Topology Hierarchy

CadQuery uses Boundary Representation (BREP). Objects are defined by their enclosing surfaces. The hierarchy from lowest to highest:

| Level | Type | Definition |
|-------|------|------------|
| 0 | **Vertex** | A single point in space |
| 1 | **Edge** | Connection between vertices along a path (line, arc, spline) |
| 2 | **Wire** | Connected collection of edges |
| 3 | **Face** | Edges/wires enclosing a surface |
| 4 | **Shell** | Connected collection of faces |
| 5 | **Solid** | A shell with a closed interior |
| 6 | **Compound** | A collection of solids |

## Four API Layers

1. **Fluent API** (primary) — `Workplane`, `Sketch`, `Assembly` classes with method chaining
2. **Direct API** — Topological classes (`Solid`, `Face`, `Edge`, `Wire`, `Vertex`) with factory methods
3. **Geometry API** — `Vector`, `Plane`, `Location` primitives
4. **OCP API** — Raw OpenCascade Python bindings (lowest level)

Always prefer the Fluent API. Drop to lower layers only when the Fluent API cannot express the operation.

## The Stack

Every `Workplane` object maintains a **stack** of geometric objects (vertices, edges, faces, solids, or vectors). Operations act on all items in the stack. Selection methods (`faces()`, `edges()`, `vertices()`) replace the stack contents. This is how you target where operations happen.

## Pending Wires

When you draw 2D geometry (lines, arcs, circles, rects), CadQuery accumulates them as **pending wires**. These wires are consumed by the next 3D operation (`extrude()`, `revolve()`, `sweep()`, `loft()`, `cutBlind()`, `cutThruAll()`).

## The Fluent API & Chaining

CadQuery uses a fluent (chainable) API. Each method returns a new `Workplane` object:

```python
import cadquery as cq

result = (
    cq.Workplane("XY")
    .box(80, 60, 10)
    .faces(">Z")
    .workplane()
    .hole(22)
)
```

### Navigating the Chain

- `.end()` — go back one step in the chain (return parent Workplane)
- `.end(n)` — go back `n` steps
- `.tag("name")` — tag the current state for later reference
- `.workplaneFromTagged("name")` — return to a tagged workplane

## Workplanes

A workplane defines a 2D coordinate system positioned in 3D space. All 2D operations happen on the current workplane.

```python
# From a named plane (origin at global 0,0,0)
cq.Workplane("XY")   # top view (default)
cq.Workplane("XZ")   # front view
cq.Workplane("YZ")   # side view

# On a face of an existing solid
result.faces(">Z").workplane()         # workplane on the top face
result.faces("<Z").workplane()         # workplane on the bottom face

# With offset
result.faces(">Z").workplane(offset=5) # 5mm above the top face

# Centered on a specific point
cq.Workplane("XY").center(10, 20)     # shift workplane origin to (10, 20)

# Rotated workplane
result.faces(">Z").workplane().transformed(rotate=(45, 0, 0))
```
