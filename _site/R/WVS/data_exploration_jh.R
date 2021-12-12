# Working on cleaned data

library(ggplot2)
library(tidyr)
library(magrittr)
library(corrplot)
library(dplyr)

load("WVS.RData")
head(WVS)

select <- dplyr::select

WVS_old <- WVS
WVS <- WVS %>% rename(Sex=V240,
                      Happiness=V10,
                      Health=V11,
                      Country_Code=V2,
                      Marital_Status=V57,
                      Kids=V58)

WVS <- WVS %>% rename(Education = V248, 
                      Size_of_town=V253,
                      Satisfaction=V23)

WVS <- WVS %>% rename(Income=V239,
                      Age=V242,
                      Volition =V55,
                      Sat_Finance=V59)

WVS <- WVS %>% filter(Sex>0,
               Health>0,
               Satisfaction>0,
               Marital_Status>0,
               Kids>-1,
               Education>0,
               Income>0,
               Volition>0,
               Sat_Finance>0,
               Age>0)

#WVS %>% filter_all(all_vars(. > 0 )) %>% as_tibble()

WVS <- WVS %>% select(-Size_of_town) %>% as_tibble()

WVS <- WVS %>% mutate(Age_std=(Age-mean(Age))/sd(Age))

WVS <- WVS %>% filter(!is.na(Happiness),
                      !is.na(Education))
WVS <- WVS %>% mutate(Kids=ifelse(Kids<0,NA,Kids))


WVS_mean <- WVS %>% group_by(Country_Code) %>% 
  summarise(Happiness=mean(Happiness),
            Health=mean(Health),
            Volition=mean(Volition),
            Age=mean(Age),
            Satisfaction=mean(Satisfaction),
            Income=mean(Income),
            Kids=mean(Kids),
            Sat_Finance=mean(Sat_Finance),
            Education=mean(Education))


ggplot(WVS_mean,aes(x=Satisfaction,y=Happiness)) + geom_point()

ggplot(WVS_mean,aes(x=Age,y=Happiness)) + geom_point()

ggplot(WVS_mean,aes(x=Kids,y=Happiness)) + geom_point()

ggplot(WVS_mean,aes(x=Income,y=Happiness)) + geom_point()


ggpairs(WVS_mean)

table(WVS$Education)

df <- WVS %>% filter(Country_Code==12)

do_models <- function(df){
  lm(Happiness ~ Age + Health + Satisfaction +  Volition + 
       Kids + Sat_finance,
     data=df)
}


library(broom)
WVS_model <- WVS %>% nest(-Country) %>% mutate(model=map(data,do_models))

WVS_model <- WVS_model %>% mutate(model=map(model, tidy))

WVS_coefs <- WVS_model %>% select(-data) %>% unnest(model)

ggplot(WVS_coefs %>% filter(!term=="(Intercept)"), 
       aes(x=term,y=Country,fill=estimate)) + geom_tile() +
  scale_fill_distiller(palette="Paired")

