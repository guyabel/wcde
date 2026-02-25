# Indicators used in the Wittgenstein Centre Human Capital Data Explorer

A data set containing the indicator codes, names and further details
used in the Wittgenstein Centre Human Capital Data Explorer

## Usage

``` r
wic_indicators
```

## Format

A data frame with 37 rows and 11 variables, including:

- indicator:

  Short name of indicator to be used in the `indicator` argument of the
  [`get_wcde()`](https://guyabel.github.io/wcde/reference/get_wcde.md)
  function

- description:

  Brief description of indicator

- wcde-v3:

  Availability in wcde-v3 of `projection-only` or `past-available` (in
  addition to projections) of indicator. If value is `NA` then indicator
  not available in version.

- wcde-v2:

  Availability in wcde-v2 of `projection-only` or `past-available` (in
  addition to projections) of indicator. If value is `NA` then indicator
  not available in version.

- wcde-v1:

  Availability in wcde-v1 of `projection-only` or `past-available` (in
  addition to projections) of indicator. If value is `NA` then indicator
  not available in version.

- age:

  Availability of indicator by five-year age groups

- bage:

  Availability of indicator by broad age groups

- sage:

  Availability of indicator with a new born age group

- sex:

  Availability of indicator by sex

- edu:

  Availability of indicator by education

- period:

  Indicator is a period (flow)

- definition_latest:

  Full definition for indicator based on latest available version

## Source

<http://dataexplorer.wittgensteincentre.org/>
