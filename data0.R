##
## data0: build pop- data sets wcde
## data1: build pop- data sets fume
## data2: build batch data
##

library(tidyverse)
library(fs)

##
## read in data
##
# education age sex data
e <- dir_ls(recurse = 3) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "epop"),
         str_detect(string = file, pattern = "rds")) %>%
  filter(str_detect(string = file, pattern = "wcde-")) %>%
  mutate(file = as.character(file),
         path = path_dir(file),
         path = path_dir(path),
         s = str_sub(string = path, start = 15, end = 17),
         s = str_remove_all(string = s, pattern = "\\/"),
         d0 = map(.x = file, .f = ~readRDS(.x)),
         version = str_sub(string = file, end = 7)) %>%
  group_by(version, s, path) %>%
  summarize(d1 = list(reduce(d0, bind_cols)))

# age sex data (maybe it covers more countries?)
p <- dir_ls(recurse = 3) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "pop"),
         str_detect(string = file, pattern = "rds"),
         str_detect(string = file, pattern = "bpop", negate = TRUE),
         str_detect(string = file, pattern = "epop", negate = TRUE),
         str_detect(string = file, pattern = "pop-", negate = TRUE)) %>%
  mutate(file = as.character(file),
         path = path_dir(file),
         path = path_dir(path),
         s = str_sub(string = path, start = 15, end = 17),
         s = str_remove(string = s, pattern = "\\/"),
         s = str_remove_all(string = s, pattern = "\\/"),
         d0 = map(.x = file, .f = ~readRDS(.x)),
         version = str_sub(string = file, end = 7)) %>%
  group_by(version, s, path) %>%
  summarize(d1 = list(reduce(d0, bind_cols)))


##
## create pop-directories
##
for(i in 1:nrow(p)){
  for(j in c("/pop-total",
             "/pop-age", "/pop-sex", "/pop-edattain",
             "/pop-age-sex", "/pop-age-edattain", "/pop-sex-edattain",
             "/pop-age-sex-edattain")){
    dir_create(path = paste0(p$path[i],"/",j))
  }
}
# pop-age-sex does not have the all (age, sex) categories that pop has
# pop-age-sex-edattian does not have the all (age, sex and edattian) categories that epop has

##
## pop-total
##

p0 <- p %>%
  group_by(version, s, path) %>%
  mutate(total = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex == "Both", edu == "Total")})) %>%
  mutate(sex = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex != "Both", edu == "Total")})) %>%
  mutate(age = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex == "Both", edu == "Total")})) %>%
  mutate(`age-sex` = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex != "Both", edu == "Total")}))


for(i in 1:nrow(p0)){
  message(p0$path[i])
  for(k in 1:4){
    kk <- names(p0)[5:8][k]
    message(kk)
    d <- p0[i,k+4][[1]][[1]]
    for(j in 1:ncol(d)){
      gc()
      f <- paste0(p0$path[i], "/pop-", kk , "/",names(d)[j], ".rds")
      d %>%
        select(j) %>%
        saveRDS(file = f)
    }
  }
}



##
## pop-edattain
##

e0 <- e %>%
  group_by(version, s, path) %>%
  mutate(edattain = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex == "Both", edu != "Total")})) %>%
  mutate(`age-edattain` = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex == "Both", edu != "Total")})) %>%
  mutate(`sex-edattain` = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex != "Both", edu != "Total")})) %>%
  mutate(`age-sex-edattain` = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex != "Both", edu != "Total")}))


for(i in 1:nrow(e0)){
  message(e0$path[i])
  for(k in 1:4){
    kk <- names(e0)[5:8][k]
    message(kk)
    d <- e0[i,k+4][[1]][[1]]
    for(j in 1:ncol(d)){
      gc()
      f <- paste0(e0$path[i], "/pop-", kk , "/",names(d)[j], ".rds")
      d %>%
        select(j) %>%
        saveRDS(file = f)
    }
  }
}


##
## check no 0MB file sizes
##
library(fs)
dir_info(path = "./wcde-v2-single/", recurse = TRUE, type = "file") %>%
  arrange(size)
