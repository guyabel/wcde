##
## data1: replicate wcde-shiny
## data2: build pop- data sets
## data3: build batch data
##

library(tidyverse)
library(fs)

##
## read in data
##
# education age sex data
e <- dir_ls(path = "./data-host/", recurse = 2) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "epop"),
         str_detect(string = file, pattern = "csv")) %>%
  mutate(file = as.character(file),
         s = str_sub(string = file, start = 13, end = 14),
         s = str_remove(string = s, pattern = "\\/"),
         d0 = map(.x = file, .f = ~read_csv(file = .x))) %>%
  group_by(s) %>%
  summarize(d1 = list(reduce(d0, bind_cols)))


# age sex data (maybe it covers more countries?)
p <- dir_ls(path = "./data-host/", recurse = 2) %>%
  as_tibble() %>%
  rename(file = 1) %>%
  filter(str_detect(string = file, pattern = "pop"),
         str_detect(string = file, pattern = "csv"),
         str_detect(string = file, pattern = "bpop", negate = TRUE),
         str_detect(string = file, pattern = "epop", negate = TRUE)) %>%
  mutate(file = as.character(file),
         s = str_sub(string = file, start = 13, end = 14),
         s = str_remove(string = s, pattern = "\\/"),
         d0 = map(.x = file, .f = ~read_csv(file = .x))) %>%
  group_by(s) %>%
  summarize(d1 = list(reduce(d0, bind_cols)))


##
## create pop-directories
##
for(i in 1:nrow(p)){
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-total"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-age"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-sex"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-edattain"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-age-sex"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-sex-edattain"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-age-edattain"))
  dir_create(path = paste0("./data-host/",p$s[i], "/pop-age-sex-edattain"))
}
# pop-age-sex does not have the all (age, sex) categories that pop has
# pop-age-sex-edattian does not have the all (age, sex and edattian) categories that epop has

##
## pop-age
##

p0 <- p %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex == "Both", edu == "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-total/",names(.), ".csv"))
  }
}


##
## pop-sex
##

p0 <- p %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex != "Both", edu == "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-sex/",names(.), ".csv"))
  }
}

##
## pop-age
##

p0 <- p %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex == "Both", edu == "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-age/",names(.), ".csv"))
  }
}


##
## pop-edattain
##

p0 <- e %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex == "Both", edu != "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-edattain/",names(.), ".csv"))
  }
}

##
## pop-age-sex
##

p0 <- p %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex != "Both", edu == "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-age-sex/",names(.), ".csv"))
  }
}


##
## pop-age-edattain
##

p0 <- e %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex == "Both", edu != "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-age-edattain/",names(.), ".csv"))
  }
}


##
## pop-sex-edattain
##

p0 <- e %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age == "All", sex != "Both", edu != "Total")})) %>%
  select(-d1)

for(i in 1:5){
  message(i)
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-sex-edattain/",names(.), ".csv"))
  }
}


##
## pop-age-sex-edattain
##

p0 <- e %>%
  group_by(s) %>%
  mutate(d2 = map(.x = d1, .f = function(d = .x){
    d %>%
      relocate(ncol(.) - 0:7) %>%
      filter(age != "All", sex != "Both", edu != "Total")})) %>%
  select(-d1)

for(i in 1:5){
  for(j in 1:ncol(p0$d2[[i]])){
    p0$d2[[i]] %>%
      select(j) %>%
      write_csv(file = paste0("./data-host/", p0$s[i], "/pop-age-sex-edattain/",names(.), ".csv"))
  }
}
