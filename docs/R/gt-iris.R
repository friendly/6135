library(gt)
library(dplyr)
library(here)

setwd(here("images/Rstudio"))

set.seed(42)

iris_tab <-
iris %>%
  sample_n(5) %>%
  gt() %>%
  tab_header(
    title = "Anderson's Iris Data",
    subtitle = "(Collected in the Gaspe Penninsula)"
  )

gtsave(iris_tab, "gt-iris1.png")

iris_tab <-
  iris_tab %>%
  tab_spanner(
    label = "Sepal",
    columns = c(Sepal.Length, Sepal.Width)
  )  %>%
  tab_spanner(
    label = "Petal",
    columns = c(Petal.Length, Petal.Width)
  ) #%>%

gtsave(iris_tab, "gt-iris2.png")

iris_tab <-
  iris_tab %>%
  cols_label(
    Sepal.Length = "Length",
    Sepal.Width = "Width",
    Petal.Length = "Length",
    Petal.Width = "Width"
  ) %>%
  tab_options(
    heading.background.color = "#c6dbef",
    column_labels.background.color = "#edf8fb"
  )

gtsave(iris_tab, "gt-iris3.png")
