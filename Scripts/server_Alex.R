# Author: Alex Capi
library(shiny)
library(dplyr)
#library(lubridate)
library(ggplot2)
library(rsconnect)

global_data <- read.csv('data/GlobalTemperatures.csv', stringsAsFactors = FALSE)
df <- as.data.frame(global_data, stringsAsFactors = FALSE)

global_temp_plot <- function(year_of_interest) {

  filter_by_decade <- filter(global_data, dt == year_of_interest)
  # Filter by decade
  filter_by_decade <- filter(filter_by_decade, dt %in% c("1850-01-01", "1860-01-01", "1870-01-01", "1880-01-01",
                                                 "1890-01-01", "1990-01-01", "1910-01-01", "1920-01-01",
                                                 "1930-01-01", "1940-01-01", "1950-01-01", "1960-01-01",
                                                 "1970-01-01", "1980-01-01", "1990-01-01", "2000-01-01",
                                                 "2010-01-01"))
  
  decade_graph <- ggplot(filter_by_decade, aes(x = dt, y = LandAverageTemperature)) + 
    geom_point() +
    ggtitle("Global Average Temperatures Since 1850")
  decade_graph + labs(x = "Decades", y = "Temperature in Celcius")
}

generateGlobalText <- function(){
  paste("blah blah blah")
}

shinyServer(function(input, output) {
  
  output$visualization <- renderPlot({
    global_temp_plot(input$select)
  })
  output$summary <- renderText({
    paste("blah blah blah")
  })
})

