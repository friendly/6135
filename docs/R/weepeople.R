# Using weepeople font in dataviz
# From: https://github.com/mjskay/uncertainty-examples/blob/master/weepeople_dotplots.md

library(systemfonts)
library(ggplot2)
library(ggdist)
library(showtext)

theme_set(theme_ggdist(base_size = 16))

# Download the Wee People font:
  
download.file(
  url = "https://github.com/propublica/weepeople/raw/master/weepeople.ttf",
  destfile = "C:/Dropbox/incoming/fonts/weepeople/weepeople.ttf"
)

# And register it so we can use it with `family = "weepeople"`:
  
register_font(
  name = "WeePeople",
  plain = "C:/Dropbox/incoming/fonts/weepeople/weepeople.ttf"
)

#sysfonts::
font_add("WeePeople", regular = "C:/Fonts/weepeople/weepeople.ttf")

showtext_auto()

registry_fonts()

# What fonts do I have?
fonts_df <- sysfonts::font_files()
View(fonts_df)

# Or try, 
windowsFonts(WeePeople=windowsFont("WeePeople"))

set.seed(1234)

# sample data set
df = data.frame(
  x = qnorm(ppoints(100), 1:2),
  set = c("a", "b"),
  icon = factor(sample(52, 100, replace = TRUE))
) 

# the lower and upper case letters in the Wee People font are people:
people = c(letters, toupper(letters))

df |>
  ggplot(aes(x = x, y = set, group = set, shape = icon)) + 
  geom_dots(family = "WeePeople") + 
  scale_shape_manual(values = people, guide = "none")

df |>
  ggplot(aes(x = x, y = set, group = set, shape = icon, color = x > 0)) + 
  geom_dots(family = "WeePeople", dotsize = 2.4, layout = "swarm") +
  scale_shape_manual(values = people, guide = "none") +
  scale_color_brewer(palette = "Set1", guide = "none")

# add a `pointinterval` to show mean and 67%, 89% intervals
df |>
  ggplot(aes(x = x, y = set, group = set, shape = icon, color = x > 0)) + 
  geom_dots(family = "WeePeople", dotsize = 2.4, layout = "swarm") +
  stat_pointinterval(aes(interval_color = set),
                     interval_size_range = c(1, 3)) +
  scale_shape_manual(values = people, guide = "none") +
  scale_color_brewer(palette = "Set1", guide = "none") +
  theme(legend.position = "none")


