## not run both of these since moving from separate github repo
## wcde-data... but have made edits to the scripts so should work
## if have to do again?

##
## data1: replicate wcde-shiny
## data2: build pop- data sets
## data3: build batch data
##

library(tidyverse)
library(fs)

d <- dir_ls(path = "./data-host/", recurse = 1) %>%
  as_tibble() %>%
  rename(dir = 1) %>%
  filter(str_length(dir) > 14) %>%
  mutate(i = str_remove(string = dir, "./data-host/")) %>%
  separate(col = i, into = c("s", "i"), sep = "/") #%>%
  # github wont allow over 100mb files .. added them to .gitignore
  # filter(!i %in% c("epop", "prop"))


for(i in 1:nrow(d)){
  message(paste(i, "s:", d$s[i], d$i[i]))
  x0 <- dir_ls(path = d$dir[i]) %>%
    as_tibble() %>%
    mutate(
      value = as.character(value),
      n = str_remove(string = value, pattern = d$dir[i]),
      n = str_remove(string = n, pattern = ".csv"),
      n = str_sub(string = n, start = 2),
      v = map(
        .x = value,
        .f = ~read_csv(file = .x, col_types = cols(), guess_max = 1e5)
      ),
    ) %>%
    summarise(bind_cols(v), .groups = "drop_last")

  x1 <- wcde::wic_locations %>%
    select(isono, name)

  cc <- str_which(string = names(x0), pattern = "\\d{1,}")


  ii <- wcde::wic_indicators %>%
    filter(indicator == d$i[i])

  # cc <- which(names(x0) %in% country_code)
  x2 <- x0 %>%
    pivot_longer(cols = all_of(cc), names_to = "isono", values_to = d$i[i]) %>%
    select(-contains("no"), isono) %>%
    mutate(isono = as.numeric(isono)) %>%
    left_join(x1, by = "isono") %>%
    relocate(name, isono, year, period) %>%
    rename(country_code = isono) %>%
    {if(ii$edu) rename(., education=edu) else .} %>%
    {if(ii$edu) . else select(., -edu)} %>%
    {if(any(ii$age, ii$bage, ii$sage)) . else select(., -age)} %>%
    {if(ii$sex) . else select(., -sex)} %>%
    {if(ii$period) . else select(., -period)} %>%
    {if(!ii$period) . else select(., -year)} %>%
    drop_na(.)

  paste0("./data-host-batch/",d$s[i],"/",d$i[i], ".csv") %>%
    write_csv(x = x2, file = .)
}

