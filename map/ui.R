library(shiny)
library(dplyr)
library(ggplot2)
library(mapproj)
library(lubridate)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("911 Calls in Seattle"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       ##sliderInput()
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("map")
    )
  )
))
