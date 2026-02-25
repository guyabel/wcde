# Test if country code or codes are in wic_locations

Intended for internal use.

## Usage

``` r
wcde_location(country_code, version = c("wcde-v3", "wcde-v2", "wcde-v1"))
```

## Arguments

- country_code:

  `vector` of integers representing country codes

## Value

`TRUE` if all codes given to `country_code` are in wic_locations,
`FALSE` if one or more are not.

## Examples

``` r
wcde_location(country_code = c(-11, 44))
#> country code -11 not in Wittgenstein Human Capital Data Explorer for version provided
#> [1] FALSE
wcde_location(country_code = c(100, 44))
#> [1] TRUE
wcde_location(country_code = 3)
#> country code  not in Wittgenstein Human Capital Data Explorer for version provided
#> [1] FALSE
```
