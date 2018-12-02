library(shiny)

shinyServer(function(input, output) {
  
  # Reads data from https://data.seattle.gov/Public-Safety/Seattle-Real-Time-Fire-911-Calls/kzjm-xkqj
  data <- read.csv(file = "../data/SEAfire911.csv",sep = ",", stringsAsFactors = FALSE)
  
  pick_data <- reactive({
    #Finds year
    data$Datetime = substr(data$Datetime, start = 1, stop = 10)
    year <- year(as.POSIXlt(data$Datetime, format="%m/%d/%Y"))
    
    #Maniplutes the data to a more condensed, efficent form
    data <- data %>%
      mutate(Year = year) %>%
      #Includes only selected year
      filter(Year == input$year) %>%
      add_count(Address) %>%
      mutate(Calls = n) %>%
      select(Year, Latitude, Longitude, Calls) %>%
      filter(Latitude > 47.45, Latitude < 47.75, Longitude < -122.225)
    
    #Removes incomplete data
    data[complete.cases(data), ]
  }) 
  
  output$map <- renderPlot({
    data = pick_data()
    
  if (input$color == "blue"|input$color == "green") {
    colors = c(paste0("light",input$color), input$color, paste0("dark",input$color), "black")
  } else if (input$color == "red"){
    colors = c("pink",input$color, input$color, paste0("dark",input$color), "black")
  } else if (input$color == "grey"){
    colors = c("white",input$color, input$color, paste0("dark",input$color), "black")
  } else {
    colors = c("yellow", "orange", "red", "darkred")
  }
    ggplot(data, aes(x=Longitude, y=Latitude)) +
      geom_point(aes(color = Calls)) + ggtitle("Seattle") +
      scale_color_gradientn(colours = colors,
                            values = c(1.0,0.2,0.075,0.01,0)) + coord_map()
  })
  
})
