library(tidyverse)
library(fs)

d <- dir_ls(path = "./data-host-batch/", recurse = 1) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "epop|prop")) %>%
  filter(!str_detect(string = file, pattern = "bprop")) %>%
  mutate(file = as.character(file),
         d = map(.x = file, .f = ~read_csv(file = .x)))

d <- d %>%
  mutate(s = str_remove(string = file, pattern = "./data-host-batch/"),
         s = str_remove(string = s, pattern = "/epop.csv"),
         s = str_remove(string = s, pattern = "/prop.csv"),
         s = as.numeric(s))

d0 <- d %>%
  filter(str_detect(file, "epop")) %>%
  unnest(d)

# d1 <- d %>%
#   filter(str_detect(file, "prop")) %>%
#   select(-file) %>%
#   unnest(d)

epop_ssp2 <- d0 %>%
  filter(s == 2,
         country_code < 900,
         age != "All",
         education != "Total",
         sex != "Both",
         # year <= 2020
         ) %>%
  distinct() %>%
  # select(-name) %>%
  select(-s)
# %>%
#   mutate(ageno = fct_inorder(age),
#          ageno = as.numeric(ageno),
#          sexno = fct_inorder(sex),
#          sexno = as.numeric(sexno),
#          eduno = fct_inorder(education),
#          eduno = as.numeric(eduno)) %>%
#   select(-age, -sex, -education)
# usethis::use_data(epop_ssp2, overwrite = TRUE)


past_epop <- d0 %>%
  filter(s == 2,
         country_code < 900,
         age != "All",
         education != "Total",
         sex != "Both",
         year <= 2020
  ) %>%
  distinct() %>%
  # select(-name) %>%
  select(-s, -file)


usethis::use_data(past_epop, overwrite = TRUE)
