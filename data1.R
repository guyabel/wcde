## not run data1 and dat2 since moving from separate github repo
## wcde-data... but have made edits to the scripts so should work
## if have to do again?

##
## data1: replicate wcde-shiny
## data2: build pop- data sets
## data3: build batch data
##

library(tidyverse)
library(fs)

d <- dir_ls(path = "../wcde-shiny/", recurse = 2) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = ".RData"),
         str_detect(string = file, pattern = "wcde-shiny/df")) %>%
  mutate(i = str_sub(string = file, start = 19),
         i = str_replace(string = i, pattern = ".RData", replacement = ".csv"),
         # on github ssp2 takes folder df1, ssp1 takes folder df2 because of samir's coding system
         s = case_when(
           str_detect(string = file, pattern = "df1") ~ 2,
           str_detect(string = file, pattern = "df2") ~ 1,
           str_detect(string = file, pattern = "df3") ~ 3,
           str_detect(string = file, pattern = "df4") ~ 21,
           str_detect(string = file, pattern = "df5") ~ 22,
         ),
         dest_dir = paste0("./data-host/",s),
         dest = paste0("./data-host/",s,"/",i))


x <- d %>%
  distinct(dest_dir)
for(i in 1:nrow(x))
  dir_create(path = x$dest_dir[i])

loading <- function(rdata_file){
  # rdata_file = d
  e <- new.env()
  load(rdata_file, envir = e)
  e
}

for(i in 1:nrow(d)){
  d$file[i] %>%
    loading() %>%
    as.list() %>%
    as_tibble() %>%
    write_csv(path = d$dest[i])
  if(i %% 100 == 0)
    print(i)
}

