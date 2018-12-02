library(shiny)

shinyServer(function(input, output) {
  
  #data from https://data.seattle.gov/Public-Safety/Seattle-Real-Time-Fire-911-Calls/kzjm-xkqj
  data <- read.csv(file = "../data/SEAfire911.csv",sep = ",", stringsAsFactors = FALSE, fill = TRUE)
  
  #Finds each what month each call occured
  data$Datetime = substr(data$Datetime, start = 1, stop = 10)
  month <- month(as.POSIXlt(data$Datetime, format="%m/%d/%Y"))
  data <- mutate(data, Month = month)
  
  #Removes N/A and subtracts outliers
  data <- data[complete.cases(data), ]
  data <- filter(data, Latitude > 47.45, Latitude < 47.75, Longitude < -122.225)
  
  #Counts occurances at each Address
  data <- add_count(data, Address)
  data <- mutate(data, Calls = n)
  
  #Selects needed data
  data <- select(data, Month, Latitude, Longitude, Calls)
  
  #reduces data, so faster to run -- remove latter
  #data <- filter(data, (Month == 1))
   
  output$map <- renderPlot({
    ggplot(data, aes(x=Longitude, y=Latitude)) +
      geom_point(aes(color = Calls)) + coord_map()
  })
  
})
