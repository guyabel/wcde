# Changelog

## wcde 0.0.8.1

- No change. Kicked off CRAN for nothing reason.

## wcde 0.0.8

CRAN release: 2026-02-25

- Added `closeConnections()` to
  [`get_wcde_single()`](https://guyabel.github.io/wcde/reference/get_wcde_single.md)
  to prevent open connections on server when downloading data
- Updated for past data in `past_epop` and `wic_indicators` for back
  projections added to v3.

## wcde 0.0.7

CRAN release: 2024-02-13

- Expanded `wic_locations`, `wic_indicators` and `wic_scenarios` data
  frames to cover V1, V2 and V3
- Updated
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
  and
  [`get_wcde_single()`](https://guyabel.github.io/wcde/reference/get_wcde_single.md)
  to work with new `wic_locations`, `wic_indicators` and
  `wic_scenarios`data frames
- Re-coded SSP2-ZM and SSP2-DM as scenario numbers `22` and `23` on
  server to make room for SSP2-CER (`20`) and SSP2-FT (`21`) from V1

## wcde 0.0.6

CRAN release: 2023-12-19

- Add `server` argument in
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
- Updated UK pop-age file for scenario 1 on server
- Replaced
  [`dplyr::summarize()`](https://dplyr.tidyverse.org/reference/summarise.html)
  with
  [`dplyr::reframe()`](https://dplyr.tidyverse.org/reference/reframe.html)
  in
  [`get_wcde_single()`](https://guyabel.github.io/wcde/reference/get_wcde_single.md)
- Add `version` argument in
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
- Changed files on servers to `.rds` and code in
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
  to retrieve `.rds` data

## wcde 0.0.5

CRAN release: 2022-06-06

- Fixed bug for `pop_edu` argument for bulk downloads in
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)

## wcde 0.0.4

CRAN release: 2022-05-11

- Add `pop_age`, `pop_sex` and `pop_edu` arguments to
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
  and added separate population files for different age/sex/education
  categories to server

## wcde 0.0.3

CRAN release: 2021-10-30

- Add authors to vignette
- Add start-up citation note
- Renamed `wcde_pull()` to
  [`get_wcde_single()`](https://guyabel.github.io/wcde/reference/get_wcde_single.md)
- Initial pkgdown working
- Github actions working
- Website to description
- Allow
  [`edu_group_sum()`](https://guyabel.github.io/wcde/reference/edu_group_sum.md)
  to work without scenario column

## wcde 0.0.2

CRAN release: 2021-07-28

- Expanded vignette to include animation
- Removed export from `wcde_pull()`
- Replaced `ssp2_epop` with `past_epop`

## wcde 0.0.1

CRAN release: 2021-06-23

- Initial version
