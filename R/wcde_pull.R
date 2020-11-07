#' Pull multiple vectors for a given measure, scenarios and .Rdata file names
#'
#' @description Requires a working internet connection. Intended for internal use.
#' @param measure One character string based on the `name` column in the `wic_indicators` data frame, representing the variable to be interested.
#' @param scenario Vector of length one with a number corresponding the scenarios. See details for more information.
#' @param country_code Vector of length one or more of country numeric codes based on ISO 3 digit numeric values.
#'
#' @return A tibble with multiple columns.
#' @export
#' @keywords internal
#'
#' @examples
#' wcde_pull(measure = "tfr", country_code = "900")
#'
#' # Not Run
#' # library(dplyr)
#' # wcder::wic_locations %>%
#' #   filter(dim == "country") %>%
#' #   pull(isono) %>%
#' #   wcde_pull(measure = "tfr", country_code = .)
wcde_pull <- function(measure = NULL, scenario = 2, country_code = NULL){
  # scenario = c(1, 3); measure = "tfr"; country_code = c(40, 100)
  if(length(measure) > 1){
    message("can only get data on one measure at a time, taking first measure given")
    measure <- measure[1]
  }
  if(length(scenario) > 1){
    message("can only get data on one scenario at a time, taking first scenario given")
    scenario <- scenario[1]
  }
  # on github ssp2 takes folder df1, ssp1 takes folder df2 because of samir's coding system
  s <- dplyr::case_when(scenario == 1 ~ "2",
                        scenario == 2 ~ "1",
                        TRUE ~ as.character(scenario))

  v0 <- c("period", "year", "age", "sex", "edu")
  v1 <- c(v0, country_code)

  d0 <- tibble::tibble(measure, scenario = s, v1) %>%
    dplyr::rename(country_code = 3)

  # d0$n <- 1:nrow(d0)
  pb <- progress::progress_bar$new(total = nrow(d0))
  pb$tick(0)
  d0$d <- purrr::pmap(
    .l = list(mm = d0$measure, ss = d0$scenario, cc = d0$country_code),
    # in order to get progress bar, need to define .f here not call from another function
    .f = function(mm, ss, cc){
      v0 <- c("period", "year", "age", "sex", "edu")
      if(!cc %in% v0){
        if(!wcde_location(country_code = cc)){
          stop()
        }
      }
      pb$tick()
      u <- paste0("https://github.com/guyabel/wcde/raw/master/df",
                  ss, "/", mm, "/", cc, ".RData")
      d <- u %>%
        url() %>%
        loading() %>%
        as.list() %>%
        tibble::as_tibble()
      close(con = url(u))
      return(d)
    })
  pb$terminate()

  # use scenario not s - s is just to match samir coding
  d1 <- dplyr::bind_cols(scenario = scenario, d0$d)
  return(d1)
}
