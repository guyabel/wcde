library(tidyverse)
library(fs)

d <- dir_ls(path = "../wcde-data/data/", recurse = 1) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "epop|prop")) %>%
  filter(!str_detect(string = file, pattern = "bprop")) %>%
  mutate(file = as.character(file),
         i = str_remove(string = file, "../wcde-data/data/ssp"),
         s = str_sub(string = i, start = 1, end = 1),
         file = str_replace(string = file, pattern = "/data/",
                            replacement = "/data-batch/"),
         file = paste0(file, ".csv"),
         d = map(.x = file, .f = ~read_csv(file = .x)))

d0 <- d %>%
  filter(str_detect(file, "epop")) %>%
  unnest(d) %>%
  select(-file, -i)

d1 <- d %>%
  filter(str_detect(file, "prop")) %>%
  select(-file) %>%
  unnest(d)

epop_ssp2 <- d0 %>%
  filter(s == 2,
         # country_code < 900,
         age != "All",
         education != "Total",
         sex != "Both"
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
usethis::use_data(epop_ssp2, overwrite = TRUE)
