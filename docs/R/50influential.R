library(rvest)
library(stringr)
library(dplyr)

url <- "https://thebestschools.org/features/most-influential-psychologists-world/"
page <- read_html(url)
items <- page %>% html_nodes("h3") %>% html_text() 
items <- items[grep("More", items, invert=TRUE)]
items <- sub("^\\d+\\. ", "", items, perl=TRUE)

name <- str_extract(items, "[[:alpha:] .]+") %>% str_trim()


mat <- t(matrix(unlist(str_split(items, "\\s+\\| ", n=2)), nrow=2))
colnames(mat) <- c("name", "fields")
dat <- as.data.frame(mat)
