#' ---
#' title: Using Google fonts with ggplot2
#' ---
# from: https://albert-rapp.de/posts/ggplot2-tips/08_fonts_and_icons/08_fonts_and_icons.html

library(tidyverse)
library(showtext)
library(ggtext)
library(gghighlight)
library(glue)

# Import fonts
# First argument = google name, 
# Secont name = font name in R
font_add_google('Lora', 'lora')
font_add_google('Lobster', 'lobster')
font_add_google('Anton', 'anton')
font_add_google('Fira Sans', 'firasans')
font_add_google('Syne Mono', 'syne')

# Important step to enable showtext font rendering!
showtext_auto()

tib <- tibble(
  family = c('firasans', 'lora', 'lobster', 'anton', 'syne'),
  x = 0,
  y = seq(.9, .1, length.out = 5),
  label = glue('Showtext {family}. What a font!')
)

tib %>%
  ggplot(aes(x, y, label = label)) +
  geom_text(family = tib$family, size = 12, hjust = 0, col = 'dodgerblue4') +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  theme_void() +
  theme(plot.background = element_rect(fill = grey(.90)))


