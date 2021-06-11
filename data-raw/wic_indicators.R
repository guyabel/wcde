library(tidyverse)
library(readxl)

wic_indicators <- read_excel("../wcde-shiny/meta/indicator.xlsx") %>%
  select(fullname, name, age:edu, period, past, definition) %>%
  relocate(name) %>%
  rename(indicator = 1,
         description = 2) %>%
  mutate_if(is.numeric, as.logical)

usethis::use_data(wic_indicators, overwrite = TRUE)
