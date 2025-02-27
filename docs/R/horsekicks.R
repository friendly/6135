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

# try to directly label the curves. `This`direct.label` didn't work out, so not finished...
direct.label(plt, method = "top.bumptwice")

# manually position curve labels
curve_labels <- tibble(
  year =   c(1902, 1880, 1892),
  deaths = c(60, 22, 0),
  cause = c("drown", "kick", "fall")
  )

plt + geom_label(data = curve_labels,
                 aes(year, deaths, color = cause, label = cause),
                 size = 6
      )

