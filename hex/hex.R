# d <- get_wcde(indicator = "epop", country_code = 900)
library(wcde)
library(tidyverse)
library(lemon)

w <- past_epop %>%
  mutate(scenario = 2) %>%
  edu_group_sum(n = 6) %>%
  filter(year == 2020) %>%
  mutate(pop = ifelse(test = sex == "Male", yes = -epop, no = epop),
         pop = pop/1e3)

g <-
ggplot(data = w,
       mapping = aes(x = pop, y = age, fill = fct_rev(education))) +
  geom_col() +
  # geom_vline(xintercept = 0, colour = "black") +
  scale_x_symmetric(labels = abs, breaks = scales::pretty_breaks(n = 10)) +
  scale_fill_manual(values = wic_col6, name = "Education") +
  theme_void() +
  guides(fill = "none")

library(hexSticker)
library(showtext)
font_add_google("Raleway", regular.wt = 700)

sticker(g, package="wcde",
        p_size = 45, p_color = "grey20",
        p_family = "Raleway", p_y = 1.12,
        s_x = 1, s_y = 1.05,
        s_width=4, s_height=4,
        filename="./hex/logo.png",
        # spotlight = TRUE, l_x = 0.25,
        h_color = "grey20",
        h_fill = "grey90",
        white_around_sticker = TRUE)

file.show("./hex/logo.png")

library(magick)
p <- image_read("./hex/logo.png")
pp <-
  p %>%
  image_chop(geometry = "x1") %>%
  image_extent(geometry = "518x600", gravity = "south") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 4, point = "+1+1") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 4, point = "+517+1") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 4, point = "+1+599") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 4, point = "+517+599")
image_write(image = pp, path = "./hex/logo_transp.png")
file.show("./hex/logo_transp.png")
usethis::use_logo(img = "./hex/logo_transp.png")


# previously to magick above...
# then had to magic select with paint 3d and painfully
# get the magic selected hex to fix back into a rectangle
# then resize when saving
# usethis::use_logo(img = "./hex/logo_paint3d.png")
