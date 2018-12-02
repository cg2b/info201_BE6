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

#reduces data, so faster to run -- remove latter
#data <- filter(data, (Month == 1))

#Removes N/A and subtracts outliers
data <- data[complete.cases(data), ]
data <- filter(data, Latitude > 47.45, Latitude < 47.75, Longitude < -122.225)

data <- add_count(data, Address)
  
jpeg("map.jpg")

map <- ggplot(data, aes(x=Longitude, y=Latitude)) +
  geom_point(aes(color = n))
  #scale_color_gradient2(midpoint = 5, low = "darkblue", mid = "lightblue", high = "white")
ggsave("map.jpg")
dev.off()