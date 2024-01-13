# docs-pkg

A suite of documented packages built with [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout

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

## Tips on documenting your code

- If the `show_if_no_docstring` flag is on (default: off) you must put a docstring in a class or it won't get documented

- You can override all of the settings in an `options` block per-file beneath an autodoc instruction (`:::` followed by a
  dotted path to the module/object)

  - One important setting to override is `members` which lets you list the members in the order you want them to appear.
    - Otherwise, they appear in alphabetical order (the `members_order` setting defaults to
      `"rendering.Order.alphabetical.value"`, I prefer changing it to `"source"`).

## Deploying with Vercel

The Vercel deployment config is stored in `vercel.json` at the project root.

It equates to setting the following manually in the web view
(but it's easier to let it be configured automatically from the JSON file):

- Build command: `python3 -m pdm run mkdocs build`
- Output directory: `site`
- Install command: (remove the newlines from the command below)

```bash
python3 --version && python3 -m pip install pdm "urllib3<2" &&
python3 -m pdm config python.use_venv false &&
python3 -m pdm install -v &&
python3 -m pdm run mkdocs
```
