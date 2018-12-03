library("shiny")
library("dplyr")

ui <- fluidPage(
    mainPanel( 
      radioButtons("color", label = "Pick Which Neighborhoods",
                 choices = list("Top 20 Crime Neighborhoods" = "top20", "Last 20 Crime Neighborhoods" = "last20")),
      plotOutput('pie')
    )
  )
