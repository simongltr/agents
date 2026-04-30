# Selectors

Selectors target specific geometry (faces, edges, vertices) for subsequent operations. They are passed as strings to `.faces()`, `.edges()`, `.vertices()`, `.wires()`, `.solids()`.

## Axis Direction Selectors

| Syntax | Meaning | Works On |
|--------|---------|----------|
| `+Z` | Normal/direction aligned with +Z | faces, edges |
| `-X` | Normal/direction aligned with -X | faces, edges |
| `\|Z` | Parallel to Z axis | faces, edges |
| `#Z` | Perpendicular to Z axis | faces, edges |

## Extrema Selectors (Min/Max)

| Syntax | Meaning | Works On |
|--------|---------|----------|
| `>Z` | Farthest in +Z direction (max) | faces, edges, vertices |
| `<Z` | Farthest in -Z direction (min) | faces, edges, vertices |
| `>X` | Farthest in +X direction | faces, edges, vertices |
| `<Y` | Farthest in -Y direction | faces, edges, vertices |

## Nth Selectors (Ordered by Position)

| Syntax | Meaning |
|--------|---------|
| `>Z[0]` | Closest face/edge with normal in +Z (1st) |
| `>Z[-1]` | Farthest face/edge (last) |
| `>Z[-2]` | Second from farthest |
| `>>Z[0]` | Closest by center position (CenterNthSelector) |
| `<<Z[-1]` | Farthest by center position |

## Type Selectors

| Syntax | Meaning |
|--------|---------|
| `%Circle` | Circular edges |
| `%Line` | Linear edges |
| `%Plane` | Planar faces |
| `%Cylinder` | Cylindrical faces |
| `%Cone` | Conical faces |
| `%Sphere` | Spherical faces |

## Combining Selectors

```python
.edges("|Z and >Y")            # edges parallel to Z AND farthest in Y
.edges("|Z or |X")             # edges parallel to Z OR X
.faces("not >Z")               # all faces except the top
.edges("not(|X or |Y or |Z)")  # edges not parallel to any axis
.faces(">Z or <Z")             # top and bottom faces
```

## Custom Direction Vectors

```python
.edges(">(1, 1, 0)")           # edges farthest in the (1,1,0) direction
.faces("|(1, 1, 0)")           # faces with normal parallel to (1,1,0)
```

## Selector Classes (Programmatic)

```python
from cadquery import selectors

.edges(selectors.NearestToPointSelector((0, 0, 5)))
.faces(selectors.BoxSelector((-1,-1,-1), (1,1,1)))
.edges(selectors.RadiusNthSelector(0))            # smallest radius edge
.faces(selectors.AreaNthSelector(-1))              # largest area face
.edges(selectors.LengthNthSelector(0))             # shortest edge
```

## Cheat Sheet

```
Direction:    +Z  -X  +Y         (aligned with axis)
Parallel:     |Z  |X  |Y         (parallel to axis)
Perpendicular: #Z  #X  #Y        (perpendicular to axis)
Extrema:      >Z  <Z  >X  <X    (farthest/nearest along axis)
Nth:          >Z[0]  >Z[-1]     (ordered by direction)
Center Nth:   >>Z[0]  <<Z[-1]   (ordered by center position)
Type:         %Line  %Circle  %Plane  %Cylinder
Combine:      |Z and >Y          (intersection)
              |Z or |X           (union)
              not >Z             (negation)
Custom dir:   >(1, 1, 0)        (custom vector)
```
