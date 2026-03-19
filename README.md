# Reusable GitHub Actions Workflows

Shared [reusable workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows) for [Netwerk Digitaal Erfgoed](https://github.com/netwerk-digitaal-erfgoed) repositories.

## Authentication

These workflows authenticate using a [GitHub App](https://docs.github.com/en/apps) rather than personal
access tokens or the default `GITHUB_TOKEN`. This is necessary because actions performed with
`GITHUB_TOKEN` [do not trigger new workflow runs](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow#triggering-a-workflow-from-a-workflow),
so PRs created or merged by workflows (e.g. Release Please, Dependabot auto-merge, Nx migrate) would
not run CI checks. A GitHub App token does trigger downstream workflows.

The app's credentials (`GH_APP_ID` and `GH_APP_PRIVATE_KEY`) must be stored as organisation secrets.
Caller workflows pass them with `secrets: inherit`.

## Workflows

### [`deploy.yml`](.github/workflows/deploy.yml)

Builds a Docker image and pushes it to the GitHub Container Registry (`ghcr.io`).
Supports optional `target` (multi-stage build target) and `build-args` inputs.

```yaml
jobs:
  deploy:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/deploy.yml@main
    secrets: inherit
```

### [`spec.yml`](.github/workflows/spec.yml)

Builds and optionally publishes a W3C-style specification document using
[spec-prod](https://github.com/w3c/spec-prod). Supports Liquid templates (rendered with
[@lde/docgen](https://www.npmjs.com/package/@lde/docgen)) and Mermaid diagrams.

```yaml
jobs:
  spec:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/spec.yml@main
    with:
      publish: true
```

### [`dependabot-auto-merge.yml`](.github/workflows/dependabot-auto-merge.yml)

Automatically squash-merges Dependabot pull requests.

```yaml
on:
  pull_request:

jobs:
  auto-merge:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/dependabot-auto-merge.yml@main
    secrets: inherit
```

### [`release-please.yml`](.github/workflows/release-please.yml)

Runs [Release Please](https://github.com/googleapis/release-please) to automate releases.
Optionally syncs `CHANGELOG.md` into a Bikeshed spec (`index.bs.liquid`) on the release PR branch.

```yaml
jobs:
  release:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/release-please.yml@main
    secrets: inherit
```

To disable changelog syncing:

```yaml
    with:
      sync-changelog: false
```

### [`nx-migrate.yml`](.github/workflows/nx-migrate.yml)

Checks for a newer Nx version, runs `nx migrate`, and opens a pull request with the result.

```yaml
jobs:
  nx-migrate:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/nx-migrate.yml@main
    secrets: inherit
```

## Dependabot

The repository includes a [Dependabot configuration](.github/dependabot.yml) that keeps GitHub Actions
versions up to date on a weekly schedule.
