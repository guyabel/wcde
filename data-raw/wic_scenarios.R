library(tidyverse)
library(readxl)

wic_scenarios <- read_excel("../wcde/meta/dimension.xlsx") %>%
  filter(dim == "scenario") %>%
  rename(scenario = code,
         scenario_name = name,
         scenario_short_name = sname) %>%
  select(contains("scenario")) %>%
  mutate(scenario = case_when(scenario == 1 ~ 2,
                              scenario == 2 ~ 1,
                              TRUE ~ scenario))
wic_scenarios
usethis::use_data(wic_scenarios)
