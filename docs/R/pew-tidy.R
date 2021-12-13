#' ---
#' title: "Data tidying with dplyr and tidyr"
#' author: "Michael Friendly"
#' date: "03 Apr 2018"
#' ---



#' ## Load packages

library(dplyr)
library(tidyr)
library(ggplot2)

#' ## read a data set
pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = FALSE
)

#' Take a small subset for this example
(pew1 <- pew[1:4, 1:6])  # small subset 

#' ## Use `gather` to convert to long format
pew_long <- gather(pew1, "income", "frequency", 2:6)

#' ## pipes
#' We can combine several steps using the "pipe" operator, `%>%`

pew_long <- pew1 %>%
		gather("income", "frequency", 2:6) %>%
		mutate(income = ordered(income, levels=unique(income))) 

# split income into low/high

pew_long %>%
		mutate(inc = gsub("[\\$k]", "", income)) %>%
		mutate(inc = gsub("<", "0-", inc)) %>%
		separate(inc, c("low", "high"), "-") %>%
		head

#' ## make some bar plots
ggplot(pew_long, aes(x=religion, fill=income)) +
		geom_bar(aes(weight=frequency))

#' ## income on the horizontal axis
ggplot(pew_long, aes(x=income, fill=religion)) +
		geom_bar(aes(weight=frequency))

#' ## put the steps together, piping pew1 -> gather, etc. -> ggplot
pew1 %>%
		gather("income", "frequency", 2:6) %>%
		mutate(income = ordered(income, levels=unique(income))) %>%
		ggplot(aes(x=income, fill=religion)) +
			geom_bar(aes(weight=frequency))

pew_long

#' ## go back the other way, from long to wide,  with `spread`
spread(pew_long, income, frequency)


#' Another way to convert wide to long
library(reshape2)
pew_tidy <- melt(
  data = pew1,
  id = "religion",
  variable.name = "income",
  value.name = "frequency"
)

