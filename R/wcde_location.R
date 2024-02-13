#' Test if country code or codes are in wic_locations
#'
#' @description Intended for internal use.
#'
#' @param country_code `vector` of integers representing country codes
#'
#' @return `TRUE` if all codes given to `country_code` are in wic_locations, `FALSE` if one or more are not.
#' @export
#' @importFrom magrittr %>%
#' @keywords internal
#'
#' @examples
#' wcde_location(country_code = c(-11, 44))
#' wcde_location(country_code = c(100, 44))
#' wcde_location(country_code = 3)
wcde_location <- function(country_code,
                          version = c("wcde-v3", "wcde-v2", "wcde-v1")){
  version <- match.arg(version)
  v <- wcde::wic_locations %>%
    tidyr::pivot_longer(dplyr::contains("wcde"), names_to = "vv", values_to = "avail") %>%
    dplyr::filter(vv == version,
                  avail) %>%
    tidyr::drop_na(isono) %>%
    dplyr::pull(isono)
  x <- sum(!country_code %in% v) == 0
  if(!x){
    ok <- which(country_code %in% v)
    message(paste0("country code ", country_code[-ok], " not in Wittgenstein Human Capital Data Explorer for version provided"))
  }
  return(x)
}
