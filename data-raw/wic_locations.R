library(tidyverse)
library(readxl)
library(countrycode)
library(fs)

wic_locations <- dir_ls("./data-raw", type = "directory") %>%
  as_tibble() %>%
  mutate(d = map(.x = value, .f = ~read_excel(paste0(.x, "/geography.xlsx"))),
         version = str_sub(string = value, start = 12)) %>%
  select(-value) %>%
  unnest(d) %>%
  select(-ggarea, -is185, -edu8, -is171) %>%
  # mutate(alpha3 = countrycode(sourcevar = isono,
  #                             origin = "iso3n",
  #                             dest = "iso3c")) %>%
  arrange(desc(version), dim) %>%
  relocate(name, isono, continent, region) %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = "version") %>%
  replace_na(list("wcde-v1" = FALSE, "wcde-v2" = FALSE, "wcde-v3" = FALSE))

usethis::use_data(wic_locations, overwrite = TRUE)
