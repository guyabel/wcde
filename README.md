
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wcde <a href="https://guyabel.github.io/wcde/"><img src="man/figures/logo.png" align="right" height="138" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/wcde)](https://CRAN.R-project.org/package=wcde)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/grand-total/wcde?color=blue)](https://r-pkg.org/pkg/wcde)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/guyabel/wcde/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/guyabel/wcde/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

<!-- <img src='https://raw.githubusercontent.com/guyabel/wcde/main/hex/logo_transp.png' align="right" height="200" style="float:right; height:200px;"/> -->

Download data from the [Wittgenstein Centre for Demography and Human
Capital Data Explorer](http://dataexplorer.wittgensteincentre.org/) into
R

See the [pkgdown site](https://guyabel.github.io/wcde/) for full
details.

## Installation

You can install the released version of `wcde` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("wcde")
```

Install the developmental version with:

``` r
library(devtools)
install_github("guyabel/wcde", ref = "main")
```

## Example

Download data based on a indicator, scenario and country code:

``` r
library(wcde)
#> Suggested citation for data:
#> Wittgenstein Centre for Demography and Global Human Capital (WIC) Wittgenstein Centre Data Explorer. Version 3.0 (Beta), 2023

# SSP2 education specific tfr for Austria
get_wcde(indicator = "etfr", country_name = "Austria")
#> # A tibble: 96 × 6
#>    scenario name    country_code education          period     etfr
#>       <dbl> <chr>          <dbl> <chr>              <chr>     <dbl>
#>  1        2 Austria           40 No Education       2020-2025  1.70
#>  2        2 Austria           40 Incomplete Primary 2020-2025  1.70
#>  3        2 Austria           40 Primary            2020-2025  1.70
#>  4        2 Austria           40 Lower Secondary    2020-2025  1.70
#>  5        2 Austria           40 Upper Secondary    2020-2025  1.46
#>  6        2 Austria           40 Post Secondary     2020-2025  1.33
#>  7        2 Austria           40 No Education       2025-2030  1.70
#>  8        2 Austria           40 Incomplete Primary 2025-2030  1.70
#>  9        2 Austria           40 Primary            2025-2030  1.70
#> 10        2 Austria           40 Lower Secondary    2025-2030  1.70
#> # … with 86 more rows

# SSP2 education specific population sizes for Iran and Kenya
get_wcde(indicator = "pop", country_code = c(364, 404), pop_edu = "four")
#> # A tibble: 170 × 6
#>    scenario name                       country_code  year education         pop
#>       <dbl> <fct>                             <dbl> <dbl> <fct>           <dbl>
#>  1        2 Iran (Islamic Republic of)          364  2020 Under 15       20934.
#>  2        2 Iran (Islamic Republic of)          364  2020 No Education    8397.
#>  3        2 Iran (Islamic Republic of)          364  2020 Primary        14412.
#>  4        2 Iran (Islamic Republic of)          364  2020 Secondary      32781.
#>  5        2 Iran (Islamic Republic of)          364  2020 Post Secondary 10465.
#>  6        2 Iran (Islamic Republic of)          364  2025 Under 15       20522.
#>  7        2 Iran (Islamic Republic of)          364  2025 No Education    7559.
#>  8        2 Iran (Islamic Republic of)          364  2025 Primary        14236.
#>  9        2 Iran (Islamic Republic of)          364  2025 Secondary      36161.
#> 10        2 Iran (Islamic Republic of)          364  2025 Post Secondary 12214.
#> # … with 160 more rows

# SSP1, 2 and 3 gender gaps in educational attainment (15+) for all countries
get_wcde(indicator = "ggapedu15", scenario = 1:3)
#> # A tibble: 69,768 × 6
#>    scenario name                     country_code  year education      ggapedu15
#>       <int> <chr>                           <dbl> <dbl> <chr>              <dbl>
#>  1        1 Bulgaria                          100  2020 No Education    -4.33e-3
#>  2        1 Myanmar                           104  2020 No Education    -3.42e-2
#>  3        1 Burundi                           108  2020 No Education     1.22e-1
#>  4        1 Belarus                           112  2020 No Education    -5.71e-4
#>  5        1 Cambodia                          116  2020 No Education    -9.23e-2
#>  6        1 Algeria                            12  2020 No Education    -1.41e-1
#>  7        1 Cameroon                          120  2020 No Education    -9.23e-2
#>  8        1 Canada                            124  2020 No Education    -5.58e-7
#>  9        1 Cape Verde                        132  2020 No Education     1.75e-2
#> 10        1 Central African Republic          140  2020 No Education    -2.60e-1
#> # … with 69,758 more rows
```

## Vignette

The [vignette](https://guyabel.github.io/wcde/articles/wcde.html)
provides many more examples on how to use the package to download data
and produce plots from the Wittgenstein Centre Human Capital Data
Explorer.

<img src="https://raw.githubusercontent.com/guyabel/wcde/main/world6_ssp2.gif" width="600px" height="600px" />

<!-- <img src='world6_ssp2.gif' height="600"/> -->
