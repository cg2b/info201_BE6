library('ggplot2')
library('ggmap')
library('dplyr')

data <- as.data.frame(read.csv("data/crime.csv", stringsAsFactors = FALSE))
uniqueNeighborhoods <- unique(data$Neighborhood)
uniquep <- unique(data$Precinct)

fullvector <- c()
get <- function(region) {
  for (one in uniqueNeighborhoods) {
      one <- nrow(data %>% filter(Neighborhood == one, Precinct == region))
      fullvector <- c(fullvector, one)
  }
  
  final <- data.frame("Neighborhood Name" = uniqueNeighborhoods, "Crime Amount" = fullvector)
  final <- final[order(-(final$Crime.Amount)),]
  top20 <- slice(final, 1:20)
  
  max <- head(final, 1)
  print(paste0(max$Neighborhood.Name, " has the most crimes of all Seattle Neighborhoods with a total of ", max$Crime.Amount, " reported crimes in the time period."))
  
  min <- tail(final, 1)
  print(paste0(min$Neighborhood.Name, " has the least crimes of all Seattle Neighborhoods with a total of ", min$Crime.Amount, " reported crimes in the time period."))
  
  jpeg('dayss.jpg', height=1000, width=1200, bg="white")
  piechart <- pie(top20$Crime.Amount, col=c("#ccffb2", "#feff9e", "#aaebf9", "#f5c1ff", "#ffa7dc"),
                  labels=final$Neighborhood.Name, main = paste0("Number of Crimes in Different Neighborhoods"))
  dev.off()
}





