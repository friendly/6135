
# Gabe want to go 2nd; randomly order the others.
library(dplyr)
names <- c("Spencer", "Laura", "Kathryn", "Meng", "Jean-Marc")

set.seed(42)       # the seed of the universe
order <- names |>
  sample(size=5) |>
  append("Gabriel", after = 1) |>
  print()

# R trick: I just realized this way to use print() in a pipe expression to display a result 
#   as well as assign to a variable.
# It works because all print methods must return unchanged the object it was passed.
