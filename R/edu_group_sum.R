#' Education Group Sums
#'
#' @description Cleans `epop` data downloaded using the `wcde()` function for summations of population by 4, 6 or 8 education groups.
#'
#' @param d Data frame downloaded from the
#' @param n Number of education groups (from 4, 6 or 8)
#' @param strip_totals Remove total sums in `epop` column. Will not strip education totals if `year < 2015` and `n = 8` as past data on population size by 8 education groups is unavailable.
#' @param factor_convert Convert columns that are character strings to factors, with levels based on order of appearance.
#'
#' @details Strips the `epop` data set to relevant rows for the `n` education groups.
#' @md
#' @return A tibble with the data selected.
#' @export
#'
#' @examples
#' library(tidyverse)
#' epop_ssp2 %>%
#'   filter(year == 2020) %>%
#'   mutate(scenario = 2) %>%
#'   edu_group_sum()
edu_group_sum <- function(d = NULL, n = 4, strip_totals = TRUE, factor_convert = TRUE){
  if(!n %in% c(4, 6, 8))
    stop("number of education groups must be 4, 6 or 8")
  if(!"epop" %in% names(d))
    stop("d must be a population data set, with epop column name")
  d0 <- d %>%
    {if(strip_totals) dplyr::filter(., age != "All", sex != "Both") else . } %>%
    {if(strip_totals & n != 8) dplyr::filter(., education != "Total") else . }
  if(n == 4){
    d1 <- d0 %>%
      dplyr::filter(!education %in% names(wcde::wic_col8)[7:9]) %>%
      dplyr::mutate(education = stringr::str_remove(string = education, pattern = "Incomplete |Lower |Upper ")) %>%
      {if(factor_convert) dplyr::mutate_if(., is.character, forcats::fct_inorder) else . } %>%
      dplyr::group_by(scenario, name, country_code, year, age, sex, education) %>%
      dplyr::summarise(epop = sum(epop), .groups = "drop_last") %>%
      dplyr::ungroup()
  }
  if(n == 6){
    d1 <- d0 %>%
      dplyr::filter(!education %in% names(wcde::wic_col8)[7:9]) %>%
      {if(factor_convert) dplyr::mutate_if(., is.character, forcats::fct_inorder) else . } %>%
      dplyr::group_by(scenario, name, country_code, year, age, sex, education) %>%
      dplyr::summarise(epop = sum(epop)) %>%
      dplyr::ungroup()
  }
  if(n == 8){
    d1 <- d0 %>%
      dplyr::filter(!education == "Post Secondary") %>%
      {if(factor_convert) dplyr::mutate_if(., is.character, forcats::fct_inorder) else . } %>%
      dplyr::group_by(scenario, name, country_code, year, age, sex, education) %>%
      dplyr::summarise(epop = sum(epop)) %>%
      dplyr::ungroup() %>%
      # all education splits to zero if less than 2015
      dplyr::mutate(epop = ifelse(year < 2015 & education != "Total", 0, epop)) %>%
      # fill in missing rows for masters etc pre 2015
      tidyr::complete(scenario, name, country_code, year, age, sex, education, fill = list(epop = 0)) %>%
      {if(strip_totals & year >= 2015) dplyr::filter(., education != "Total") else . }
  }
  return(d1)
}
