library("shiny")
library("dplyr")
library('ggplot2')
library('dplyr')

server <- function(input, output) {
      data <- as.data.frame(read.csv("data/crime.csv", stringsAsFactors = FALSE))
      uniqueNeighborhoods <- unique(data$Neighborhood)
      
      fullvector <- c()
      for (one in uniqueNeighborhoods) {
        one <- nrow(data %>% filter(Neighborhood == one))
        fullvector <- c(fullvector, one)
      } 
      
      final <- data.frame("Neighborhood Name" = uniqueNeighborhoods, "Crime Amount" = fullvector)
      # final <- final %>% filter(final, data$Precinct == input$region)
      final <- final[order(-(final$Crime.Amount)),]
      top20 <- slice(final, 1:20)
      
      final2 <- final[order(final$Crime.Amount),]
      least20 <- slice(final1, 1:20)
      
      # # Get Maximum Crime Report
      # max <- head(final, 1)
      # print(paste0(max$Neighborhood.Name, " has the most crimes of all Seattle Neighborhoods
      #              with a total of ", max$Crime.Amount, " reported crimes in the time period."))
      # 
      # # Get Minimum Crime Report
      # min <- tail(final, 1)
      # print(paste0(min$Neighborhood.Name, " has the least crimes of all Seattle Neighborhoods
      #              with a total of ", min$Crime.Amount, " reported crimes in the time period."))
      
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