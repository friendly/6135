#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Happiness in the world values survey"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Continent","Continent",
                   choices = c("Africa",
                               "Americas",
                               "Asia",
                               "Europe",
                               "Oceania")
                   ),
      selectInput("Sex", "Sex",
                   choices = c("Total",
                               "Male",
                               "Female"))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      p("Regression Coefficients by country"),
      p("Red indicates negative effect on Happiness"),
      p("Blue a positive effect"),
      p("Grey indicates non-significant coefficients"),
      plotOutput("regPlot")
    )
  )
))
