---
title: Deploying with Vercel
---

!!! note inline end "Vercel official documentation"

    - [**Configuring Projects with `vercel.json`**](https://vercel.com/docs/projects/project-configuration)
    - [**Deploying GitHub Projects with Vercel**](https://vercel.com/docs/deployments/git/vercel-for-github)

!!! info "Config is versioned at `vercel.json` in the repo root directory"

    ``` json
    --8<-- "vercel.json"
    ```

## :material-code-json: Config to build a `mkdocs` site

The Vercel deployment config is stored in `vercel.json` at the project root.

It sets the following on your docs site deployment:

- **Build command**
  `mkdocs build` but ensured to be run through PDM
- **Output directory**
  `site`
- **Install command**
  The command below (but as a one-liner):

```bash
python3 --version && \
python3 -m pip install pdm 'urllib3<2' && \
python3 -m pdm install --no-default -dG docs -v && \
python3 -m pdm run mkdocs
```

!!! bug inline end "Vercel and `urllib3<2`"

    The `urllib3` dep is pinned because Vercel "runners" are based on
    Amazon Linux 2,
    a close relative of [RHEL](https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux)
    which shipped with OpenSSL v1.0.2, whereas `urllib3` v2 [imposes](https://github.com/urllib3/urllib3/issues/2168)
    a minimum of OpenSSL v1.1.1.

The install command will:

- Print out the Python version (3.9.8 at the time of writing),
- Install PDM (and v1.x of urllib3; see note in sidebar),
- Install the `docs` dependency group with the `-G` flag (it's a "dev dependency" so you also use `-d`)
- Run `mkdocs` to print out the usage (as confirmation that it was successfully installed)

## GitHub integration

### :material-shield-lock: Privacy

If your repo is private, Vercel will require users to login to determine access.

This repo is public ([here](https://github.com/lmmx/docs-pkg)) so
the website is too (both the default branch [here](https://docs-pkg.vercel.app/)
as well as preview deployments for commits in PRs).

### :material-rocket-launch: CI bot

To install a Vercel CI bot that will comment on all of your PRs,
install the [Vercel GitHub App](https://github.com/apps/vercel)
on your account.

It's shown in a _Deployments_ panel to the right of the repo and at
[`/deployments`](https://github.com/lmmx/docs-pkg/deployments).
