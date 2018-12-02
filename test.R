library(dplyr)
library(ggplot2)
library(mapproj)
library(lubridate)

#data from https://data.seattle.gov/Public-Safety/Seattle-Real-Time-Fire-911-Calls/kzjm-xkqj
data <- read.csv(file = "data/SEAfire911.csv",sep = ",", stringsAsFactors = FALSE, fill = TRUE)

#Finds each what month each call occured
data$Datetime = substr(data$Datetime, start = 1, stop = 10)
month <- month(as.POSIXlt(data$Datetime, format="%m/%d/%Y"))
data <- mutate(data, Month = month)

#Selects needed data
data <- select(data, Address, Month, Latitude, Longitude)

#picks the month 
#data <- filter(data, (Month == 1|Month == 2|Month == 3))

#Removes N/A
data <- data[complete.cases(data), ]

data <- add_count(data, Address)
  
jpeg("map.jpg")

map <- ggplot() + geom_point(data = data, aes(x = Longitude, y = Latitude), color = data$n) + 
  ggtitle("Map")
ggsave("map.jpg")
dev.off()