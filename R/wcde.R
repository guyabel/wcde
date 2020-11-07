#' Download data from the Wittgenstein Data Explorer
#'
#' @description Downloads data from the Wittgenstein Data Explorer. Requires a working internet connection.
#'
#' @param measure One character string based on the `name` column in the `wic_indicators` data frame, representing the variable to be interested.
#' @param scenario Vector of length one or more with numbers corresponding the scenarios. See details for more information. Defaults to 2 for the SSP2 Medium scenario.
#' @param country_code Vector of length one or more of country numeric codes based on ISO 3 digit numeric values.
#' @param country_name Vector of length one or more of country names. The corresponding country code will be guessed using the countrycodes package.
#' @param include_scenario_names Logical vector of length one to indicate if to include additional columns for scenario names and short names. `FALSE` by default.
#'
#' @details `measure` must be set to a value in the first column in the table below of available demographic indicators:
#'
#' | `measure`   | Indicator description                                                                |
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
#' `scenario` must be set to one or values in the first column table below of the available future scenarios:
#'
#' | `scenario` | description                           |
#' |----------|---------------------------------------|
#' | `1`        | Rapid Development (SSP1)              |
#' | `2`        | Medium (SSP2)                         |
#' | `3`        | Stalled Development (SSP3)            |
#' | `4`        | Medium - Zero Migration (SSP2 - ZM)   |
#' | `5`        | Medium - Double Migration (SSP2 - DM) |
#'
#' @md
#' @return A tibble with the data selected.
#' @export
#'
#' @examples
#' # SSP2 tfr for Austria and Bulgaria
#' wcde(measure = "tfr", country_code = c(40, 100))
#'
#' # SSP2 tfr for Austria and United Kingdom (guessing the country codes)
#' wcde(measure = "tfr", country_name = c("Austria", "UK"))
#'
#' # Not Run
#' # SSP1 and SSP3 population by education for all countries
#' # library(dplyr)
#' # wic_locations %>%
#' #   filter(dim == "country") %>%
#' #   pull(isono) %>%
#' #   wcde(scenario = c(1, 3), measure = "epop", country_code = .)
wcde <- function(measure = "pop", scenario = 2,
                 country_code = NULL, country_name = NULL,
                 include_scenario_names = FALSE){
  # guess country codes from name
  guessed_code <- NULL
  if(!is.null(country_name)){
    guessed_code <- countrycode::countryname(sourcevar = country_name,
                                             destination = "iso3n")
  }
  country_code <- c(country_code, guessed_code)

  d1 <- wcder::wic_indicators %>%
    dplyr::filter(name == measure)
  if(nrow(d1) < 1){
    stop(paste(measure, "not an indicator code in wic_indicators, please select an indicator code in the name column of widc_indicators"))
  }

  d2a <- wcder::wic_locations %>%
    dplyr::select(isono, name)

  d2 <- wcde_pull(measure = measure, scenario = scenario, country_code = country_code) %>%
    tidyr::pivot_longer(cols = -(1:6), names_to = "isono", values_to = {{measure}}) %>%
    dplyr::mutate(isono = as.numeric(isono)) %>%
    dplyr::left_join(d2a, by = "isono") %>%
    {if(include_scenario_names) dplyr::left_join(. , wcder::wic_scenarios, by = "scenario") else .}

  d2 %>%
    {if(d1$period == 0) dplyr::select(., -period) else dplyr::select(., -year)} %>%
    {if(sum(d1$age, d1$bage, d1$sage) == 0) dplyr::select(., -age) else .} %>%
    {if(d1$sex == 0) dplyr::select(., -sex) else .} %>%
    {if(d1$edu == 0) dplyr::select(., -edu) else dplyr::rename(., education=edu)} %>%
    tidyr::drop_na(.) %>%
    dplyr::relocate(dplyr::contains("scenario"), name, isono) %>%
    dplyr::rename(country_code = isono)
}
