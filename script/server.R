library("shiny")
library("dplyr")
crime.data <- read.csv("../data/crime.csv")

server <- function(input, output) {
  input_data <- reactive({ 
    type.data <- filter(crime.data, crime.data$Crime.Subcategory == input$type)
    time.category <- c("morning", "afternoon", "night", "midnight")
    if (type.data$Crime.Subcategory == "GAMBLE") {
      morning.freq <- nrow(type.data) - count(type.data, type.data$Occurred.Time >= 800 & type.data$Occurred.Time < 1200)[[1,2]]
      afternoon.freq <- nrow(type.data) - count(type.data, type.data1$Occurred.Time >= 1200 & type.data$Occurred.Time < 1700)[[1,2]]
      night.freq <- count(type.data, type.data$Occurred.Time >= 1700 & type.data$Occurred.Time <= 2359)[[1,2]]
      midnight.freq <- nrow(type.data) - count(type.data1, type.data$Occurred.Time >= 0 & type.data$Occurred.Time < 800)[[1,2]]
      freq.crime <- c(morning.freq, afternoon.freq, night.freq, midnight.freq)
      time.table <- data.frame(time.category, freq.crime)
      return(time.table)
      
    } else {
      morning.freq <- nrow(type.data) - count(type.data, type.data$Occurred.Time >= 800 & type.data$Occurred.Time < 1200)[[1,2]]
      afternoon.freq <- nrow(type.data) - count(type.data, type.data$Occurred.Time >= 1200 & type.data$Occurred.Time < 1700)[[1,2]]
      night.freq <- nrow(type.data) - count(type.data, type.data$Occurred.Time >= 1700 & type.data$Occurred.Time <= 2359)[[1,2]]
      midnight.freq <- nrow(type.data) - count(type.data, type.data$Occurred.Time >= 0 & type.data$Occurred.Time < 800)[[1,2]]
      freq.crime <- c(morning.freq, afternoon.freq, night.freq, midnight.freq)
      time.table <- data.frame(time.category, freq.crime)
      return(time.table)
      
    }
    
    
  })
  
  
  
  output$barPlot_state <- renderPlot({
    time.table <- input_data()
    barplot(time.table$freq.crime, 
            horiz = FALSE,
            main = "Frequency of crimes during certain time of a day",
            las = 1,
            names.arg = c("morning", "afternoon", "night", "midnight"),
            xlab = "Time period of a day",
            ylab = "frequency of crimes",
            col= c("mistyrose1", "mistyrose2", "mistyrose3", "mistyrose4"))
    
  })
  
  
  
}