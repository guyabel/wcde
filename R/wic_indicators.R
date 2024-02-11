#' Indicators used in the Wittgenstein Centre Human Capital Data Explorer
#'
#' A data set containing the indicator codes, names and further details used in the Wittgenstein Centre Human Capital Data Explorer
#'
#' @format A data frame with 37 rows and 11 variables, including:
#' \describe{
#'   \item{indicator}{Short name of indicator to be used in the `indicator` argument of the `get_wcde()` function}
#'   \item{description}{Brief description of indicator}
#'   \item{wcde-v3}{Availability in wcde-v3 of `projection-only` or `past-available` (in addition to projections) of indicator. If value is `NA` then indicator not available in version.}
#'   \item{wcde-v2}{Availability in wcde-v2 of `projection-only` or `past-available` (in addition to projections) of indicator. If value is `NA` then indicator not available in version.}
#'   \item{wcde-v1}{Availability in wcde-v1 of `projection-only` or `past-available` (in addition to projections) of indicator. If value is `NA` then indicator not available in version.}
#'   \item{age}{Availability of indicator by five-year age groups}
#'   \item{bage}{Availability of indicator by broad age groups}
#'   \item{sage}{Availability of indicator with a new born age group}
#'   \item{sex}{Availability of indicator by sex}
#'   \item{edu}{Availability of indicator by education}
#'   \item{period}{Indicator is a period (flow)}
#'   \item{definition_latest}{Full definition for indicator based on latest available version}
#' }
#' @source \url{http://dataexplorer.wittgensteincentre.org/}
"wic_indicators"
