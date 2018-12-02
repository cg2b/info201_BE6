library('ggplot2')
library('ggmap')
library('dplyr')

data <- as.data.frame(read.csv("data/crime.csv", stringsAsFactors = FALSE))
uniqueNeighborhoods <- unique(data$Neighborhood)

fullvector <- c()
for (one in uniqueNeighborhoods) {
    one <- nrow(data %>% filter(Neighborhood == one))
    fullvector <- c(fullvector, one)
}

final <- data.frame("Neighborhood Name" = uniqueNeighborhoods, "Crime Amount" = fullvector)
final <- final[order(-(final$Crime.Amount)),]
final <- slice(final, 1:20)

max(final$Crime.Amount)
min(final$Crime.Amount)

jpeg('days.jpg', height=1000, width=1200, bg="white")
piechart <- pie(final$Crime.Amount, col=c("#ccffb2", "#feff9e", "#aaebf9", "#f5c1ff", "#ffa7dc"),
                labels=final$Neighborhood.Name, main = paste0("Number of Crimes in Different Neighborhoods"))
dev.off()





