#by Julia Summers
#Building shiny app

library(shiny)
library(dplyr)
library(ggplot2)

#Preparing files:

getwd()
setwd("~/Desktop/INFO201/ProjectFinal201")

data <- read.csv("data/GlobalLandTemperaturesByCountry.csv", sep = ",", stringsAsFactors = FALSE)

country_average_temperature_plot <- function(country_selected) {
  country_average_temperature <- filter(data, Country == country_selected) %>%
                                 mutate(year = format(as.Date(dt), "%Y"))
  country_average_temperature$year = as.integer(country_average_temperature$year) - (as.integer(country_average_temperature$year) %% 10)
  country_average_temperature <- filter(country_average_temperature, as.integer(year) >= 1850)
  country_average_temperature <- summarise(group_by(country_average_temperature, year), mean(AverageTemperature))
  colnames(country_average_temperature) <- c("year", "AverageTemperature")
  return(as.data.frame(country_average_temperature))
 
temperaturebycountry_plot <- function(country_selected){
  country_data <- country_average_temperature_plot(country_selected)
  plot <- country_data%>%
    ggplot() +
    geom_bar(aes(x = year, y = AverageTemperature), stat = 'identity') + 
    ggtitle (paste ('Average Temperature Flactuations',country_selected))
  return(plot)
}

shinyServer(function(input, output){
  output$bar_plot <- renderPlot({
    country <- input$Country
    country_temperature<-country_average_temperature_plot(country)
    temperaturebycountry_plot(country, country_temperature)
  })
  
}))

#Output$text <- renderText({
  #paste(
    
 # )
  
#})

