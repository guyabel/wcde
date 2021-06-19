d <- get_wcde(indicator = "epop", country_code = 900)

w <- d %>%
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
  guides(fill = FALSE)


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
# then had to magic select with paint 3d and painfully
# get the magic selected hex to fix back into a rectangle
# then resize when saving

usethis::use_logo(img = "./hex/logo_paint3d.png")
