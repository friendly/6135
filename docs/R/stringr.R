#' ---
#' title: stringr examples
#' ---

library(stringr)
x <- c("house", "car", "plant", "telephone", "arm chair")
print(x)

# how many letters?
str_length(x)

# detecting characters
str_detect(x, "ar")
# which ones match?
x[str_detect(x, "ar")]

# replacing characters
str_replace(x, "ar", "**")
x |> str_replace("ar", "**")

# change case
str_to_upper(x)
str_to_sentence(x)
str_to_title(x)

# regular expressions: find vowels [aeiou]
str_replace_all(x, "[aeiou]", "_")

library(glue)
name <- "Michael"; food <- "pizza"
glue('My name is {name}. I like {food}.')

food <- c("pizza", "burgers")
glue('My name is {name}. I like {food}.')
