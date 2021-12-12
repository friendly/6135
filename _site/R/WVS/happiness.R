#' Load packages
library(ggplot2)
library(tidyr)
library(magrittr)
library(corrplot)
library(dplyr)
library(stringr)


folder <- file.path(myutil::dropbox_folder(), "Documents", "6135", "R", "WVS")
setwd(folder)
load(file.path(folder, "WVS6.RData"))
names(WVS)

##' Make nicer variable names, for plotting
#WVS <- WVS %>%
#		setNames(str_to_title(names(WVS)))  %>% 
#		rename(Country_Code =`Country Code`)
#		
##' Delete some variables
#WVS <- WVS %>%
#		select(-Volition, -Financial_sat)  
#
#names(WVS)
#

#' Reverse direction of some variables, so that larger number is "more"
WVS <- WVS %>%
		mutate(Happiness =    5-Happiness,
		       Health =       5-Health,
		       Social_class = 6-Social_class)		

#' Make it a tibble
WVS <- WVS %>% as_tibble()

WVS                             

#' Assign continents to countries
library(countrycode)
WVS <- WVS %>%
	 mutate(Continent = countrycode(Country, "country.name", "continent"))

#' Get country means
WVS_mean <- WVS %>% group_by(Country_Code) %>% 
  summarise(Country  =max(Country),
            Happiness=mean(Happiness),
            Health   =mean(Health),
            Age      =mean(Age),
            Life_sat =mean(Life_sat),
            Income   =mean(Income),
            Kids     =mean(Kids),
            Social_class =mean(Social_class),
            Education=mean(Education)
            )
            
#' Assign continents to countries
library(countrycode)
WVS_mean <- WVS_mean %>%
	 mutate(Continent = countrycode(Country, "country.name", "continent"))

ggplot(WVS_mean, aes(x=Continent, y=Happiness)) +
	geom_boxplot(aes(fill=Continent))

#' Label outliers
is_outlier <- function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | x > quantile(x, 0.75) + 1.5 * IQR(x))
}

WVS_mean %>%
	group_by(Continent) %>%
	mutate(outlier = ifelse(is_outlier(Happiness), Country, "")) %>%
	ggplot(., aes(x=Continent, y=Happiness)) +
	geom_boxplot(aes(fill=Continent), alpha=0.5) +
	geom_text(aes(label = outlier), hjust= -0.3)
	



# some plots
ggplot(WVS_mean, aes(x=Age, y=Happiness)) + 
	geom_point(aes(color=Continent, size=Kids), alpha=0.5) +
	geom_smooth(method="loess") 
	

ggplot(WVS_mean, aes(x=Kids, y=Happiness)) + 
	geom_point() +
	geom_smooth(method="loess")  
	

ggplot(WVS_mean, aes(x=Income, y=Happiness)) + 
	geom_point() +
	geom_smooth(method="loess") + 
	scale_y_reverse()

library(ggChernoff)
ggplot(WVS_mean, aes(x=Income, y=Happiness, color=Continent)) + 
	geom_chernoff(aes(smile=Happiness, brow=Kids, nose=Social_class)) +
	geom_smooth(method="loess")  + 
	scale_y_reverse()

#' Fit models for each country

do_model <- function(df){
  lm(Happiness ~ Marital + Kids + Social_class + Sex + Education, 
     data=df)
}

library(broom)
library(purrr)
WVS_model <- WVS %>% 
	nest(-Country) %>% 
	mutate(model=map(data, do_model))

WVS_model <- WVS_model %>% mutate(model=map(model, tidy))

WVS_coefs <- WVS_model %>% select(-data) %>% unnest(model)

ggplot(WVS_coefs %>% filter(!term=="(Intercept)"), 
       aes(x=term,y=Country,fill=estimate)) + 
       geom_tile() +
  scale_fill_distiller(palette="Paired")


