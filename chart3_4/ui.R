

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage({
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "firecall",
        label = "Distribution of Firecall: Select a year",
        choices = list("summary" = 1, "2017" = "2017", "2018" = "2018"),
        selected = 1
      ),
      radioButtons(
        "crime",
        label = "Distribution of Crime: Select a year",
        choices = list("summary" = 1, "2017" = "2017", "2018" = "2018"),
        selected = 1
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        splitLayout(
          cellWidths = c("50%", "50%"), 
          plotOutput("firecall"), 
          plotOutput("crime")
          )
      ),
      tags$code("would it", tags$b("work?")),
      tags$em("Maybe")
    )
  )

})