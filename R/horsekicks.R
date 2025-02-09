library(dplyr)
library(tidyr)
library(ggplot2)

install.packages("Horsekicks")

data(hkdeaths, package = "Horsekicks")

hkdeaths |>
  select(year, corps, kick:drown) |>
  group_by(year) |>
  summarise
  pivot_longer(cols = kick:drown) |> str()

