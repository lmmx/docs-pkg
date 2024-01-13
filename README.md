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

### Configuring Vercel to build a `mkdocs` website

The Vercel deployment config is stored in `vercel.json` at the project root.

It equates to setting the following manually in the web view
(but it's easier to let it be configured automatically from the JSON file):

- **Build command** `python3 -m pdm run mkdocs build`
- **Output directory** `site`
- **Install command** is the command below without the newlines:

```bash
python3 --version && \
python3 -m pip install pdm 'urllib3<2' && \
python3 -m pdm add 'urllib3<2' && \
python3 -m pdm install -v && \
python3 -m pdm run mkdocs"
```

The installation process pins `urllib3` to pre-v2 when installing `pdm`
(as well as when running it) and runs `mkdocs`.

> The `urllib3` is pinned like this because Vercel "runners" are based on the
> Amazon Linux 2 container image (a variant of RHEL, which has OpenSSL v1.0.2
> whereas the `urllib3` v2 release [imposes](https://github.com/urllib3/urllib3/issues/2168)
> a minimum of OpenSSL v1.1.1).

### Vercel integration with GitHub

#### Privacy

The Vercel website checks if you're logged into GitHub when you load it.
If your repo is private, the website will be gated by a GitHub login.
This repo is public ([here](https://github.com/lmmx/docs-pkg)) therefore
so is the website (the default branch deployment [here](https://docs-pkg-git-master-lmmx.vercel.app/) as well as all the other PR/commit-specific deployments).

#### CI bot

To install a Vercel CI bot that will comment on all of your PRs,
install the [Vercel GitHub App](https://github.com/apps/vercel)
on your account (configurable for all repos or select repos).

This gives both PR deployment and a main trunk deployment
(visible from the _Deployments_ panel on the right hand side of the repo front page or at
[`/deployments`](https://github.com/lmmx/docs-pkg/deployments)).

#### Vercel config documentation

See these official docs for more details:

- [**Project configuration**](https://vercel.com/docs/projects/project-configuration): reference
  for the Vercel JSON format.
- [**Vercel for GitHub**](https://vercel.com/docs/deployments/git/vercel-for-github): referenc for
  the Vercel GitHub app.
