usethis::use_build_ignore(
  c("tests", "build_package.R", "data-raw")
)

roxygen2::roxygenise()

# move data-host and data-host-bulk outside of directory whilst
# doing check https://community.rstudio.com/t/r-cmd-check-preparing-package/27151
devtools::build(vignettes = FALSE)
devtools::check(vignettes = FALSE)
devtools::build()
devtools::check()
file.show("NEWS.md")

##
## these are key if devtools::check() is working by github actions are not
##
usethis::use_github_action_check_standard()
usethis::use_github_action("pkgdown")
usethis::use_github_actions_badge()
file.show("NEWS.md")




usethis::use_pkgdown()
roxygen2::roxygenise()
pkgdown::build_site()
pkgdown::build_site(run_dont_run = TRUE)
pkgdown::build_reference()


usethis::use_badge()
cranlogs::cranlogs_badge(package_name = "wcde", summary = "grand-total")

usethis::use_github_action_check_standard()
usethis::use_github_action("pkgdown")
usethis::use_github_actions_badge()


devtools::build_vignettes()
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
