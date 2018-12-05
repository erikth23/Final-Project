#by Julia Summers
#Building shiny app

library(shiny)
library(dplyr)
library(ggplot2)

#Preparing files:

data <- read.csv("data/GlobalLandTemperaturesByCountry.csv", sep = ",", stringsAsFactors = FALSE)

country_average_temperature_plot <- function(country_selected) {
  country_average_temperature <- filter(data, Country == country_selected) %>%
                                 mutate(year = format(as.Date(dt), "%Y"))
  country_average_temperature$year = as.integer(country_average_temperature$year) - (as.integer(country_average_temperature$year) %% 10)
  country_average_temperature <- filter(country_average_temperature, as.integer(year) >= 1850)
  country_average_temperature <- summarise(group_by(country_average_temperature, year), mean(AverageTemperature))
  colnames(country_average_temperature) <- c("year", "AverageTemperature")
  return(as.data.frame(country_average_temperature))
}
 
temperaturebycountry_plot <- function(country_selected){
  country_data <- country_average_temperature_plot(country_selected)
  plot <- country_data%>%
    ggplot() +
    geom_bar(aes(x = year, y = AverageTemperature), stat = 'identity') + 
    ggtitle (paste ('Average Temperatures in',country_selected))
  return(plot)
}

shinyServer(function(input, output){
  output$bar_plot <- renderPlot({
    country <- input$Country
    country_temperature<-country_average_temperature_plot(country)
    temperaturebycountry_plot(country, country_temperature)
  })
  
})

Output$text <- renderText({
  paste("This graph is showing average temperatures of each decade in countries around the world in the period of 1850-2010. 
        Based on the plotted data, it is clear that begining with Industrial revolution temperatures in all countries have become higher, 
        with considerable increase in the past decade in only certain countries. This could also point to other atributes that contribute to such 
        a difference in temperatures and questions as to why some countries experience global warming more than others.
        The bar graph of each country is unique, and its data can tell a story beyong climate change. "
    
 )
  
})

