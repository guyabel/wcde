# Education group sums

Cleans `epop` data, downloaded using the `wcde()` function, for
summations of population by 4, 6 or 8 education groups.

## Usage

``` r
edu_group_sum(
  d = NULL,
  n = 4,
  strip_totals = TRUE,
  factor_convert = TRUE,
  year_edu_start = 2020
)
```

## Arguments

- d:

  Data frame downloaded from the

- n:

  Number of education groups (from 4, 6 or 8)

- strip_totals:

  Remove total sums in `epop` column. Will not strip education totals if
  `year < year_edu_start` and `n = 8` as past data on population size by
  8 education groups is unavailable.

- factor_convert:

  Convert columns that are character strings to factors, with levels
  based on order of appearance.

- year_edu_start:

  Year in which education splits are available for given groupings - in
  some versions past data is not available for some education groupings.
  Set to 2020 by default.

## Value

A tibble with the data selected.

## Details

Strips the `epop` data set to relevant rows for the `n` education
groups.

## Examples

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.2.0     ✔ readr     2.2.0
#> ✔ forcats   1.0.1     ✔ stringr   1.6.0
#> ✔ ggplot2   4.0.2     ✔ tibble    3.3.1
#> ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
#> ✔ purrr     1.2.1     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
past_epop %>%
  filter(year == 2020) %>%
  edu_group_sum()
#> # A tibble: 30,000 × 7
#>    name     country_code  year age    sex    education       epop
#>    <fct>           <dbl> <dbl> <fct>  <fct>  <fct>          <dbl>
#>  1 Bulgaria          100  2020 0--4   Male   Under 15       163. 
#>  2 Bulgaria          100  2020 0--4   Female Under 15       154. 
#>  3 Bulgaria          100  2020 5--9   Male   Under 15       171. 
#>  4 Bulgaria          100  2020 5--9   Female Under 15       161. 
#>  5 Bulgaria          100  2020 10--14 Male   Under 15       173. 
#>  6 Bulgaria          100  2020 10--14 Female Under 15       163  
#>  7 Bulgaria          100  2020 15--19 Male   No Education     1.2
#>  8 Bulgaria          100  2020 15--19 Male   Primary         13.3
#>  9 Bulgaria          100  2020 15--19 Male   Secondary      149. 
#> 10 Bulgaria          100  2020 15--19 Male   Post Secondary   0  
#> # ℹ 29,990 more rows
```
