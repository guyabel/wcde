
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wcde

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/wcde)](https://CRAN.R-project.org/package=wcde)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/guyabel/wcde/workflows/R-CMD-check/badge.svg)](https://github.com/guyabel/wcde/actions)
<!-- badges: end -->

<img src='https://raw.githubusercontent.com/guyabel/wcde/main/hex/logo_transp.png' align="right" height="180" style="padding-left: 20px; padding-bottom: 20px;" />

Download data from the [Wittgenstein Centre Human Capital Data
Explorer](http://dataexplorer.wittgensteincentre.org/wcde-v2/) into R

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
#> Wittgenstein Centre for Demography and Global Human Capital (WIC) Wittgenstein Centre Data Explorer. Version 2.0, 2018

# SSP2 education specific tfr for Austria
get_wcde(indicator = "etfr", country_name = "Austria")
#> # A tibble: 102 x 6
#>    scenario name    country_code education          period     etfr
#>       <dbl> <chr>          <dbl> <chr>              <chr>     <dbl>
#>  1        2 Austria           40 No Education       2015-2020  1.64
#>  2        2 Austria           40 Incomplete Primary 2015-2020  1.64
#>  3        2 Austria           40 Primary            2015-2020  1.64
#>  4        2 Austria           40 Lower Secondary    2015-2020  1.66
#>  5        2 Austria           40 Upper Secondary    2015-2020  1.46
#>  6        2 Austria           40 Post Secondary     2015-2020  1.36
#>  7        2 Austria           40 No Education       2020-2025  1.68
#>  8        2 Austria           40 Incomplete Primary 2020-2025  1.68
#>  9        2 Austria           40 Primary            2020-2025  1.68
#> 10        2 Austria           40 Lower Secondary    2020-2025  1.67
#> # ... with 92 more rows

# SSP2 education specific population sizes for Iran and Kenya
get_wcde(indicator = "epop", country_code = c(364, 404))
#> # A tibble: 36,300 x 8
#>    scenario name             country_code age   sex   education      year   epop
#>       <dbl> <chr>                   <dbl> <chr> <chr> <chr>         <dbl>  <dbl>
#>  1        2 Iran (Islamic R~          364 All   Both  Total          1950 17119.
#>  2        2 Kenya                     404 All   Both  Total          1950  6077.
#>  3        2 Iran (Islamic R~          364 All   Both  Under 15       1950  6210 
#>  4        2 Kenya                     404 All   Both  Under 15       1950  2417.
#>  5        2 Iran (Islamic R~          364 All   Both  No Education   1950  9648.
#>  6        2 Kenya                     404 All   Both  No Education   1950  2867.
#>  7        2 Iran (Islamic R~          364 All   Both  Incomplete P~  1950   378 
#>  8        2 Kenya                     404 All   Both  Incomplete P~  1950   555.
#>  9        2 Iran (Islamic R~          364 All   Both  Primary        1950   631.
#> 10        2 Kenya                     404 All   Both  Primary        1950   139.
#> # ... with 36,290 more rows

# SSP1, 2 and 3 gender gaps in educational attainment (15+) for all countries
get_wcde(indicator = "ggapedu15", scenario = 1:3)
#> # A tibble: 124,038 x 6
#>    scenario name                     country_code  year education    ggapedu15
#>       <int> <chr>                           <dbl> <dbl> <chr>            <dbl>
#>  1        1 Bulgaria                          100  1950 No Education       -16
#>  2        1 Myanmar                           104  1950 No Education       -13
#>  3        1 Burundi                           108  1950 No Education       -11
#>  4        1 Belarus                           112  1950 No Education       -10
#>  5        1 Cambodia                          116  1950 No Education       -28
#>  6        1 Algeria                            12  1950 No Education        -6
#>  7        1 Cameroon                          120  1950 No Education       -16
#>  8        1 Canada                            124  1950 No Education        -1
#>  9        1 Cape Verde                        132  1950 No Education       -14
#> 10        1 Central African Republic          140  1950 No Education        -4
#> # ... with 124,028 more rows
```

## Vignette

The [vignette](https://guyabel.github.io/wcde/articles/wcde.html)
provides many more examples on how to use the package to download data
and produce plots from the Wittgenstein Centre Human Capital Data
Explorer.

<img src='https://raw.githubusercontent.com/guyabel/wcde/main/world6_ssp2.gif' height="600"/>

<!-- <img src='world6_ssp2.gif' height="600"/> -->
