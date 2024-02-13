library(tidyverse)
library(readxl)
library(fs)

wic_scenarios <- dir_ls("./data-raw", type = "directory") %>%
  as_tibble() %>%
  mutate(d = map(.x = value, .f = ~read_excel(paste0(.x, "/dimension.xlsx"))),
         version = str_sub(string = value, start = 12)) %>%
  select(-value) %>%
  unnest(d) %>%
  filter(dim == "scenario") %>%
  rename(scenario = code,
         scenario_name = name,
         scenario_abb = sname) %>%
  select(contains("scenario"), version) %>%
  # arrange(scenario_abb)
  mutate(scenario_name = str_replace(string = scenario_name, pattern = "-", replacement = " - "),
         scenario_name = str_replace(string = scenario_name, pattern = "  -  ", replacement = " - "),
         scenario_name = str_replace(string = scenario_name, pattern = "2 - ", replacement = "2-"),
         scenario_abb = str_extract(string = scenario_name, pattern = "\\(([^)]+)\\)"),
         scenario_abb = str_sub(string = scenario_abb, start = 2, end = -2),
         scenario = case_when(
           scenario_abb == "SSP1" ~ 1,
           scenario_abb == "SSP2" ~ 2,
           scenario_abb == "SSP3" ~ 3,
           scenario_abb == "SSP4" ~ 4,
           scenario_abb == "SSP5" ~ 5,
           scenario_abb == "SSP2-CER" ~ 20,
           scenario_abb == "SSP2-FT" ~ 21,
           scenario_abb == "SSP2-ZM" ~ 22,
           scenario_abb == "SSP2-DM" ~ 23)
         ) %>%
  arrange(desc(version), scenario) %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = "version") %>%
  replace_na(list("wcde-v1" = FALSE, "wcde-v2" = FALSE, "wcde-v3" = FALSE))
wic_scenarios

usethis::use_data(wic_scenarios, overwrite = TRUE)
