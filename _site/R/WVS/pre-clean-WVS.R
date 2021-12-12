# pre-cleaning of the WVS data

library(tidyr)
library(magrittr)
library(dplyr)
library(stringr)

folder <- file.path(myutil::dropbox_folder(), "Documents", "6135", "R", "WVS")
cd(folder)
load(file.path(folder, "WVS.RData"))
head(WVS)

#' Make nicer variable names, for plotting
WVS <- WVS %>%
		setNames(str_to_title(names(WVS)))  %>% 
		rename(Country_Code =`Country Code`)
		
#' Delete some variables
WVS <- WVS %>%
		select(-Volition, -Financial_sat)  

names(WVS)

save(WVS, file="WVS6.RData")


