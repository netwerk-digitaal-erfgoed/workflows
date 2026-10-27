# Spec boilerplate

The build, logo and house style that NDE’s [Bikeshed](https://speced.github.io/bikeshed/) specifications share.

* `nde.mk`: the `make spec` and `make watch` targets, and `make ci` for the workflows. They render Liquid templates with [docgen](https://ldelements.org/reference/docgen), then run Bikeshed in Docker.
* `boilerplate/logo.include`: the NDE logo for the spec’s header, taken from netwerkdigitaalerfgoed.nl. It is blue on light backgrounds and takes the text colour in dark mode, as the NDE logo manual prescribes.
* `boilerplate/nde.include`: the house style, such as striped table rows.
* `partials/`: Liquid partials that every spec’s templates can render, such as the cells of an attribute table. Their names start with `nde-`. See [Templates](#templates).
* `action.yml`: runs `make ci` in CI. [`spec.yml`](../.github/workflows/spec.yml) uses it; a spec with its own build workflow can call it directly.
* `package.json`: pins docgen, so Dependabot updates it here once for every spec.

## Versions

A spec uses the version of this folder that its workflow calls: `spec.yml@v1.1.0` or `spec-boilerplate@v1.1.0` gets that tag, `@main` gets the latest.
Dependabot’s `github-actions` updates propose each new tag as a pull request in the spec’s repository.

The local build reads the same version from the spec’s workflow files and keeps one copy per version in `.nde/`, so it matches CI and works offline once downloaded.
A spec that follows a branch such as `main` keeps its local copy until `make update`; CI always uses the branch’s latest commit.

A local build needs git, curl, tar and Docker, and npm when the spec has templates.

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

   A spec that tracks its own `logo.include` or `nde.include` in git keeps it.

3. Add to `.gitignore`:

   ```
   .nde/
   logo.include
   nde.include
   nde-*.liquid
   ```

4. A spec in a subfolder of its repository passes that folder to `spec.yml`:

   ```yaml
   jobs:
     build:
       uses: netwerk-digitaal-erfgoed/workflows/.github/workflows/spec.yml@v1.1.0
       with:
         working-directory: requirements
   ```

   A spec that publishes somewhere other than GitHub Pages adds its own publish job, which downloads the `spec-prod-result` artifact.
   A spec with a build workflow of its own can render templates and copy the boilerplate with the `spec-boilerplate` action instead, which takes the same input.

## Templates

`make spec` renders every template with a second extension, such as `index.bs.liquid` to `index.bs` or `diagram.mmd.liquid` to `diagram.mmd`, from the spec’s `shacl.ttl`.
A file with only `.liquid`, such as `attributes.liquid`, is a partial that templates include, and is not rendered by itself; so a partial’s name has no other dot.
Templates are rendered on every build.
If the spec has a `shacl.frame.jsonld`, docgen uses it.

The build copies the partials in [`partials/`](partials) next to the spec, like the includes, so templates next to the spec render them by name. A template in a subfolder can’t, because docgen only looks in the template’s own folder.
To override a partial, track your own file of the same name in git. Because of the `nde-*.liquid` line in `.gitignore`, add it with `git add -f`; an untracked file of that name is overwritten on every build.

* `nde-cardinality-and-usage`: the Cardinality and Usage cells of a row in a table of a node shape’s properties, including what an `nde:futureChange` changes in which version.
  Pass the row’s property shape and the node shape:

  ```liquid
  <tr>
      <th scope="row">{{ property.path }}</th>
      {% render 'nde-cardinality-and-usage', property: property, nodeShape: nodeShape -%}
  </tr>
  ```

  The `-%}` trims the caller’s own line break after the cells, which would otherwise leave a blank line in the table.

  Usage is Required for an `sh:minCount` that is a violation, Recommended for one that is a warning, and Optional otherwise; pass `optional: 'Recommended'` to call those Recommended too.
  Future changes call an identifier an IRI; pass `iri: 'URI'` for a spec that says URI.
  Pass `combined: true` for a single Usage cell that also says how many values are allowed in words, such as ‘Required, one or more’, instead of a separate Cardinality cell.
  Pass `part: 'value-note'` to get only the change to what the values must be, such as “v2.0: must be IRI”, to show next to an expected value; with `combined`, the Usage cell then leaves it out.
  Each future change links to a section with the id `v` and its major version, such as `#v2`, which the spec has to have.
* `nde-value-count`: how many values a property takes, in words, such as “one or more”, from `min`, `max` and `uniqueLang`. `nde-cardinality-and-usage` uses it.
