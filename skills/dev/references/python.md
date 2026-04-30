# Python

**Only use `uv`. Never use `pip`, `pip install`, `conda`, `poetry`, or `pipenv`.**

- Project commands: `uv run`, `uv sync`, `uv add`, `uv remove`
- One-off scripts (not part of a project): use PEP 723 inline metadata so they're self-contained:

```python
# /// script
# dependencies = [
#   "requests",
# ]
# ///

import requests
# ...
```

Run with: `uv run script.py`

- Quick one-liners / on-the-fly execution: `uv run --with <pkg> -c "code"` (e.g. `uv run --with requests -c "import requests; print(requests.get('https://httpbin.org/ip').json())"`)
- For CLI tools: `uvx <tool>` (e.g. `uvx ruff check .`)
