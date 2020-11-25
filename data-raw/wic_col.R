wic_col4 <- c("lightgrey",
              rgb(202,0,32, max=255),
              rgb(244,165,130, max=255),
              rgb(146,197,222, max=255),
              rgb(5,113,176, max=255))
names(wic_col4) <- c("Under 15", "No Education", "Primary", "Secondary", "Post Secondary")
wic_col4

wic_col6 <- c("lightgrey",
              rgb(178,24,43, max=255),
              rgb(239,138,98, max=255),
              rgb(253,219,199, max=255),
              rgb(209,229,240, max=255),
              rgb(103,169,207, max=255),
              rgb(33,102,172, max=255))
names(wic_col6) <- c("Under 15", "No Education", "Incomplete Primary", "Primary", "Lower Secondary", "Upper Secondary", "Post Secondary")
wic_col6

wic_col8 <- c("lightgrey",
              rgb(178,24,43, max=255),
              rgb(214,96,77, max=255),
              rgb(244,165,130, max=255),
              rgb(253,219,199, max=255),
              rgb(209,229,240, max=255),
              rgb(146,197,222, max=255),
              rgb(67,147,195, max=255),
              rgb(33,102,172, max=255))
names(wic_col8) <- c("Under 15", "No Education", "Incomplete Primary", "Primary", "Lower Secondary", "Upper Secondary", "Short Post Secondary", "Bachelor", "Master and higher")
wic_col8

usethis::use_data(wic_col4, overwrite = TRUE)
usethis::use_data(wic_col6, overwrite = TRUE)
usethis::use_data(wic_col8, overwrite = TRUE)
