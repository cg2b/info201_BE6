library("ggplot2")
library("shiny")
library("dplyr")
library("lubridate")

# read data
df_crime <- read.csv(file = "../data/crime.csv", sep = ",", stringsAsFactors = FALSE)
df_911 <- read.csv(file = "../data/SEAfire911.csv", sep = ",", stringsAsFactors = FALSE)

# data preparation of 911 dataset
df_911$Datetime <- as.POSIXct(df_911$Datetime, format = "%m/%d/%Y")
df_911$Year <- as.character(year(df_911$Datetime))
df_911$Month <- month(df_911$Datetime)
df_911 %>% select(Incident.Number, Year, Month) -> data_911
rm(df_911)
data_911 %>% 
  group_by(Year) %>%
  summarise(freq = n()) -> data_911_year


# data preparation of crime dataset
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


shinyServer(function(input, output) {
   
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
  
})
