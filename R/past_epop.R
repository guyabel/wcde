#' Past population sizes for all countries by education
#'
#' A data set containing population sizes for all countries by education between 1950 and 2020
#'
#' @format A data frame with 840,126 rows and 7 variables, including:
#' \describe{
#'   \item{name}{Area name}
#'   \item{country_code}{ISO 3 digit country code}
#'   \item{year}{Year of observation from 1950 to 2020 in five-year steps}
#'   \item{age}{Five-year age groups}
#'   \item{education}{Education group}
#'   \item{sex}{Sex}
#'   \item{epop}{Population size in thousands for each age, sex and education group}
#' }
#' @source \url{http://dataexplorer.wittgensteincentre.org/}
"past_epop"
