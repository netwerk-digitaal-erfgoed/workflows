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
# Shared partials that templates render by name; see the boilerplate target.
NDE_PARTIALS := $(notdir $(wildcard $(NDE_SPEC_BOILERPLATE)/partials/nde-*.liquid))

.DELETE_ON_ERROR:
# Templates are rendered on every build, like the Bikeshed run itself, so a new
# docgen or partial always shows up.
.PHONY: help ci spec watch update boilerplate templates logo.include nde.include $(NDE_PARTIALS) $(NDE_RENDERED)

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

# Deletes the spec’s downloaded copies of this folder, of every version, and has
# its Makefile download the current one again. Refuses any other copy, such as a
# checkout of the workflows repository.
update:
	@case "$(NDE_SPEC_BOILERPLATE)" in .nde/*) ;; *) echo "make update only refreshes a copy in .nde/" >&2; exit 1;; esac
	rm -rf .nde
	$(MAKE) "$(NDE_SPEC_BOILERPLATE)/nde.mk"

# Bikeshed reads logo.include through ‘Local Boilerplate: logo yes’, and the
# spec includes nde.include; both must sit next to the spec. Templates render the
# shared partials (nde-*.liquid) by name, which docgen looks up in the template’s
# own folder, so only templates next to the spec can render them. All are copied
# on every build, so a new version shows up. A spec that tracks its own file of
# that name in git keeps it; any other file of that name is overwritten.
boilerplate: logo.include nde.include $(NDE_PARTIALS)

define NDE_COPY_UNLESS_TRACKED
@if [ ! -e "$@" ] || ! git ls-files --error-unmatch "$@" > /dev/null 2>&1; then \
	cp "$<" "$@"; \
fi
endef

logo.include nde.include: %: $(NDE_SPEC_BOILERPLATE)/boilerplate/%
	$(NDE_COPY_UNLESS_TRACKED)

$(NDE_PARTIALS): %: $(NDE_SPEC_BOILERPLATE)/partials/%
	$(NDE_COPY_UNLESS_TRACKED)

# docgen is only installed when the spec has templates, and again when its lockfile changes.
templates: $(NDE_RENDERED)

$(NDE_RENDERED): %: %.liquid | $(NDE_DOCGEN) $(NDE_PARTIALS)
	"$(NDE_DOCGEN)" from-shacl $(NDE_FRAME) shacl.ttl "$<" > "$@"
	@if grep -nF '[object Object]' "$@"; then \
		echo "$@ contains ‘[object Object]’: a Liquid template printed an object." >&2; \
		exit 1; \
	fi

$(NDE_DOCGEN): $(NDE_SPEC_BOILERPLATE)/package-lock.json
	npm ci --prefix "$(NDE_SPEC_BOILERPLATE)" --no-audit --no-fund
	touch "$@"
