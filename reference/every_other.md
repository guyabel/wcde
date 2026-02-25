# Select every other (nth) element from a vector

Select every other (nth) element from a vector

## Usage

``` r
every_other(x, n = 2, start = 1, fill = NULL)
```

## Arguments

- x:

  Vector to select (remove) elements from

- n:

  Numeric value for the number of elements to skip. Default is 2, i.e.
  skips every second element

- start:

  Numeric value to indicate which element of the vector to commence
  from.

- fill:

  Character string to be used in place of skipped element. By default is
  `NULL` and hence skipped elements are removed rather than replaced.

## Value

Vector with elements removed

## Examples

``` r
every_other(x = letters)
#>  [1] "a" "c" "e" "g" "i" "k" "m" "o" "q" "s" "u" "w" "y"
every_other(LETTERS, n = 3, start = 6)
#> [1] "F" "I" "L" "O" "R" "U" "X"
every_other(x = letters, fill = "")
#>  [1] "a" ""  "c" ""  "e" ""  "g" ""  "i" ""  "k" ""  "m" ""  "o" ""  "q" ""  "s"
#> [20] ""  "u" ""  "w" ""  "y" "" 
```
