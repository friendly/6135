# script to install needed packages for my courses

# set CRAN mirror
local({r <- getOption("repos")
       r["CRAN"] <- "https://cloud.r-project.org"
       options(repos=r)
       })

# list of packages to install
pkgs <- c("broom", "candisc", "car", "corrgram", "dplyr", "effects", "ggbiplot", "here",
          "ggplot2", "glue",  "heplots", "knitr", "learnr", "MASS", "modelsummary", 
          "palmerpenguins", "stargazer", "rgl", "tidyverse", "visreg") 


# install the above, along with any dependencies
install.packages(pkgs, dependencies=TRUE)
# update any recently modified packages
update.packages(ask='graphics')

