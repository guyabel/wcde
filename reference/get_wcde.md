# Download data from the Wittgenstein Centre Human Capital Data Explorer

Downloads data from the Wittgenstein Centre Human Capital Data Explorer.
Requires a working internet connection.

## Usage

``` r
get_wcde(
  indicator = "pop",
  scenario = 2,
  country_code = NULL,
  country_name = NULL,
  pop_age = c("total", "all"),
  pop_sex = c("total", "both", "all"),
  pop_edu = c("total", "four", "six", "eight"),
  include_scenario_names = FALSE,
  server = c("iiasa", "github", "1&1", "search-available", "iiasa-local"),
  version = c("wcde-v3", "wcde-v2", "wcde-v1")
)
```

## Arguments

- indicator:

  One character string based on the `indicator` column in the
  `wic_indicators` data frame, representing the variable to be
  downloaded.

- scenario:

  Vector of length one or more with numbers corresponding the scenarios.
  See details for more information. Defaults to 2 for the SSP2 Medium
  scenario.

- country_code:

  Vector of length one or more of country numeric codes based on ISO 3
  digit numeric values.

- country_name:

  Vector of length one or more of country names. The corresponding
  country code will be guessed using the countrycodes package.

- pop_age:

  Character string for population age groups if `indicator` is set to
  `pop`. Defaults to no age groups `total`, but can be set to `all`.

- pop_sex:

  Character string for population sexes if `indicator`is set to `pop`.
  Defaults to no sex `total`, but can be set to `both` or `all`.

- pop_edu:

  Character string for population educational attainment if `indicator`
  is set to `pop`. Defaults to `total`, but can be set to `four`, `six`
  or `eight`.

- include_scenario_names:

  Logical vector of length one to indicate if to include additional
  columns for scenario names and short names. `FALSE` by default.

- server:

  Character string for server to download from. Defaults to `iiasa`, but
  can use `github` or `1&1` if IIASA server is down. Can check
  availability by setting to `search-available`. Note, `1&1` only hosts
  batch files (i.e. measures for all countries)

- version:

  Character string for version of projections to obtain. Defaults to
  `wcde-v3`, but can use `wcde-v2` or `wcde-v1`. Scenario and indicator
  availability vary between versions.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the data selected.

## Details

If no `country_name` or `country_code` is provided data for all
countries and regions are downloaded. A full list of available countries
and regions can be found in the `wic_locations` data frame.

`indicator` must be set to a value in the first column in the table
below of available demographic indicators:

