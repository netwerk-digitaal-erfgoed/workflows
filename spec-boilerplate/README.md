# Spec boilerplate

The build, logo and house style that NDE’s [Bikeshed](https://speced.github.io/bikeshed/) specifications share.

* `nde.mk`: the `make spec` and `make watch` targets, and `make ci` for the workflows. They render Liquid templates with [docgen](https://ldelements.org/reference/docgen), then run Bikeshed in Docker.
* `boilerplate/logo.include`: the NDE logo for the spec’s header. It follows the text colour, so it also works in dark mode.
* `boilerplate/nde.include`: the house style, such as striped table rows.
* `action.yml`: runs `make ci` in CI. [`spec.yml`](../.github/workflows/spec.yml) uses it; a spec with its own build workflow can call it directly.
* `package.json`: pins docgen, so Dependabot updates it here once for every spec.

## Versions

A spec uses the version of this folder that its workflow calls: `spec.yml@v1.2.0` or `spec-boilerplate@v1.2.0` gets that tag, `@main` gets the latest.
Dependabot’s `github-actions` updates propose each new tag as a pull request in the spec’s repository.
The local build reads the same version from the spec’s workflow files, so it matches CI.

## Use it in a spec

New specs get this setup from [requirements-template](https://github.com/netwerk-digitaal-erfgoed/requirements-template).
To add it to an existing spec:

1. Copy the `Makefile` from requirements-template. On the first `make spec` it downloads this folder at the version the spec’s workflow pins, into `.nde/`.
   A spec whose workflows are not in `.github/workflows` next to it sets `NDE_WORKFLOWS_DIR` at the top of the Makefile.
   Targets of the spec’s own go below the `include`.

2. Add to the metadata block of `index.bs`:

   ```
   Local Boilerplate: logo yes
   ```

   and below it:

   ```
   <pre class=include>path: nde.include</pre>
   ```

3. Add to `.gitignore`:

   ```
   .nde/
   logo.include
   nde.include
   ```

4. If the spec builds with its own workflow instead of `spec.yml`, replace its template rendering with:

   ```yaml
   - uses: netwerk-digitaal-erfgoed/workflows/spec-boilerplate@v1.2.0
     with:
       working-directory: requirements
   ```

## Templates

`make spec` renders every template with a second extension, such as `index.bs.liquid` to `index.bs` or `diagram.mmd.liquid` to `diagram.mmd`, from the spec’s `shacl.ttl`.
A file with only `.liquid`, such as `attributes.liquid`, is a partial that templates include, and is not rendered by itself.
If the spec has a `shacl.frame.jsonld`, docgen uses it.
