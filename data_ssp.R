library(tidyverse)
library(fs)

d <- dir_ls(path = "../wcde/", recurse = 2) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = ".RData"),
         str_detect(string = file, pattern = "wcde/df")) %>%
  mutate(dest = str_replace(string = file, pattern = "../wcde/df", replacement = "./data-ssp/ssp"),
         dest = str_replace(string = dest, pattern = ".RData", replacement = ".csv"),
         # on github ssp2 takes folder df1, ssp1 takes folder df2 because of samir's coding system
         dest = ifelse(test = str_detect(string = file, pattern = "df1"),
                       yes = str_replace(string = dest, pattern = "ssp1", replacement = "ssp2"),
                       no = dest),
         dest = ifelse(test = str_detect(string = file, pattern = "df2"),
                       yes = str_replace(string = dest, pattern = "ssp2", replacement = "ssp1"),
                       no = dest),
         dest_dir = dirname(dest))


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
