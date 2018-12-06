# Author: Alex Capi
library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
library(rsconnect)

global_data <- read.csv('data/GlobalTemperatures.csv', stringsAsFactors = FALSE)


All_Decades <- c("1850-01-01", "1860-01-01", "1870-01-01", "1880-01-01",
                 "1890-01-01", "1990-01-01", "1910-01-01", "1920-01-01",
                 "1930-01-01", "1940-01-01", "1950-01-01", "1960-01-01",
                 "1970-01-01", "1980-01-01", "1990-01-01", "2000-01-01",
                 "2010-01-01")

global_temp_month <- function(start_date) {
  filter_by_decade <- global_data %>% filter(dt == start_date)
  filtered_long <- melt(filter_by_decade, id="dt")
  return(filtered_long)
}

global_temp_plot <- function(start_date) {
  # Filter by decade
  x_values <- c("LandAverageTemperature", "LandAverageTemperatureUncertainty",
                "LandMaxTemperature", "LandMaxTemperatureUncertainty",
                "LandMinTemperature", "LandMinTemperatureUncertainty",
                "LandAndOceanAverageTemperature",	"LandAndOceanAverageTemperatureUncertainty")
  filtered <- global_temp_month(start_date)

  ggplot(filtered, aes(x=variable, y=value)) + 
     ylab("Celsius") +
     xlab("Measurements") +
     geom_bar(stat="identity") +
     ggtitle("Global Temperatures")
}

generateGlobalText <- function(){
  paste("My graph displays changes in global temperatures and uncertainties of every decade based on January 1st. 
        Throughout the globe, there has been a terrible trend in average land temperatures.
        In other words, cold places get colder, warm places get warmer, which causes unusually harsher seasons and climate.
        Our data suggests that the land average temperature on January 1, 1850 was about 0.8 degrees Celsius, but this has increased significantly
        since then. On January 1, 2010, the land average temperature of is 3.7 degrees Celsius.
        Thus, historical ocean temperatures have increased the sea level around the globe.")
}

shinyServer(function(input, output) {
  
  output$visualization <- renderPlot({
    #date <- input$dt
    #global_average_temperature <- global_temp_plot(dt)
    global_temp_plot(input$select)
  })
  output$summary <- renderText({
    generateGlobalText()
  })
})

