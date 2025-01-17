library("shiny")
library("dplyr")
library("ggplot2")
library("lubridate")
library("mapproj")

df_crime <- read.csv(file = "../data/crime.csv", sep = ",", stringsAsFactors = FALSE)
df_911 <- read.csv(file = "../data/SEAfire911.csv", sep = ",", stringsAsFactors = FALSE)
data <- df_911
crime.data <- df_crime

## chart 3 & 4
# data preparation of 911 dataset
df_911$Datetime <- as.POSIXct(df_911$Datetime, format = "%m/%d/%Y")
df_911$Year <- as.character(year(df_911$Datetime))
df_911$Month <- month(df_911$Datetime)
df_911 %>% select(Incident.Number, Year, Month) -> data_911
rm(df_911)
data_911 %>% 
  group_by(Year) %>%
  summarise(freq = n()) -> data_911_year


# data prep of crime dataset
df_crime$Occurred.Date <- as.Date(df_crime$Occurred.Date, format = "%m/%d/%Y")
df_crime$Year <- as.character(year(df_crime$Occurred.Date))
df_crime$Month <- month(df_crime$Occurred.Date)
df_crime %>% 
  select(Report.Number, Year, Month) %>%
  filter(Year == "2017" | Year == "2018")-> data_crime
rm(df_crime)
data_crime %>% 
  group_by(Year) %>%
  summarise(freq = n())  -> data_crime_year

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
            horiz = TRUE,
            main = "Frequency of crimes during certain time of a day",
            las = 1,
            names.arg = c("morning", "afternoon", "night", "midnight"),
            xlab = "frequency of crimes",
            col= c("mistyrose1", "mistyrose2", "mistyrose3", "mistyrose4"))
    
  })
  
  # fire calls
  output$firecall <- renderPlot({
    # overview of 2017 and 2018
    if(input$firecall == 1){
      ggplot(data_911_year) +
        geom_col(width = 0.85) +
        aes(Year, freq, fill = Year) +
        geom_text(label = data_911_year$freq) +
        ggtitle("Fire Calls Overview of 2017 and 2018") +
        labs(x = "year", y = "reports") +
        scale_fill_manual(
          breaks = data_911_year$Year,
          values = c("indianred3", "sienna2"),
          labels = c("2017", "2018")
        ) +
        theme(panel.background = element_rect(fill = "grey98")) +
        coord_fixed(ratio = 1/40000)
    }
    
    # months in the given year
    else {
      data_911 %>%
        filter(Year == input$firecall) %>%
        group_by(Month) %>% 
        summarise(freq = n()) %>% 
        arrange(Month) -> data_911_month
      data_911_month$Month <- as.factor(data_911_month$Month)
      color_vec <- c("indianred3", "sienna2")
      if(input$firecall == "2017"){
        color <- color_vec[1]
      }
      else{
        color <- color_vec[2]
      }
      ggplot(data_911_month) + 
        geom_col(fill = color, width = 0.85) + 
        aes(x = Month, y = freq, fill = Month) +
        geom_text(label = data_911_month$freq) +
        ggtitle(paste("911 Fire Calls in", input$firecall, "from January to December")) +
        labs(x = "month", y = "reports") +
        theme(panel.background = element_rect(fill = "grey98")) +
        coord_fixed(ratio = 1/1000)
      
    }
  })
  
  # crime
  output$crime <- renderPlot({
    if(input$crime == 1){
      ggplot(data_crime_year) +
        geom_col(width = 0.85) +
        aes(Year, freq, fill = Year) +
        geom_text(label = data_crime_year$freq) +
        ggtitle("Crime Overview of 2017 and 2018") +
        labs(x = "year", y = "reports") +
        scale_fill_manual(
          breaks = data_crime_year$Year,
          values = c("dodgerblue3", "steelblue3"),
          labels = c("2017", "2018")
        ) +
        theme(panel.background = element_rect(fill = "grey98"))+
        coord_fixed(ratio = 1/25000)
    }
    
    # months in the given year
    else {
      data_crime %>%
        filter(Year == input$crime) %>%
        group_by(Month) %>% 
        summarise(freq = n()) %>% 
        arrange(Month) -> data_crime_month
      data_crime_month$Month <- as.factor(data_crime_month$Month)
      color_vec <- c("dodgerblue3", "steelblue3")
      if(input$crime == "2017"){
        color <- color_vec[1]
      }
      else{
        color <- color_vec[2]
      }
      ggplot(data_crime_month) + 
        geom_col(fill = color, width = 0.85) + 
        aes(x = Month, y = freq, fill = Month) +
        geom_text(label = data_crime_month$freq) +
        ggtitle(paste("Crimes in", input$firecall, "from January to December")) +
        labs(x = "month", y = "reports") +
        theme(panel.background = element_rect(fill = "grey98")) +
        coord_fixed(ratio = 1/500)
      
    }
    
    
  })
  
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
      map_colors = c(paste0("light",input$color), input$color, paste0("dark",input$color), "black")
    } else if (input$color == "red"){
      map_colors = c("pink",input$color, input$color, paste0("dark",input$color), "black")
    } else if (input$color == "grey"){
      map_colors = c("white",input$color, input$color, paste0("dark",input$color), "black")
    } else {
      map_colors = c("yellow", "orange", "red", "darkred")
    }
    ggplot(data, aes(x=Longitude, y=Latitude)) +
      geom_point(aes(color = Calls)) + ggtitle("Seattle") +
      scale_color_gradientn(colours = map_colors,
                            values = c(1.0,0.2,0.075,0.01,0)) + coord_map()
  })
  
  output$descrip_map <- renderText({
    paste("just some information about the map and how to", "use it")
  })
  
  
  uniqueNeighborhoods <- unique(crime.data$Neighborhood)
  
  fullvector <- c()
  for (one in uniqueNeighborhoods) {
    one <- nrow(crime.data %>% filter(Neighborhood == one))
    fullvector <- c(fullvector, one)
  } 
  
  final <- data.frame("Neighborhood Name" = uniqueNeighborhoods, "Crime Amount" = fullvector)
  # final <- final %>% filter(final, data$Precinct == input$region)
  final <- final[order(-(final$Crime.Amount)),]
  top20 <- slice(final, 1:20)
  
  final2 <- final[order(final$Crime.Amount),]
  least20 <- slice(final, 1:20)
  
  output$pie <- renderPlot({
    if (input$color == "top20") {
      pie(top20$Crime.Amount, col = c("#ccffb2", "#feff9e", "#aaebf9", "#f5c1ff", "#ffa7dc"),
          labels=final$Neighborhood.Name, main = paste0("Top 20 Crime Neighborhoods"))
    }
    else {
      pie(least20$Crime.Amount, col = c("#fc3232", "#13d604", "#ffe74d", "#ff8c4a", "#2b8fef"),
          labels=final$Neighborhood.Name, main = paste0("Last 20 Crime Neighborhoods"))
    }
  })
}
