library("shiny")
library("dplyr")
library('ggplot2')
library('dplyr')
library('ggrepel')

server <- function(input, output) {
      # Create dataframe from main dataset
      data <- as.data.frame(read.csv("data/crime.csv", stringsAsFactors = FALSE))
      uniqueNeighborhoods <- unique(data$Neighborhood)
      
      # Get crime amount for each neighborhood in a vector
      fullvector <- c()
      for (one in uniqueNeighborhoods) {
        one <- nrow(data %>% filter(Neighborhood == one))
        fullvector <- c(fullvector, one)
      } 
      
      # Top 10 and Last 10 Crime Neighborhoods
      final <- data.frame("Neighborhood Name" = uniqueNeighborhoods, "Crime Amount" = fullvector)
      final <- final[order(-(final$Crime.Amount)),]
      top10 <- slice(final, 1:10)
      final2 <- final[order(final$Crime.Amount),]
      least10 <- slice(final2, 1:10)
      
      output$pie <- renderPlot({
      if (input$color == "top10") {
        pie(top10$Crime.Amount, col = c("#ccffb2", "#feff9e", "#aaebf9", "#f5c1ff", "#ffa7dc"),
        labels=top10$Neighborhood.Name, main = paste0("Top 10 Crime Neighborhoods"))
      }
      else {
        pie(least10$Crime.Amount, col = c("#fc3232", "#13d604", "#ffe74d", "#ff8c4a", "#2b8fef"),
        labels=least10$Neighborhood.Name, main = paste0("Last 10 Crime Neighborhoods"))
      }
      })
}

# # Get Maximum Crime Report
# max <- head(final, 1)
# print(paste0(max$Neighborhood.Name, " has the most crimes of all Seattle Neighborhoods with a total of ", max$Crime.Amount, " reported crimes in the time period."))
#   # "DOWNTOWN COMMERCIAL has the most crimes of all Seattle Neighborhoods with a total of 13715 reported crimes in the time period."
# # Get Minimum Crime Report
# min <- tail(final, 1)
# print(paste0(min$Neighborhood.Name, " has the least crimes of all Seattle Neighborhoods with a total of ", min$Crime.Amount, " reported crimes in the time period."))
#   # "COMMERCIAL HARBOR ISLAND has the least crimes of all Seattle Neighborhoods with a total of 64 reported crimes in the time period."

