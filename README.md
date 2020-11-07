
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wcder

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/wcder)](https://CRAN.R-project.org/package=wcder)
<!-- badges: end -->

Download data from the [Wittgenstein Human Capital Data
Explorer](http://dataexplorer.wittgensteincentre.org/wcde-v2/) into R

## Installation

<!-- You can install the released version of wcder from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("wcder") -->

<!-- ``` -->

Install the developmental version with:

``` r
library(devtools)
install_github("guyabel/wcder")
```

## Example

Download data based on a measure, scenario and country code:

``` r
library(wcder)

# SSP2 tfr for Austria and Bulgaria
wcde(measure = "tfr", country_code = c(40, 100))
#> # A tibble: 60 x 5
#>    scenario name     country_code period      tfr
#>       <dbl> <chr>           <dbl> <chr>     <dbl>
#>  1        2 Austria            40 1950-1955  2.1 
#>  2        2 Bulgaria          100 1950-1955  2.53
#>  3        2 Austria            40 1955-1960  2.57
#>  4        2 Bulgaria          100 1955-1960  2.3 
#>  5        2 Austria            40 1960-1965  2.78
#>  6        2 Bulgaria          100 1960-1965  2.22
#>  7        2 Austria            40 1965-1970  2.57
#>  8        2 Bulgaria          100 1965-1970  2.13
#>  9        2 Austria            40 1970-1975  2.04
#> 10        2 Bulgaria          100 1970-1975  2.16
#> # ... with 50 more rows

# SSP1 tfr for Austria and United Kingdom (guessing the country codes)
wcde(scenario = 1, measure = "tfr", country_name = c("Austria", "UK"))
#> # A tibble: 60 x 5
#>    scenario name                                     country_code period     tfr
#>       <dbl> <chr>                                           <dbl> <chr>    <dbl>
#>  1        1 Austria                                            40 1950-19~  2.1 
#>  2        1 United Kingdom of Great Britain and Nor~          826 1950-19~  2.18
#>  3        1 Austria                                            40 1955-19~  2.57
#>  4        1 United Kingdom of Great Britain and Nor~          826 1955-19~  2.49
#>  5        1 Austria                                            40 1960-19~  2.78
#>  6        1 United Kingdom of Great Britain and Nor~          826 1960-19~  2.81
#>  7        1 Austria                                            40 1965-19~  2.57
#>  8        1 United Kingdom of Great Britain and Nor~          826 1965-19~  2.57
#>  9        1 Austria                                            40 1970-19~  2.04
#> 10        1 United Kingdom of Great Britain and Nor~          826 1970-19~  2.01
#> # ... with 50 more rows

# Not Run
# SSP1 population by education for all countries
# library(dplyr)
# wic_locations %>%
#   filter(dim == "country") %>%
#   pull(isono) %>%
#   wcde(scenario = 1, measure = "epop", country_code = .,
#        include_scenario_names = TRUE)
```

<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so: -->

<!-- ```{r cars} -->

<!-- summary(cars) -->

<!-- ``` -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. -->

<!-- You can also embed plots, for example: -->

<!-- ```{r pressure, echo = FALSE} -->

<!-- plot(pressure) -->

<!-- ``` -->

<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub! -->
