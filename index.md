# wcde

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
#>  1        2 Austria           40 No Education       2020-2025   1.7
#>  2        2 Austria           40 Incomplete Primary 2020-2025   1.7
#>  3        2 Austria           40 Primary            2020-2025   1.7
#>  4        2 Austria           40 Lower Secondary    2020-2025   1.7
#>  5        2 Austria           40 Upper Secondary    2020-2025   1.5
#>  6        2 Austria           40 Post Secondary     2020-2025   1.3
#>  7        2 Austria           40 No Education       2025-2030   1.7
#>  8        2 Austria           40 Incomplete Primary 2025-2030   1.7
#>  9        2 Austria           40 Primary            2025-2030   1.7
#> 10        2 Austria           40 Lower Secondary    2025-2030   1.7
#> # ℹ 86 more rows

# SSP2 education specific population sizes for Iran and Kenya
get_wcde(indicator = "pop", country_code = c(364, 404), pop_edu = "four")
#> # A tibble: 310 × 6
#>    scenario name                       country_code  year education         pop
#>       <dbl> <fct>                             <dbl> <dbl> <fct>           <dbl>
#>  1        2 Iran (Islamic Republic of)          364  1950 Under 15       6086. 
#>  2        2 Iran (Islamic Republic of)          364  1950 No Education   8854. 
#>  3        2 Iran (Islamic Republic of)          364  1950 Primary        1444. 
#>  4        2 Iran (Islamic Republic of)          364  1950 Secondary       236. 
#>  5        2 Iran (Islamic Republic of)          364  1950 Post Secondary   21.5
#>  6        2 Iran (Islamic Republic of)          364  1955 Under 15       7289. 
#>  7        2 Iran (Islamic Republic of)          364  1955 No Education   9328  
#>  8        2 Iran (Islamic Republic of)          364  1955 Primary        1620  
#>  9        2 Iran (Islamic Republic of)          364  1955 Secondary       368. 
#> 10        2 Iran (Islamic Republic of)          364  1955 Post Secondary   44.5
#> # ℹ 300 more rows

# SSP1, 2 and 3 gender gaps in educational attainment (15+) for all countries
get_wcde(indicator = "ggapedu15", scenario = 1:3)
#> # A tibble: 167,274 × 6
#>    scenario name                     country_code  year education ggapedu15
#>       <int> <chr>                           <dbl> <dbl> <chr>         <dbl>
#>  1        1 Bulgaria                          100  1950 Under 15        0.8
#>  2        1 Myanmar                           104  1950 Under 15        1.1
#>  3        1 Burundi                           108  1950 Under 15        1.8
#>  4        1 Belarus                           112  1950 Under 15        6.1
#>  5        1 Cambodia                          116  1950 Under 15        0.7
#>  6        1 Algeria                            12  1950 Under 15        0  
#>  7        1 Cameroon                          120  1950 Under 15        1  
#>  8        1 Canada                            124  1950 Under 15        0.2
#>  9        1 Cape Verde                        132  1950 Under 15        5.9
#> 10        1 Central African Republic          140  1950 Under 15        0.8
#> # ℹ 167,264 more rows
```

## Vignette

The [vignette](https://guyabel.github.io/wcde/articles/wcde.html)
provides many more examples on how to use the package to download data
and produce plots from the Wittgenstein Centre Human Capital Data
Explorer.

![](https://raw.githubusercontent.com/guyabel/wcde/main/world6_ssp2.gif)
