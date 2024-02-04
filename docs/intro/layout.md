---
title: Project layout
---

The layout is straightforward but notice the symlinks that let the documentation live alongside associated code.

This repo mimics the layout of a monorepo containing two example Python packages. Note that they
don't need to ever be installed to build the docs, so the top-level `pyproject.toml` just stores
a `docs` dependency group.

```
.
├── docs
│   ├── api
│   │   ├── bar.md
│   │   ├── foo.md
│   │   └── index.md
│   ├── index.md -> ../README.md     # The documentation homepage.
│   ├── stylesheets
│   │   └── extra.css
│   ├── theme
│   └── usage
│       ├── bar.md -> ../../src/bar/README.md
│       ├── foo.md -> ../../src/foo/README.md
│       └── index.md
├── LICENSE.txt
├── mkdocs.yml    # The configuration file.
├── pdm.lock
├── pyproject.toml
├── README.md
└── src
    ├── bar
    │   ├── pyproject.toml
    │   ├── README.md
    │   ├── src
    │   │   └── bar
    │   └── tests
    └── foo
        ├── pyproject.toml
        ├── README.md
        ├── src
        │   └── foo
        └── tests
```
