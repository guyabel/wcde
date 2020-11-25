library(tidyverse)
library(readxl)

wic_indicators <- read_excel("../wcde/meta/indicator.xlsx") %>%
  select(fullname, name, age:edu, period, definition) %>%
  relocate(name) %>%
  rename(indicator = 1,
         description = 2)

usethis::use_data(wic_indicators, overwrite = TRUE)
