#' Indicators used in the Wittgenstein Data Explorer
#'
#' A data set containing the indicator codes, names and further details used in the Wittgenstein Data Explorer
#'
#' @format A data frame with 31 rows and 8 variables, including:
#' \describe{
#'   \item{indicator}{Short name of indicator to be used in the `indicator` argument of the `get_wcde()` function}
#'   \item{description}{Brief description of indicator}
#'   \item{age}{Availability of indicator by five-year age groups}
#'   \item{bage}{Availability of indicator by broad age groups}
#'   \item{sage}{Availability of indicator with a new born age group}
#'   \item{sex}{Availability of indicator by sex}
#'   \item{edu}{Availability of indicator by education}
#'   \item{period}{Indicator is a period (flow)}
#'   \item{past}{Availability of past data for indicator}
#'   \item{definition}{Full definition for indicator}
#' }
#' @source \url{http://dataexplorer.wittgensteincentre.org/wcde-v2/}
"wic_indicators"
