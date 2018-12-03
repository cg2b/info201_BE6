


ui <- fluidPage(
  #Application Title 
  titlePanel("INFO 201 BE 6: Social Safety"),
  
  #widget: type of crimes - 30 total  
  sidebarLayout(
    sidebarPanel(
      selectInput("type", label = "Select a Type of Crime", choices = unique(crime.data$Crime.Subcategory)),
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
      ),
      radioButtons("color", label = "Pick Which Neighborhoods",
                   choices = list("Top 20 Crime Neighborhoods" = "top20", "Last 20 Crime Neighborhoods" = "last20")),
      
      selectInput("color", label = "Select a color:", c(Green = "green", Red = "red",
                                                        Blue = "blue", Grey = "grey",
                                                        Fire = "fire")),
      radioButtons(
        "year",
        "Select a year",
        c("2017", "2018")
      )
    ), 
    
    
    mainPanel( 
      
      fluidRow(
        splitLayout(
          cellWidths = c("50%", "50%"),
          plotOutput('pie'),
          plotOutput("barPlot_state")
        ),
        splitLayout(
          cellWidths = c("50%", "50%"), 
          plotOutput("firecall"), 
          plotOutput("crime")),
        splitLayout(
          cellWidths = c("50%", "50%"), 
          textOutput("descrip_map"), 
          plotOutput("map")
        )
      )
    )
      
    
  ) 
)