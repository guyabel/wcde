# Pull multiple vectors for a given indicator, scenarios and .Rdata file names

Requires a working internet connection. Intended for internal use.

## Usage

``` r
get_wcde_single(
  indicator = NULL,
  scenario = 2,
  country_code = NULL,
  server = NULL,
  version = NULL
)
```

## Arguments

- indicator:

  One character string based on the `name` column in the
  `wic_indicators` data frame, representing the variable to be
  interested.

- scenario:

  Vector with a numbers corresponding the scenarios. See details in
  `wcde` for more information.

- country_code:

  Vector of length one or more of country numeric codes based on ISO 3
  digit numeric values.

- server:

  Character string for server to download from. Defaults to `iiasa`, but
  can use `github` if IIASA server is down.

- version:

  Character string for version of projections to obtain. Defaults to
  `wcde-v3`, but can use `wcde-v2` and `wcde-v1`. Scenario and indicator
  availability vary between versions.

## Value

A tibble with multiple columns.
