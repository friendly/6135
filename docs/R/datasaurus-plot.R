#' ---
#' title: "datasauRus plot"
#' author: "Michael Friendly"
#' date: "19 Mar 2021"
#' ---

#from: https://t.co/c4GP3FM3Sa?amp=1

install.packages("datasauRus")
library(datasauRus)     # Datasets from the Datasaurus Dozen
library(viridis)        # Colorblind-Friendly Color Maps for R
library(dplyr)
library(ggplot2)

# dataset summaries
datasaurus_dozen %>% 
  group_by(dataset) %>% 
  summarize(
    mean_x    = mean(x),
    mean_y    = mean(y),
    std_dev_x = sd(x),
    std_dev_y = sd(y),
    corr_x_y  = cor(x, y)
  )

# plots
dp <- ggplot(datasaurus_dozen, aes(x=x, y=y, colour=dataset))+
      geom_point()+
      theme_void()+
      theme(legend.position = "none")+
      facet_wrap(~dataset, ncol=3)
dp + scale_colour_viridis_d(option = "plasma")
