---
title: Deploying with Vercel
---

## Configuring Vercel to build a `mkdocs` website

The Vercel deployment config is stored in `vercel.json` at the project root.

It equates to setting the following manually in the web view
(but it's easier to let it be configured automatically from the JSON file):

- **Build command** `mkdocs build`
- **Output directory** `site`
- **Install command** is the command below, but all on one line:

```bash
python3 --version && \
python3 -m pip install -v -r docs/reqs/vercel.txt && \
python3 -m mkdocs
```

The pre-commit hook in [`.pre-commit-config.yaml`][pchook] freezes the dependency lockfile into a static list
of requirements at [`docs/reqs/vercel.txt`][vercelreqs]. There's a `vercel` development dependency group in the
[`pyproject.toml`][verceldg] config pinning `urllib3<2` without which mkdocs will fail.

[pchook]: https://github.com/lmmx/docs-pkg/blob/1ecde3785a79a5ef0a57ef54f27925ed95074434/.pre-commit-config.yaml#L47-L53
[vercelreqs]: https://github.com/lmmx/docs-pkg/blob/master/docs/reqs/vercel.txt
[verceldg]: https://github.com/lmmx/docs-pkg/blob/1ecde3785a79a5ef0a57ef54f27925ed95074434/pyproject.toml#L36-L38

> The `urllib3` is pinned like this because Vercel "runners" are based on the
> Amazon Linux 2 container image (a variant of RHEL, which has OpenSSL v1.0.2
> whereas the `urllib3` v2 release [imposes](https://github.com/urllib3/urllib3/issues/2168)
> a minimum of OpenSSL v1.1.1).

## Vercel integration with GitHub

### Privacy

The Vercel website checks if you're logged into GitHub when you load it.
If your repo is private, the website will be gated by a GitHub login.
This repo is public ([here](https://github.com/lmmx/docs-pkg)) therefore
so is the website (the default branch deployment [here](https://docs-pkg-git-master-lmmx.vercel.app/) as well as all the other PR/commit-specific deployments).

### CI bot

To install a Vercel CI bot that will comment on all of your PRs,
install the [Vercel GitHub App](https://github.com/apps/vercel)
on your account (configurable for all repos or select repos).

This gives both PR deployment and a main trunk deployment
(visible from the _Deployments_ panel on the right hand side of the repo front page or at
[`/deployments`](https://github.com/lmmx/docs-pkg/deployments)).

### Vercel config documentation

See these official docs for more details:

- [**Project configuration**](https://vercel.com/docs/projects/project-configuration): reference
  for the Vercel JSON format.
- [**Vercel for GitHub**](https://vercel.com/docs/deployments/git/vercel-for-github): referenc for
  the Vercel GitHub app.
