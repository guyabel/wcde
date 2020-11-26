
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
install_github("guyabel/wcder", ref = "main")
```

## Example

Download data based on a measure, scenario and country code:

``` r
library(wcder)

# SSP2 education specific tfr for Austria and Bulgaria
wcde(indicator = "etfr", country_code = c(40, 100))
#> # A tibble: 204 x 6
#>    scenario name     country_code education          period     etfr
#>       <dbl> <chr>           <dbl> <chr>              <chr>     <dbl>
#>  1        2 Austria            40 No Education       2015-2020  1.64
#>  2        2 Bulgaria          100 No Education       2015-2020  1.72
#>  3        2 Austria            40 Incomplete Primary 2015-2020  1.64
#>  4        2 Bulgaria          100 Incomplete Primary 2015-2020  1.72
#>  5        2 Austria            40 Primary            2015-2020  1.64
#>  6        2 Bulgaria          100 Primary            2015-2020  1.72
#>  7        2 Austria            40 Lower Secondary    2015-2020  1.66
#>  8        2 Bulgaria          100 Lower Secondary    2015-2020  1.73
#>  9        2 Austria            40 Upper Secondary    2015-2020  1.46
#> 10        2 Bulgaria          100 Upper Secondary    2015-2020  1.44
#> # ... with 194 more rows

# SSP1 and SSP2 education specific tfr for Austria and United Kingdom (guessing the country codes)
wcde(scenario = c(1, 2), indicator = "etfr", country_name = c("Austria", "UK"))
#> # A tibble: 408 x 6
#>    scenario name                        country_code education     period   etfr
#>       <dbl> <chr>                              <dbl> <chr>         <chr>   <dbl>
#>  1        1 Austria                               40 No Education  2015-2~  1.53
#>  2        1 United Kingdom of Great Br~          826 No Education  2015-2~  1.98
#>  3        1 Austria                               40 Incomplete P~ 2015-2~  1.53
#>  4        1 United Kingdom of Great Br~          826 Incomplete P~ 2015-2~  1.98
#>  5        1 Austria                               40 Primary       2015-2~  1.53
#>  6        1 United Kingdom of Great Br~          826 Primary       2015-2~  1.98
#>  7        1 Austria                               40 Lower Second~ 2015-2~  1.54
#>  8        1 United Kingdom of Great Br~          826 Lower Second~ 2015-2~  2   
#>  9        1 Austria                               40 Upper Second~ 2015-2~  1.35
#> 10        1 United Kingdom of Great Br~          826 Upper Second~ 2015-2~  1.76
#> # ... with 398 more rows

# Not Run
# SSP1 population by education for all countries
# library(dplyr)
# wic_locations %>%
#   filter(dim == "country") %>%
#   pull(isono) %>%
#   wcde(scenario = 1, measure = "epop", country_code = ., include_scenario_names = TRUE)
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
