#by Julia Summers
#Building shiny app

library(shiny)
library(dplyr)
library(ggplot2)

#Preparing files:

getwd()
setwd("~/Desktop/INFO201/ProjectFinal201")

data <- read.csv("data/GlobalLandTemperaturesByCountry.csv", sep = ",", stringsAsFactors = FALSE)
#cities <- c("New York",  )
#date <- filter(data, Country $in$ cities)

country_average_temperature_plot <- function(country_selected) {
  country_average_temperature <- filter(data, Country == country_selected) %>%
                                 mutate(year = format(as.Date(dt), "%Y"))
  country_average_temperature$year = as.integer(country_average_temperature$year) - (as.integer(country_average_temperature$year) %% 10)
  country_average_temperature <- filter(country_average_temperature, as.integer(year) >= 1850)
  country_average_temperature <- summarise(group_by(country_average_temperature, year), mean(AverageTemperature))
  colnames(country_average_temperature) <- c("year", "AverageTemperature")
  return(as.data.frame(country_average_temperature))
  #country_average_temperature <- filter(country_average_temperature, dt %in% c("1850-06-01", "1860-06-01", "1870-06-01", "1880-06-01",
   #                                                                            "1890-06-01", "1990-06-01", "1910-06-01", "1920-06-01",
  #                                                                             "1930-06-01", "1940-06-01", "1950-06-01", "1960-06-01",
  #                                                                             "1970-06-01", "1980-06-01", "1990-06-01", "2000-06-01",
  #                                                                             "2010-06-01"))
  #
  }
  

temperaturebycountry_plot <- function(country_selected, tempData){
  plot <- tempData%>%
    #ggplot(aes_string(x = dt, y = Country, fill= AverageTemperature)) +
    ggplot() +
    geom_bar(aes(x = year, y = AverageTemperature), stat = 'identity') + 
    ggtitle (paste ('Average Temperature Flactuations',Country))
  return(plot)
}

shinyServer(function(input, output){
  output$bar_plot <- renderPlot({
    country <- input$Country
    country_temperature<-country_average_temperature_plot(country)
    temperaturebycountry_plot(country, country_temperature)
  })
  
})
#Output$text <- renderText({
  #paste(
    
 # )
  
#})

