library(tidyverse)
library(readxl)
library(fs)

x <- dir_ls("./data-raw", type = "directory") %>%
  as_tibble() %>%
  mutate(d = map(.x = value, .f = ~read_excel(paste0(.x, "/indicator.xlsx"))),
         version = str_sub(string = value, start = 12)) %>%
  select(-value) %>%
  unnest(d) %>%
  select(fullname, name, version, age:edu, period, past, definition) %>%
  relocate(name) %>%
  rename(indicator = 1,
         description = 2) %>%
  mutate_if(is.numeric, as.logical)

# x0 <- x %>%
#   filter(version == "wcde-v3") %>%
#   mutate(version = "wcde-v30")
#
# x1 <- x %>%
#   filter(version == "wcde-v3") %>%
#   mutate(version = "wcde-v31")
#
# x <- x %>%
#   bind_rows(x0) %>%
#   bind_rows(x1)

# latest definition - to many edits which messes up pivot wider later on
d <- x %>%
  arrange(version) %>%
  select(version, indicator, definition) %>%
  group_by(indicator) %>%
  summarise(definition_latest = last(definition))

wic_indicators <- x %>%
  select(-definition) %>%
  mutate(
    # non-consistent
    description = ifelse(indicator == "net" & version != "wcde-v3", NA, description),
    period = ifelse(indicator == "mage" & version == "wcde-v1", FALSE, period),
    # this is not right - no sex in v1 - should be different indicator, will add warning
    sex = ifelse(indicator == "ryl15" & version == "wcde-v1", TRUE, sex)
  ) %>%
  arrange(indicator, desc(version)) %>%
  fill(description, .direction = "down") %>%
  pivot_wider(names_from = "version", values_from = "past") %>%
  relocate(1, 2, contains("wcde")) %>%
  rename(wcde_v1 = `wcde-v1`,
         wcde_v2 = `wcde-v2`,
         wcde_v3 = `wcde-v3`,
         # wcde_v30 = `wcde-v30`,
         # wcde_v31 = `wcde-v31`
         ) %>%
  mutate(
    wcde_v1 = case_when(
      wcde_v1 == FALSE ~ "projection-only",
      wcde_v1 == TRUE ~ "past-available",
    ),
    wcde_v2 = case_when(
      wcde_v2 == FALSE ~ "projection-only",
      wcde_v2 == TRUE ~ "past-available",
    ),
    wcde_v3 = case_when(
      wcde_v3 == FALSE ~ "projection-only",
      wcde_v3 == TRUE ~ "past-available",
    ),
    # wcde_v30 = case_when(
    #   wcde_v30 == FALSE ~ "projection-only",
    #   wcde_v30 == TRUE ~ "past-available",
    # ),
    # wcde_v31 = case_when(
    #   wcde_v31 == FALSE ~ "projection-only",
    #   wcde_v31 == TRUE ~ "past-available",
    # )
  ) %>%
  rename("wcde-v1" = wcde_v1,
         "wcde-v2" = wcde_v2,
         "wcde-v3" = wcde_v3) %>%
  left_join(d)

rm(x, d)
usethis::use_data(wic_indicators, overwrite = TRUE)

