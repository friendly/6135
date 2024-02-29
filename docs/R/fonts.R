#' ---
#' title: changing fonts in ggplot2
#' ---
# from: https://statisticaloddsandends.wordpress.com/2021/07/08/using-different-fonts-with-ggplot2/

library(ggplot2)
theme_set(theme_gray(base_size = 14))
base_fig <- ggplot(data = economics, aes(date, pop)) +
  geom_line(linewidth = 1.3) +
  labs(title = "Total US population over time",
       subtitle = "Population in thousands",
       x = "Date",
       y = "Total population (in thousands)")

base_fig

#' To change all text in the figure to `serif`, we just need to update the text option of the theme as follows:

base_fig +
  theme(text = element_text(family = "serif"))

#' ggplot allows you to change the font of each part of the figure: you just need to 
#' know the correct option to modify in the theme. (For a full list of customizable components of the theme, see this documentation.)

base_fig +
  theme(plot.title    = element_text(family = "mono"),
        plot.subtitle = element_text(family = "sans"),
        axis.title.x  = element_text(family = "Comic Sans MS"),
        axis.title.y  = element_text(family = "AppleGothic"),
        axis.text.x   = element_text(family = "Optima"),
        axis.text.y   = element_text(family = "Luminari"))
