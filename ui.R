library("shiny")
library("dplyr")

ui <- fluidPage(
    mainPanel( 
      radioButtons("color", label = "Pick Which Neighborhoods",
                 choices = list("Top 10 Crime Neighborhoods" = "top10", "Last 10 Crime Neighborhoods" = "last10")),
      plotOutput('pie')
    )
  )
