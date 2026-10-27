# Changelog

## [1.3.0](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.2.2...v1.3.0) (2026-10-27)


### Features

* **spec-boilerplate:** share the cells of attribute tables between specs ([#66](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/66)) ([44529b4](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/44529b4f748e9d06ac71096c40e7e9f6e98cdefd))

## [1.2.2](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.2.1...v1.2.2) (2026-10-15)


### Bug Fixes

* **release-please:** don’t fail the run when there is no release PR to merge ([#63](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/63)) ([888a42f](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/888a42ff48fa6bff65160883508723f747350a02))

## [1.2.1](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.2.0...v1.2.1) (2026-10-15)


### Bug Fixes

* **spec-boilerplate:** render templates in a subfolder with docgen 0.7.3 ([#61](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/61)) ([db4dd0f](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/db4dd0f41013eda0766014d9349ca4e677f6cded))

## [1.2.0](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.1.1...v1.2.0) (2026-10-15)


### Features

* **release-please:** merge the release PR automatically on request ([#59](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/59)) ([714872a](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/714872a121244136fbc26d94cbca27ecc706eac2))

## [1.1.1](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.1.0...v1.1.1) (2026-10-15)


### Bug Fixes

* **spec-boilerplate:** make table stripes visible in light and dark mode ([#57](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/57)) ([0135ce6](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/0135ce6cd0833c5208f3e064081a1b7f14b60553))

## [1.1.0](https://github.com/netwerk-digitaal-erfgoed/workflows/compare/v1.0.0...v1.1.0) (2026-10-15)


### Features

* **spec:** build a spec that lives in a subfolder ([#54](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/54)) ([31ea48d](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/31ea48d7f843e7520426db6a285564ec091d9d00))

## 1.0.0 (2026-10-15)


### Features

* add build-args input to deploy workflow ([#7](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/7)) ([e67f2e2](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/e67f2e26a38cf973bab187fcaccc0624430d259a))
* add shared Release Please workflow ([#12](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/12)) ([7c23d42](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/7c23d42ecd542e9b824c7e8bb428a4f5a3510a60))
* give specs the NDE logo and house style, versioned with spec.yml ([#51](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/51)) ([61ac4ef](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/61ac4efb3073b4e9832b70c634d9c87ba453674f))
* **nx-migrate:** support pnpm workspaces ([#47](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/47)) ([d2e44a7](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/d2e44a759d022609d35e50c28bfabf758f95471d))
* publish repo-level public/ static files alongside the built spec ([#43](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/43)) ([74d85a2](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/74d85a2dcc43271d0700e7f4e96387b0425c9fe7))
* **release-please:** add working-directory input for monorepo support ([#20](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/20)) ([899ba2f](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/899ba2f249c0d2e2665f070455429c020ccd6899))


### Bug Fixes

* address the review of the spec boilerplate ([#53](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/53)) ([f330115](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/f3301154c9047990fd289c5b59df7d3748acaa1f))
* auto-detect custom JSON-LD frame for docgen ([#35](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/35)) ([8f26232](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/8f262324fb14de4c06c659a98c54f66e7b0e16d3))
* auto-detect spec file path ([#13](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/13)) ([2a9dd59](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/2a9dd59dd4ca8bb5d6e342eacb3e9b1459c76ad6))
* **dependabot-auto-merge:** remove invalid 'workflows' permission scope ([#22](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/22)) ([b26597f](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/b26597f59cf0e8072f7d5e875892a784e1befe99))
* install matching Chrome via puppeteer browsers installer ([#40](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/40)) ([a3fdd0d](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/a3fdd0d7f66f27fa4ede856d2f3a00c4d6fc8dac))
* **nx-migrate:** clean up tools/ai-migrations before committing to PR branch ([#45](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/45)) ([93298cb](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/93298cbb9e73b15f24bcd756df70c78e968ea220))
* **nx-migrate:** install dependencies before running nx migrate ([#15](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/15)) ([0617c54](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/0617c54e4b4455f20f556fe53b61e37d9125f387))
* **release-please:** skip sync-changelog if CHANGELOG.md does not exist ([#21](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/21)) ([ca728e1](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/ca728e13fcae89ff995cbf9ebacba7c8b29d0628))
* **sync-changelog:** skip BREAKING CHANGES section to avoid duplicated bullets ([#39](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/39)) ([9aa5306](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/9aa53064fd8381d751820248a2dc985a0992292e))
* use runner's preinstalled Chrome (pinned build not downloadable) ([#41](https://github.com/netwerk-digitaal-erfgoed/workflows/issues/41)) ([45be146](https://github.com/netwerk-digitaal-erfgoed/workflows/commit/45be146d0049c12d12111f0ca510dca5cf374515))
