# Shared build for NDE Bikeshed specifications, from netwerk-digitaal-erfgoed/workflows.
#
# A spec’s Makefile downloads this folder at the version its workflow pins and
# includes this file. It can set BIKESHED_IMAGE before the include, and add or
# override targets after it. CI runs the same targets through action.yml.

NDE_SPEC_BOILERPLATE := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
NDE_DOCGEN := $(NDE_SPEC_BOILERPLATE)/node_modules/.bin/docgen
BIKESHED_IMAGE ?= netwerkdigitaalerfgoed/bikeshed:7

# Templates have a second extension (index.bs.liquid, diagram.mmd.liquid); a
# plain name.liquid is a partial that templates render, not a template itself.
NDE_FIND := find . -not -path '*/node_modules/*' -not -path './.nde*'
NDE_TEMPLATES := $(shell $(NDE_FIND) -name '*.*.liquid')
NDE_RENDERED := $(NDE_TEMPLATES:.liquid=)
NDE_FRAME := $(if $(wildcard shacl.frame.jsonld),-f shacl.frame.jsonld)

.DELETE_ON_ERROR:
.PHONY: help ci spec watch update boilerplate templates nde-force

help:
	@echo "Generate HTML from a Bikeshed source document:"
	@echo "  make spec    Generate HTML"
	@echo "  make watch   Generate HTML each time the source changes"
	@echo "  make update  Download the boilerplate again, for a spec that follows a branch"

# The entry point for CI. Keep its name stable: workflows of every version call it.
ci: boilerplate templates

spec: boilerplate templates
	docker run --rm -v "$(CURDIR):/spec" -w /spec $(BIKESHED_IMAGE)

watch: boilerplate templates
	docker run --rm -v "$(CURDIR):/spec" -w /spec $(BIKESHED_IMAGE) sh -c "bikeshed watch"

# The spec’s Makefile keeps one copy per pinned version, so a pinned spec never needs this.
update:
	rm -rf .nde

# Bikeshed reads logo.include through ‘Local Boilerplate: logo yes’, and the
# spec includes nde.include; both must sit next to the spec. A spec that tracks
# its own file of that name keeps it.
boilerplate: logo.include nde.include

logo.include nde.include: %: $(NDE_SPEC_BOILERPLATE)/boilerplate/%
	@if git ls-files --error-unmatch $@ > /dev/null 2>&1; then \
		echo "Keeping the spec’s own $@"; \
	else \
		cp $< $@; \
	fi

# Rendered on every build, like Bikeshed itself, so a new docgen or partial
# always shows up. docgen is only installed when the spec has templates.
templates: $(NDE_RENDERED)

$(NDE_RENDERED): %: %.liquid nde-force | $(NDE_DOCGEN)
	$(NDE_DOCGEN) from-shacl $(NDE_FRAME) shacl.ttl $< > $@
	@if grep -nF '[object Object]' $@; then \
		echo "$@ contains ‘[object Object]’: a Liquid template printed an object." >&2; \
		exit 1; \
	fi

$(NDE_DOCGEN):
	npm ci --prefix $(NDE_SPEC_BOILERPLATE) --no-audit --no-fund

nde-force:
