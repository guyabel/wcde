#' Pull multiple vectors for a given indicator, scenarios and .Rdata file names
#'
#' @description Requires a working internet connection. Intended for internal use.
#' @param indicator One character string based on the `name` column in the `wic_indicators` data frame, representing the variable to be interested.
#' @param scenario Vector with a numbers corresponding the scenarios. See details in `wcde` for more information.
#' @param country_code Vector of length one or more of country numeric codes based on ISO 3 digit numeric values.
#'
#' @return A tibble with multiple columns.
#' @export
#' @keywords internal
#'
#' @examples
#' wcde_pull(indicator = "tfr", country_code = "900")
wcde_pull <- function(indicator = NULL, scenario = 2, country_code = NULL){
  # scenario = c(1, 3); indicator = "tfr"; country_code = c(40, 100)
  # scenario = 2; indicator = "e0"; country_code = "900"
  if(length(indicator) > 1){
    message("can only get data on one indicator at a time, taking first indicator given")
    indicator <- indicator[1]
  }
  if(!wcde_location(country_code = country_code)){
    stop("data for one of the country codes not available")
  }
  # if(length(scenario) > 1){
  #   message("can only get data on one scenario at a time, taking first scenario given")
  #   scenario <- scenario[1]
  # }
  if(!all(scenario %in% 1:5)){
    message("scenario must be an integer between 1 and 5")
  }
  v0 <- wcde::wic_indicators %>%
    dplyr::filter(indicator == {{indicator}}) %>%
    dplyr::select(-past) %>%
    dplyr::select_if(is.logical) %>%
    tidyr::pivot_longer(cols = dplyr::everything(), names_to = "v", values_to = "avail") %>%
    dplyr::filter(avail == 1) %>%
    dplyr::pull(v)
  if(!any(v0 == "period"))
    v0 <- c(v0, "year")
  if(any(stringr::str_detect(string = v0, pattern = "bage")))
    v0 <- stringr::str_replace(string = v0, pattern = "bage", "age")
  if(any(stringr::str_detect(string = v0, pattern = "sage")))
    v0 <- stringr::str_replace(string = v0, pattern = "sage", "age")

  v1 <- c(v0, country_code)

  d0 <- tidyr::expand_grid(scenario, indicator, v1) %>%
    dplyr::rename(country_code = 3)

  read_with_progress <- function(f){
    pb$tick()
    readr::read_csv(f, col_types = readr::cols(), guess_max = 1e5)
  }
  pb <- progress::progress_bar$new(total = nrow(d0))
  pb$tick(0)
  d0 <- d0 %>%
    dplyr::mutate(u = paste0("https://raw.githubusercontent.com/guyabel/wcde-data/main/data/ssp",
                             scenario, "/", indicator, "/", country_code, ".csv"),
                  d = purrr::map(.x = u, .f = ~read_with_progress(f = .x))) %>%
    dplyr::group_by(scenario) %>%
    dplyr::summarise(dplyr::bind_cols(d), .groups = "drop_last") %>%
    dplyr::ungroup()
  pb$terminate()

  cc <- which(names(d0) %in% country_code)
  d1 <- tidyr::pivot_longer(data = d0, cols = dplyr::all_of(cc),
                            names_to = "isono", values_to = {{indicator}})
  return(d1)
}
