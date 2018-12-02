library("shiny")
library("dplyr")
crime.data <- read.csv("../data/crime.csv")

ui <- fluidPage(
  #Application Title 
  titlePanel("Frequency of Different Types of Crimes based on Time of the Day"),
  
  #widget: type of crimes - 30 total  
  sidebarLayout(
    sidebarPanel(
      selectInput("type", label = "Select a Type of Crime", choices = unique(crime.data$Crime.Subcategory))
      
      
    ), 
    
    
    mainPanel( 
      plotOutput("barPlot_state"),
      textOutput("message")
      
    )
    
  )
)