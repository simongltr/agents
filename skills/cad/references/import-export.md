# Import & Export

## Importing

```python
# STEP files
result = cq.importers.importStep("part.step")

# DXF files (returns Workplane with wires)
result = cq.importers.importDXF("profile.dxf")
solid = cq.importers.importDXF("profile.dxf").wires().toPending().extrude(10)

# DXF with layer filtering
result = cq.importers.importDXF("drawing.dxf", include=["outline"])
result = cq.importers.importDXF("drawing.dxf", exclude=["dimensions"])

# Assembly from STEP
assy = cq.Assembly.load("assembly.step")
```

## Exporting

```python
# STEP (preferred for CAD interchange)
cq.exporters.export(result, "part.step")

# STL (for 3D printing)
cq.exporters.export(result, "part.stl")
result.val().exportStl("part.stl", tolerance=0.001, angularTolerance=0.1)

# DXF (2D cross-section)
cq.exporters.export(result.section(), "part.dxf")

# SVG
cq.exporters.export(result, "part.svg")

# Other mesh formats
cq.exporters.export(result, "part.3mf")   # 3MF
cq.exporters.export(result, "part.gltf")  # glTF

# Assembly export
assy.save("assembly.step")
assy.save("assembly.gltf")
```

## Format Selection Guide

| Format | Use Case |
|--------|----------|
| **STEP** | CAD interchange, manufacturing, highest fidelity |
| **STL** | 3D printing, mesh-based workflows |
| **3MF** | 3D printing (modern, supports color/materials) |
| **DXF** | 2D drawings, laser cutting, CNC profiles |
| **SVG** | Documentation, web display |
| **glTF** | Web 3D visualization |
