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
      selectInput("color", label = "Select a color:", c(Green = "green", Red = "red",
                                                        Blue = "blue", Grey = "grey",
                                                        Fire = "fire")),
      radioButtons(
        "year",
        "Select a year",
        c("2017", "2018")
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("map")
    )
  )
))
