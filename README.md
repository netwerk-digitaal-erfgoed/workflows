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

#### Customising release notes

Release Please generates changelog entries from conventional commit messages. To customise
individual entries, you have two options:

**Reword or exclude entries before a release** using Release Please's
[`BEGIN_COMMIT_OVERRIDE`](https://github.com/googleapis/release-please/blob/main/docs/customizing.md#use-conventional-commit-messages):
edit the body of the **merged source PR** (not the release PR) and add an override block:

```
BEGIN_COMMIT_OVERRIDE
feat: reworded description of the feature
END_COMMIT_OVERRIDE
```

Release Please reads PR bodies via the GitHub API, so the override takes effect on the next
push to `main`. To exclude an entry entirely, override with a hidden type (e.g. `chore:`).

**Edit `CHANGELOG.md` on the release PR branch** as the last step before merging.
Release Please force-pushes the branch when new commits land on `main`, so make sure no other
PRs are merged between your edit and the release PR merge. The `sync-changelog` job will
automatically update `index.bs.liquid` from your edited `CHANGELOG.md`.

To edit already-released versions, commit directly to `main` – Release Please only prepends
new version sections and never modifies old ones.

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
