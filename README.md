# Reusable GitHub Actions Workflows

Shared [reusable workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows) for [Netwerk Digitaal Erfgoed](https://github.com/netwerk-digitaal-erfgoed) repositories.

## Workflows

### [`deploy.yml`](.github/workflows/deploy.yml)

Builds a Docker image and pushes it to the GitHub Container Registry (`ghcr.io`).
Supports optional `target` (multi-stage build target) and `build-args` inputs.

```yaml
jobs:
  deploy:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/deploy.yml@main
    secrets:
      CONTAINER_REGISTRY_TOKEN: ${{ secrets.CONTAINER_REGISTRY_TOKEN }}
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
```

### [`nx-migrate.yml`](.github/workflows/nx-migrate.yml)

Checks for a newer Nx version, runs `nx migrate`, and opens a pull request with the result.

```yaml
jobs:
  nx-migrate:
    uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/nx-migrate.yml@main
```

## Dependabot

The repository includes a [Dependabot configuration](.github/dependabot.yml) that keeps GitHub Actions
versions up to date on a weekly schedule.
