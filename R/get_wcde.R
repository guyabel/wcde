#' Download data from the Wittgenstein Centre Human Capital Data Explorer
#'
#' @description Downloads data from the Wittgenstein Centre Human Capital Data Explorer. Requires a working internet connection.
#'
#' @param indicator One character string based on the `indicator` column in the `wic_indicators` data frame, representing the variable to be downloaded.
#' @param scenario Vector of length one or more with numbers corresponding the scenarios. See details for more information. Defaults to 2 for the SSP2 Medium scenario.
#' @param country_code Vector of length one or more of country numeric codes based on ISO 3 digit numeric values.
#' @param country_name Vector of length one or more of country names. The corresponding country code will be guessed using the countrycodes package.
#' @param pop_age Character string for population age groups if `indicator` is set to `pop`. Defaults to no age groups `total`, but can be set to `all`.
#' @param pop_sex Character string for population sexes if `indicator`is set to `pop`. Defaults to no sex `total`, but can be set to `both` or `all`.
#' @param pop_edu Character string for population educational attainment if `indicator` is set to `pop`. Defaults to `total`, but can be set to `four`, `six` or `eight`.
#' @param include_scenario_names Logical vector of length one to indicate if to include additional columns for scenario names and short names. `FALSE` by default.
#'
#' @details If not `country_name` or `country_code` is provided data for all countries and regions are downloaded. A full list of available countries and regions can be found in the `wic_locations` data frame.
#'
#' `indicator` must be set to a value in the first column in the table below of available demographic indicators:
#'
#' | `indicator`   | Indicator Description                                                                |
#' |-----------|----------------------------------------------------------------------------|
#' | `pop`       | Population Size (000's)                                                    |
#' | `bpop`      | Population Size by Broad Age (000's)                                       |
#' | `epop`      | Population Size by Education (000's)                                       |
#' | `prop`      | Educational Attainment Distribution                                        |
#' | `bprop`     | Educational Attainment Distribution by Broad Age                         |
#' | `growth`    | Average Annual Growth Rate                                                 |
#' | `nirate`    | Average Annual Rate of Natural Increase                                    |
#' | `sexratio`  | Sex Ratio                                                                  |
#' | `mage`      | Population Median Age                                                      |
#' | `tdr`       | Total Dependency Ratio                                                     |
#' | `ydr`       | Youth Dependency Ratio                                                     |
#' | `odr`       | Old-age Dependency Ratio                                                   |
#' | `ryl15`     | Age When Remaining Life Expectancy is Below 15 years                     |
#' | `pryl15`    | Proportion of Population with a Remaining Life Expectancy below 15 Years |
#' | `mys`       | Mean Years of Schooling by Age                                             |
#' | `bmys`      | Mean Years of Schooling by Broad Age                                       |
#' | `ggapmys15` | Gender Gap in Mean Years Schooling (15+)                                   |
#' | `ggapmys25` | Gender Gap in Mean Years Schooling (25+)                                   |
#' | `ggapedu15` | Gender Gap in Educational Attainment (15+)                               |
#' | `ggapedu25` | Gender Gap in Educational Attainment (25+)                               |
#' | `tfr`       | Total Fertility Rate                                                       |
#' | `etfr`      | Total Fertility Rate by Education                                          |
#' | `asfr`      | Age-Specific Fertility Rate                                                |
#' | `easfr`     | Age-Specific Fertility Rate by Education                  |
#' | `cbr`       | Crude Birth Rate                                                           |
#' | `macb`      | Mean Age at Childbearing                                                   |
#' | `e0`        | Life Expectancy at Birth                                                   |
#' | `cdr`       | Crude Death Rate                                                           |
#' | `assr`      | Age-Specific Survival Ratio                                                |
#' | `eassr`     | Age-Specific Survival Ratio by Education                                   |
#' | `net`       | Net Migration                                                              |
#'
#' See `wic_indicators` data frame for more details.
#'
#' `scenario` must be set to one or values in the first column table below of the available future scenarios:
#'
#' | `scenario` | description                           |
#' |----------|---------------------------------------|
#' | `1`        | Rapid Development (SSP1)              |
#' | `2`        | Medium (SSP2)                         |
#' | `3`        | Stalled Development (SSP3)            |
#' | `21`        | Medium - Zero Migration (SSP2 - ZM)   |
#' | `22`        | Medium - Double Migration (SSP2 - DM) |
#'
#' See `wic_scenarios` data frame for more details.
#'
#'
#' @md
#' @return A [tibble][tibble::tibble-package] with the data selected.
#' @export
#'
#' @examples
#' \donttest{
#' # SSP2 tfr for Austria and Bulgaria
#' get_wcde(indicator = "tfr", country_code = c(40, 100))
#'
#' # SSP1 and SSP2 life expectancy for Vietnam and United Kingdom (guessing the country codes)
#' get_wcde(scenario = c(1, 2), indicator = "e0", country_name = c("Vietnam", "UK"))
#'
#' # SSP1 and SSP3 population by education for all countries
#' get_wcde(scenario = c(1, 3), indicator = "tfr")
#'
#' # population totals (aggregated over age, sex and education)
#' get_wcde(indicator = "pop", country_name = "Austria")
#'
#' # population totals by education group
#' get_wcde(indicator = "pop", country_name = "Austria", pop_edu = "four")
#'
#' # population totals by age-sex group
#' get_wcde(indicator = "pop", country_name = "Austria", pop_age = "all", pop_sex = "both")
#' }
get_wcde <- function(
    indicator = "pop", scenario = 2,
    country_code = NULL, country_name = NULL,
    pop_age = c("total", "all"),
    pop_sex = c("total", "both", "all"),
    pop_edu = c("total", "four", "six", "eight"),
    include_scenario_names = FALSE){
  # scenario = 2; indicator = "epop"; country_code = c(410, 288); country_name = NULL; include_scenario_names = FALSE
  # guess country codes from name

  guessed_code <- NULL
  if(!is.null(country_name)){
    guessed_country <- countrycode::countryname(country_name)
    guessed_code <- countrycode::countrycode(
      sourcevar = guessed_country, origin = "country.name", destination = "iso3n"
    )
  }
  country_code <- c(country_code, guessed_code)

  if(indicator == "pop"){
    pop_age <- match.arg(pop_age)
    pop_sex <- match.arg(pop_sex)
    pop_edu <- match.arg(pop_edu)
    if(pop_age == "total" & pop_sex == "total" & pop_edu == "total")
      indicator <- "pop-total"
    if(pop_age == "total" & pop_sex == "both" & pop_edu == "total")
      indicator <- "pop-sex"
    if(pop_age == "total" & pop_sex == "total" & pop_edu %in% c("four", "six", "eight"))
      indicator <- "pop-edattain"
    if(pop_age == "all" & pop_sex == "total" & pop_edu == "total")
      indicator <- "pop-age"
    if(pop_age == "all" & pop_sex == "both" & pop_edu == "total")
      indicator <- "pop-age-sex"
    if(pop_age == "all" & pop_sex == "total" & pop_edu %in% c("four", "six", "eight"))
      indicator <- "pop-age-edattain"
    # if(pop_age == "all" & pop_sex == "all" & pop_edu == "total")
    #   indicator <- "pop"
    if(pop_age == "total" & pop_sex == "both" & pop_edu %in% c("four", "six", "eight"))
      indicator <- "pop-sex-edattain"
    if(pop_age == "all" & pop_sex == "both" & pop_edu %in% c("four", "six", "eight"))
      indicator <- "pop-age-sex-edattain"
    if(pop_age == "all" & pop_sex == "all" & pop_edu %in% c("four", "six", "eight"))
      indicator <- "epop"
  }

  d1 <- wcde::wic_indicators %>%
    dplyr::filter(indicator == {{indicator}})

  if(nrow(d1) < 1 & !stringr::str_detect(string = indicator, pattern = "pop-")){
    stop(paste(indicator, "not an indicator code in wic_indicators, please select an indicator code in the name column of widc_indicators"))
  }

  if(nrow(d1) == 0){
    d1 <- tibble::tibble(
      age = stringr::str_detect(string = indicator, pattern = "age"),
      sex = stringr::str_detect(string = indicator, pattern = "sex"),
      edu = stringr::str_detect(string = indicator, pattern = "edattain"),
      bage = FALSE,
      sage = FALSE,
      period = FALSE
    )
  }

  if(is.null(country_code)){
    d2 <- tibble::tibble(scenario = scenario) %>%
      dplyr::mutate(
        u = paste0("http://dataexplorer.wittgensteincentre.org/wcde-data/data-batch/",
                   scenario, "/", indicator, ".csv"),
        d = purrr::map(
          .x = u,
          .f = ~readr::read_csv(.x, col_types = readr::cols(), guess_max = 1e5)
          )
        ) %>%
      dplyr::select(-u) %>%
      tidyr::unnest(d) %>%
      {if(include_scenario_names) dplyr::left_join(. , wcde::wic_scenarios, by = "scenario") else .}
  }

  if(!is.null(country_code)){
    d2a <- wcde::wic_locations %>%
      dplyr::select(isono, name)

    d2 <- get_wcde_single(indicator = indicator, scenario = scenario, country_code = country_code) %>%
      dplyr::mutate(isono = as.numeric(isono)) %>%
      dplyr::left_join(d2a, by = "isono") %>%
      {if(include_scenario_names) dplyr::left_join(. , wcde::wic_scenarios, by = "scenario") else .}

    d2 <- d2 %>%
      # {if(d1$period) dplyr::select(., -period) else dplyr::select(., -year)} %>%
      # {if(sum(d1$age, d1$bage, d1$sage) == 0) dplyr::select(., -age) else .} %>%
      # {if(d1$sex) dplyr::select(., -sex) else .} %>%
      # {if(d1$edu) dplyr::select(., -edu) else dplyr::rename(., education=edu)} %>%
      {if(d1$edu) dplyr::rename(., education=edu) else .} %>%
      tidyr::drop_na(.) %>%
      dplyr::relocate(dplyr::contains("scenario"), name, isono) %>%
      dplyr::rename(country_code = isono) %>%
      {if(stringr::str_detect(string = indicator, pattern = "-")) dplyr::rename(. , pop = dplyr::all_of(indicator)) else .}

    if(stringr::str_detect(string = indicator, pattern = "pop-")){
      # ^ avoids epop
      if(pop_edu != "total"){
        n_edu <- switch(pop_edu,
                        "four" = 4,
                        "six" = 6,
                        "eight" = 8
        )
        d2 <- d2 %>%
          {if(pop_age == "total") dplyr::mutate(., age = "All") else .} %>%
          {if(pop_sex == "total") dplyr::mutate(., sex = "All") else .} %>%
          dplyr::rename(epop = pop) %>%
          edu_group_sum(n = n_edu, strip_totals = FALSE) %>%
          {if(pop_age == "total") dplyr::select(., -age) else .} %>%
          {if(pop_sex == "total") dplyr::select(., -sex) else .} %>%
          dplyr::rename(pop = epop)
      }
    }
  }
  return(d2)
}
