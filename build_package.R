library(usethis)
# create_tidy_package(path = "Github/tidywpp")
# usethis::use_badge()
usethis::use_pipe()
usethis::use_tibble()
usethis::use_build_ignore(
  c("tests", "data-host", "data-host-batch", "build_package.R", "data-raw",
    "data1.R", "data2.R"))

roxygen2::roxygenise()

usethis::use_spell_check()
usethis::use_release_issue()
usethis::use_citation()
usethis::use_package()
usethis::use_tidy_thanks()


# think this is for the help files?
library(tidyverse)
library(tidywpp)
wpp_indicators %>%
  select(1:2, file_group) %>%
  distinct() %>%
  arrange(name) %>%
  knitr::kable() %>%
  write_lines('temp.md')

wpp_indicators %>%
  select(contains("var")) %>%
  distinct() %>%
  knitr::kable() %>%
  write_lines('temp.md')

file.remove("temp.md")
