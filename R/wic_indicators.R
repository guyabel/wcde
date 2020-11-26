#' Indicators used in the Wittgenstein Data Explorer
#'
#' A dataset containing the indicator codes, names and further details used in the Wittgenstein Data Explorer
#'
#' @format A data frame with 31 rows and 8 variables, including:
#' \describe{
#'   \item{indicator}{Short name of indicator to be used in the `indicator` argument of the `wcde()` function}
#'   \item{description}{Brief descripition of indicator}
#'   \item{age}{Indicator variable for the inclsion of breakdowns by five-year age groups in the indicator}
#'   \item{bage}{Indicator variable for the inclsion of breakdowns by broad age groups in the indicator}
#'   \item{sage}{Indicator variable for the inclsion of breakdowns by new born as a age group in the indicator}
#'   \item{sex}{Indicator variable for the inclsion of breakdowns by sex in the indicator}
#'   \item{edu}{Indicator variable for the inclsion of breakdowns by education in the indicator}
#'   \item{period}{Indicator variable a period (flow) indicator}
#'   \item{definition}{Full definition for indicator}
#' }
#' @source \url{http://dataexplorer.wittgensteincentre.org/wcde-v2/}
"wic_indicators"
