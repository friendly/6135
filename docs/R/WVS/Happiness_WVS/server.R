#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
library(magrittr)
library(dplyr)
library(ggplot2)

WVS_coefs_T <- readRDS("WVS_coefs_Total.Rdata")
WVS_coefs_M <- readRDS("WVS_coefs_Male.Rdata")
WVS_coefs_F <- readRDS("WVS_coefs_Female.Rdata")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$regPlot <- renderPlot({
    
    
    if(input$Sex=="Total"){
      data <- WVS_coefs_T
    } else if(input$Sex=="Male"){
      data <- WVS_coefs_M
    } else{
      data <- WVS_coefs_F
    }
      
    
    
    # draw the histogram with the specified number of bins
    ggplot(data %>% filter(!term=="(Intercept)",
                                Continent==input$Continent), 
           aes(x=term,y=Country,fill=estimate_sig)) + geom_tile() +
      scale_fill_gradient2(low = "red", mid = "white",
                           high = "blue", midpoint = 0, space = "Lab",
                           na.value = "grey50", guide = "colourbar")+
      theme_bw(base_size=16)
    }
  )
  }
)

    