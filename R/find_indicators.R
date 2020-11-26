#' Find available indicator code names in the Wittgenstein Centre Human Capital Data Explorer
#'
#' @param x Character string on key word or name related to indicator of potential interest.
#'
#' @return A subset of the wic_indicators data frame with one or more of the `indicator`, `description` or `definition` columns matching the keyword given to `x`. Use the result in the `indicator` column to input to the `wcde` function for downloading data.
#' @export
#'
#' @examples
#' find_indicator("education")
#' find_indicator("migr")
#' find_indicator("fert")
find_indicator <- function(x){
  wcder::wic_indicators %>%
    dplyr::select_if(is.character) %>%
    # across and filter any row not directly possible
    dplyr::filter_all(dplyr::any_vars(
      stringr::str_detect(string = .,
                          pattern = stringr::regex(x, ignore_case = TRUE))
    ))
}
