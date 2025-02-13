library(dplyr)
library(tidyr)
library(ggplot2)
library(geomtextpath)
library(directlabels)

install.packages("Horsekicks")
data(hkdeaths, package = "Horsekicks")

hksum <- hkdeaths |>
  select(year, corps, kick:fall) |>
  group_by(year) |>
  summarise(kick = sum(kick),
            drown = sum(drown),
            fall = sum(fall)) |>
  pivot_longer(cols = kick:fall,
               names_to ="cause", values_to = "deaths") 

plt <- ggplot(data = hksum, aes(year, deaths, color = cause)) +
  geom_point(size = 2.5) +
  geom_line(linewidth = 1.3) +
  labs(y = "Number of deaths", x = "Year", color = "Cause\nof death") +
  theme_bw(base_size = 14) +
  theme(legend.position = "inside",
        legend.position.inside = c(.85, .8))
plt

direct.label(plt, method = "top.bumptwice")

curve_labels <- tibble(
  year =   c(1910, ),
  deaths = c(60, ),
  cause = c("drowned", )
)

