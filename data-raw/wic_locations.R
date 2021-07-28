library(tidyverse)
library(readxl)
library(countrycode)

wic_locations <- read_excel("../wcde-shiny/meta/geography.xlsx") %>%
  select(-ggarea, -is185, -edu8) %>%
  # mutate(alpha3 = countrycode(sourcevar = isono,
  #                             origin = "iso3n",
  #                             dest = "iso3c")) %>%
  arrange(dim) %>%
  relocate(name, isono, continent, region)
usethis::use_data(wic_locations, overwrite = TRUE)