|  |  |
|----|----|
| `indicator` | Indicator Description |
| `pop` | Population Size (000's) |
| `bpop` | Population Size by Broad Age (000's) |
| `epop` | Population Size by Education (000's) |
| `prop` | Educational Attainment Distribution |
| `bprop` | Educational Attainment Distribution by Broad Age |
| `growth` | Average Annual Growth Rate |
| `nirate` | Average Annual Rate of Natural Increase |
| `sexratio` | Sex Ratio |
| `mage` | Population Median Age |
| `tdr` | Total Dependency Ratio |
| `ydr` | Youth Dependency Ratio |
| `odr` | Old-age Dependency Ratio |
| `ryl15` | Age When Remaining Life Expectancy is Below 15 years |
| `pryl15` | Proportion of Population with a Remaining Life Expectancy below 15 Years |
| `mys` | Mean Years of Schooling by Age |
| `bmys` | Mean Years of Schooling by Broad Age |
| `ggapmys15` | Gender Gap in Mean Years Schooling (15+) |
| `ggapmys25` | Gender Gap in Mean Years Schooling (25+) |
| `ggapedu15` | Gender Gap in Educational Attainment (15+) |
| `ggapedu25` | Gender Gap in Educational Attainment (25+) |
| `tfr` | Total Fertility Rate |
| `etfr` | Total Fertility Rate by Education |
| `asfr` | Age-Specific Fertility Rate |
| `easfr` | Age-Specific Fertility Rate by Education |
| `cbr` | Crude Birth Rate |
| `macb` | Mean Age at Childbearing |
| `emacb` | Mean Age at Childbearing by Education |
| `e0` | Life Expectancy at Birth |
| `cdr` | Crude Death Rate |
| `assr` | Age-Specific Survival Ratio |
| `eassr` | Age-Specific Survival Ratio by Education |
| `net` | Net Migration |
| `netedu` | Net Migration Flows by Education |
| `emi` | Emigration Flows |
| `imm` | Immigration Flows |

See `wic_indicators` data frame for more details.

`scenario` must be set to one or values in the first column table below
of the available future scenarios:

|            |                                              |            |
|------------|----------------------------------------------|------------|
| `scenario` | description                                  | version    |
| `1`        | Rapid Development (SSP1)                     | V1, V2, V3 |
| `2`        | Medium (SSP2)                                | V1, V2, V3 |
| `3`        | Stalled Development (SSP3)                   | V1, V2, V3 |
| `4`        | Inequality (SSP4)                            | V1, V3     |
| `5`        | Conventional Development (SSP5)              | V1, V3     |
| `20`       | Medium - Constant Enrollment Rate (SSP2-CER) | V1         |
| `21`       | Medium - Fast Track Education (SSP2-FT)      | V1         |
| `22`       | Medium - Zero Migration (SSP2-ZM)            | V2, V3     |
| `23`       | Medium - Double Migration (SSP2-DM)          | V2, V3     |

See `wic_scenarios` data frame for more details.

## Examples

``` r
# \donttest{
# SSP2 tfr for Austria and Bulgaria
get_wcde(indicator = "tfr", country_code = c(40, 100))
#> # A tibble: 60 × 5
#>    scenario name     country_code period      tfr
#>       <dbl> <chr>           <dbl> <chr>     <dbl>
#>  1        2 Austria            40 1950-1955  2.08
#>  2        2 Bulgaria          100 1950-1955  2.45
#>  3        2 Austria            40 1955-1960  2.52
#>  4        2 Bulgaria          100 1955-1960  2.29
#>  5        2 Austria            40 1960-1965  2.78
#>  6        2 Bulgaria          100 1960-1965  2.24
#>  7        2 Austria            40 1965-1970  2.61
#>  8        2 Bulgaria          100 1965-1970  2.13
#>  9        2 Austria            40 1970-1975  2.08
#> 10        2 Bulgaria          100 1970-1975  2.15
#> # ℹ 50 more rows

# SSP1 and SSP2 life expectancy for Vietnam and United Kingdom (guessing the country codes)
get_wcde(scenario = c(1, 2), indicator = "e0", country_name = c("Vietnam", "UK"))
#> # A tibble: 240 × 6
#>    scenario name                                 country_code sex   period    e0
#>       <dbl> <chr>                                       <dbl> <chr> <chr>  <dbl>
#>  1        1 Viet Nam                                      704 Male  1950-…  45.8
#>  2        1 United Kingdom of Great Britain and…          826 Male  1950-…  66.7
#>  3        1 Viet Nam                                      704 Fema… 1950-…  56.5
#>  4        1 United Kingdom of Great Britain and…          826 Fema… 1950-…  71.8
#>  5        1 Viet Nam                                      704 Male  1955-…  54.1
#>  6        1 United Kingdom of Great Britain and…          826 Male  1955-…  67.7
#>  7        1 Viet Nam                                      704 Fema… 1955-…  61.4
#>  8        1 United Kingdom of Great Britain and…          826 Fema… 1955-…  73.3
#>  9        1 Viet Nam                                      704 Male  1960-…  55.5
#> 10        1 United Kingdom of Great Britain and…          826 Male  1960-…  68  
#> # ℹ 230 more rows

# SSP1 and SSP3 population by education for all countries
get_wcde(scenario = c(1, 3), indicator = "tfr")
#> # A tibble: 13,260 × 5
#>    scenario name                     country_code period      tfr
#>       <dbl> <chr>                           <dbl> <chr>     <dbl>
#>  1        1 Bulgaria                          100 1950-1955  2.45
#>  2        1 Myanmar                           104 1950-1955  5.96
#>  3        1 Burundi                           108 1950-1955  6.91
#>  4        1 Belarus                           112 1950-1955  2.59
#>  5        1 Cambodia                          116 1950-1955  6.64
#>  6        1 Algeria                            12 1950-1955  7.30
#>  7        1 Cameroon                          120 1950-1955  5.50
#>  8        1 Canada                            124 1950-1955  3.63
#>  9        1 Cape Verde                        132 1950-1955  6.55
#> 10        1 Central African Republic          140 1950-1955  5.76
#> # ℹ 13,250 more rows

# population totals (aggregated over age, sex and education)
get_wcde(indicator = "pop", country_name = "Austria")
#> # A tibble: 31 × 5
#>    scenario name    country_code  year   pop
#>       <dbl> <chr>          <dbl> <dbl> <dbl>
#>  1        2 Austria           40  1950 6938.
#>  2        2 Austria           40  1955 6944.
#>  3        2 Austria           40  1960 7029.
#>  4        2 Austria           40  1965 7247.
#>  5        2 Austria           40  1970 7453.
#>  6        2 Austria           40  1975 7590.
#>  7        2 Austria           40  1980 7544.
#>  8        2 Austria           40  1985 7560.
#>  9        2 Austria           40  1990 7646.
#> 10        2 Austria           40  1995 7942.
#> # ℹ 21 more rows

# population totals by education group
get_wcde(indicator = "pop", country_name = "Austria", pop_edu = "four")
#> # A tibble: 155 × 6
#>    scenario name    country_code  year education         pop
#>       <dbl> <fct>          <dbl> <dbl> <fct>           <dbl>
#>  1        2 Austria           40  1950 Under 15       1574. 
#>  2        2 Austria           40  1950 No Education      0.3
#>  3        2 Austria           40  1950 Primary        2660. 
#>  4        2 Austria           40  1950 Secondary      2586. 
#>  5        2 Austria           40  1950 Post Secondary  117  
#>  6        2 Austria           40  1955 Under 15       1571. 
#>  7        2 Austria           40  1955 No Education      0.3
#>  8        2 Austria           40  1955 Primary        2532. 
#>  9        2 Austria           40  1955 Secondary      2683. 
#> 10        2 Austria           40  1955 Post Secondary  158. 
#> # ℹ 145 more rows

# population totals by age-sex group
get_wcde(indicator = "pop", country_name = "Austria", pop_age = "all", pop_sex = "both")
#> # A tibble: 1,302 × 7
#>    scenario name    country_code age    sex    year   pop
#>       <dbl> <chr>          <dbl> <chr>  <chr> <dbl> <dbl>
#>  1        2 Austria           40 0--4   Male   1950  262.
#>  2        2 Austria           40 5--9   Male   1950  296.
#>  3        2 Austria           40 10--14 Male   1950  243.
#>  4        2 Austria           40 15--19 Male   1950  238.
#>  5        2 Austria           40 20--24 Male   1950  241.
#>  6        2 Austria           40 25--29 Male   1950  223.
#>  7        2 Austria           40 30--34 Male   1950  148 
#>  8        2 Austria           40 35--39 Male   1950  228.
#>  9        2 Austria           40 40--44 Male   1950  248.
#> 10        2 Austria           40 45--49 Male   1950  255.
#> # ℹ 1,292 more rows
# }
```
