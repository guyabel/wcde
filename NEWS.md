# wcde 0.0.1

* Initial version

# wcde 0.0.2

* Expanded vignette to include animation
* Removed export from `wcde_pull()`
* Replaced `ssp2_epop` with `past_epop`

# wcde 0.0.3

* Add authors to vignette
* Add start-up citation note
* Renamed `wcde_pull()` to `get_wcde_single()`
* Initial pkgdown working
* Github actions working
* Website to description
* Allow `edu_group_sum()` to work without scenario column

# wcde 0.0.4

* Add `pop_age`, `pop_sex` and `pop_edu` arguments to `get_wcde()` and added separate population files for different age/sex/education categories to server

# wcde 0.0.5

* Fixed bug for `pop_edu` argument for bulk downloads in `get_wcde()`

# wcde 0.0.6

* Add `server` argument in `get_wcde()`
* Updated UK pop-age file for scenario 1 on server
* Replaced `dplyr::summarize()` with `dplyr::reframe()` in `get_wcde_single()`
* Add `version` argument in `get_wcde()`
