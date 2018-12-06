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
    geom_bar(aes(x = year, y = AverageTemperature), fill = "blue", stat = 'identity') + 
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

generateCountryText <- function(){
  paste("This graph is showing average temperatures of each decade in countries around the world in the period of 1850-2010. 
         Based on the plotted data, it is clear that begining with Industrial revolution temperatures in all countries have started rising, 
        with considerable increase in the past decade in certain countries. For example, in Canada, the average temperatures have risen 
        2.5 degrees since 1850, where 1 degree increase happened in the last decade alone. Such trend is seen in many countries and is worth exploring further.
        However, Japan, for instance had lesser of an increase in average temperatures in the past decade than many other developed nations.
        Same pertains to South Korea.It appears also that some countries experience global warming more than others. Additionally, the bar graph of each country 
        is unique, and its data can tell a story beyong climate change.")
  
}

