#### Shiny Application Example ####

#Loading packages (Note: you must load all the packages you will be using in your Shiny application)
library(shiny)
library(ggplot2)
library(dplyr)
library(ggdist)

#The theme used for the plot
MyTheme<- theme(plot.title = element_text(hjust = 0.5, family = "Times", face = "bold", size = 20),
                axis.title = element_text(hjust = 0.5, family = "Times", face = "bold", size = 19),
                axis.text =  element_text(family = "Times", size = 15),
                axis.text.y = element_text(colour ="white"),
                axis.ticks.y = element_line(colour = "white"),
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA, linewidth = 1),
                plot.subtitle = element_text(family = "times", size = 15))

#User Interface (UI; i.e., all the elements of the application that the user sees or interacts with)

ui <- fluidPage( #fluidPage(): allows the UI to adapt to the screen of the user

    titlePanel("Shiny Application Demonstration"), #titlePanel(): allows you to add a title to the Shiny application
    
    sidebarLayout( #sidebarLayout(): one of the many available shiny application layouts
      
      sidebarPanel( #sidebarPanel(): allows you to customize the contents of the sidebar
        
        p("This is the side bar panel."), #p(): used to add text
        
        sliderInput("Input1", "Select the number of coin flips.", min = 1, max = 10, value = 5), #sliderInput(): used to add an interactive slider
        
        actionButton("Button", "Run Simulation!", width = "50%") #actionButton(): used to add an interactive button
        
        ),

      mainPanel( #mainPanel(): allows you to customize the contents of the main panel
        
        p("This is the main panel."), #p(): used to add text
        
        plotOutput("Plot1"), #plotOutput(): used to leave a visual placeholder for a graph
        
        tableOutput("Table1") #tableOutput(): used to leave a visual placeholder for a table
            )))

#The server (i.e., all the code for the simulation and to generate output)

server <- function(input, output) {
  
  observeEvent(input$Button, { #observeEvent(): runs the code within the brackets once the button in the UI has been clicked
    
    #Simulation code (i.e., simulating the coin flips)
    Input<- input$Input1
    Data<- character(Input)
    for(i in 1:Input){
      Data[i]<- sample(c("Heads", "Tails"), replace = TRUE)
    }
    
    #Creating a data frame for the output
    Data<- data.frame(Outcomes = Data)
    
    #Generating graph displaying count information
    output$Plot1<- renderPlot( #renderPlot(): converts graphs produced in the server
      
      ggplot(Data, aes(x = Outcomes)) + 
        geom_dots(fill = "grey", colour = "black", overlaps = "nudge") + 
        labs(title = "Distribution of Coin Flip Outcomes", x = "", y = "") +
        MyTheme
        
    ) 
    
    #Generating the table with count information
    output$Table1<- renderTable( #renderTable(): converts tables produced in the server 
      Data %>% 
        group_by(Outcomes) %>% 
        summarise(n = n())
      
    )
  })
}

#Run the application 
shinyApp(ui = ui, server = server) #shinyApp(): see the app!  
