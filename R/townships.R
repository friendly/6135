library(seriation)
library(ggplot2)

data("Townships")

order <- seriate(Townships, method = "BEA_TSP")
bertinplot(Townships, order)


x <- Townships

order <- c(
  seriate(dist(x, "minkowski", p = 1)),
  seriate(dist(t(x), "minkowski", p = 1))
)

row_order <- "KHCDGLOBAIEMFPJN" |> 
  strsplit("") |>
  unlist()

col_order <- c(1, 3, 8, 2, 5, 9, 4, 6, 7)

Townships[row_order, col_order ] |> head()

ord <-
  ser_permutation(row_order, col_order)

# Plot
bertinplot(x, ord)


ggbertinplot(x, order)

# highlight values in the 4th quartile
ggbertinplot(x, order, highlight = quantile(x, probs = .75))

# Use different geoms. "none" lets the user specify their own geom.
# Variables set are row, col and x (for the value).

ggbertinplot(x, order, geom = "tile", prop = TRUE)
ggbertinplot(x, order, geom = "rectangle")
ggbertinplot(x, order, geom = "rectangle", prop = TRUE)
ggbertinplot(x, order, geom = "line")
ggbertinplot(x, order, geom = "circle")

