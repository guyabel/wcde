#' Pull a single vector for a given measure, scenario and .Rdata file name
#'
#' @description Builds the URL to the Github repo of the Wittgenstein Data Explorer for the given measure, scenario and country code or label vector. Requires a working internet connection. Intended for internal use. Not used anymore as cannot get working with `pmap()`
#' @param measure One character string based on the `name` column in the `wic_indicators` data frame, representing the variable to be interested.
#' @param scenario Vector of length one with a number corresponding the scenarios. See details for more information.
#' @param country_code Vector of length one with a country numeric code or label vector.
#'
#' @return A tibble with one column, where the column name matches the value given to `measure`
#' @export
#' @keywords internal
#'
#' @examples
#' wcde_pull_single(measure = "tfr", country_code = "900")
wcde_pull_single <- function(measure = NULL, scenario = 2, country_code = NULL){
  # measure = "tfr"; scenario = 2; country_code = 900
  v0 <- c("period", "year", "age", "sex", "edu")
  if(!country_code %in% v0){
    if(!wcde_location(country_code = country_code)){
      stop()
    }
  }

  # e$pb$tick()
  d <- paste0("https://github.com/guyabel/wcde/raw/master/df",
              scenario, "/", measure, "/", country_code, ".RData") %>%
    url() %>%
    loading() %>%
    as.list() %>%
    tibble::as_tibble()
  closeAllConnections()
  return(d)
}
