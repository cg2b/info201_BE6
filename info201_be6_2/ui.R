
library("shiny")

ui <- fluidPage(
  fluidRow(
    
    column(
      10,
      offset = 1,
      tags$h2(tags$b("INFO 201 BE6: Social Security"))
    ),
    
    tags$br(),
    # summary of the project
    column(
      7,
      offset = 1,
      tags$br(),
      tags$br(),
      tags$div(textOutput("summary"))
    ),
    
    # basic info of team
    column(3,
           offset = 1,
           tags$blockquote(
           tags$b("Group BE6"),
           tags$br(),
           tags$div("This is the distribution of our work:"),
           tags$br(),
           tags$li(tags$b("Elizabeth:"), "pie chart"),
           tags$li(tags$b("Yingrui:"), "bar part"),
           tags$li(tags$b("Colton:"), "map part"),
           tags$li(tags$b("Cheng:"), "Foverview and summarise into a shiny app")
           )
    )
  ),
  
  tags$br(),
  tags$br(),
  
  # 1
  fluidRow(
    
    # title
    column(
      11,
      offset = 1,
      tags$h2(tags$b("1 Overview"))
    ),
    
    # Overview text & plots
    column(
      8,
      offset = 1,
      fluidRow(
        splitLayout(
          cellWidths = c("50%", "50%"), 
          plotOutput("firecall"), 
          plotOutput("crime")
          
        )
        
      )
    ),
    
    # widgets of Overview
    column(
      3,
      tags$br(),
      tags$br(),
      tags$br(),
      tags$br(),
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
    
    column(
      10,
      offset = 1,
      tags$br(),
      tags$div("my description here ahhhh")
    )
    
  ),
  
    tags$br(),
    tags$br(),
    
   # 2
    fluidRow( 
      
      # title
      column(
        11,
        offset = 1,
        tags$h2(tags$b("2 Crime Dataset Exploration"))
        
      ),
      
      # text & plots
    column(
      8,
      offset = 1,
      splitLayout(
        cellWidths = c("50%", "50%"),
        plotOutput('pie'),
        plotOutput("barPlot_state")
      )
    
    ), 
    
    # widgets of Crime Dataset Exploration
    column(
      3,
      tags$br(),
      tags$br(),
      tags$br(),
      tags$br(),
      # type of crimes
      selectInput("type", 
                  label = "Select a Type of Crime", 
                  choices = unique(crime.data$Crime.Subcategory)
      ),
      # crime neiborhoods
      radioButtons("rank", 
                   label = "Pick Which Neighborhoods",
                   choices = list("Top 20 Crime Neighborhoods" = "top20", 
                                  "Last 20 Crime Neighborhoods" = "last20")
      )
      
    ),
    
    column(
      10,
      offset = 1,
      tags$br(),
      tags$h4(tags$b("2.1 Pie Chart")),
      tags$div(textOutput("descrip_pie")),
      tags$br(),
      tags$h4(tags$b("2.2 Bar Chart")),
      tags$div(textOutput("descrip_bar"))
    )
    
  ),
  
    tags$br(),
    tags$br(),

  # 3  
  fluidRow(  
    
    # title
    column(
      11,
      offset = 1,
      tags$h2(tags$b("3 Firecalls Dataset Exploration"))
    ),
    
    # text & plot
    column(
      8,
      offset = 1,
      splitLayout(
        cellWidths = c("50%", "50%"),
        tags$div(textOutput("descrip_map")),
        plotOutput("map"),
        cellArgs = list(style='white-space: normal;')
      )
    ),
    
    # widgets of 911 Dataset Exploration
    column(
      3,
      tags$br(),
      tags$br(),
      tags$br(),
      tags$br(),
      selectInput("color", 
                  label = "Select a color:", 
                  c(Green = "green", 
                    Red = "red", 
                    Blue = "blue", 
                    Grey = "grey", 
                    Fire = "fire")
                  ),
      radioButtons(
        "year",
        "Select a year",
        c("2017", "2018")
      )
    )
    
  )  
      
      
    
)
  
