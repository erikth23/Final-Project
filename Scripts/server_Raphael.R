# Author: Raphael Manansala

# Load packages required
library(shiny)
library(ggplot2)
library(dplyr)

# Load Global Temeprature By Major Cities data 
global_cities <- read.csv(file = "data/GlobalLandTemperaturesByMajorCity.csv", sep = ",", stringsAsFactors = FALSE)

# Create a point plot function 
generate_scatter_plot <- function(city_selected) {
  # Filter major cities data based on user-selected city
  major_cities <- filter(global_cities, City == city_selected) 
  # Filter by decade
  major_cities <- filter(major_cities, dt %in% c("1850-01-01", "1860-01-01", "1870-01-01", "1880-01-01",
                                                 "1890-01-01", "1990-01-01", "1910-01-01", "1920-01-01",
                                                 "1930-01-01", "1940-01-01", "1950-01-01", "1960-01-01",
                                                 "1970-01-01", "1980-01-01", "1990-01-01", "2000-01-01",
                                                 "2010-01-01")
                         )
  
  # Generate a scatter plot of the average temperature of a city by decade
  city_graph <- ggplot(major_cities, aes(x = dt, y = AverageTemperature)) +
    geom_point() +
    ggtitle("Average Temperature By Decade Since 1850") # graph title 
  city_graph + labs(x = "Decades", y = "Temperature in Celcius") # graph labels 
  

}

generateCityText <- function(){
  paste("My graph shows the average temperature of every decade based on January 1st. 
          As you can see on any major city, there has been a trend of worsening average land temperatures.
        In other words, cold places get colder, warm places get warmer, which causes unusually harsher seasons and climate.
        On a global spectrum, this is not normal.
        For example, Los Angeles hit an all-time low average temperature on January 1, 1950 of 6.5 degrees Celsius, but this has increased 
        since cars became a commodity and the end of the Great Depression in the US. As of January 1, 2010, the average temperature of Los Angeles is 10 degrees Celsius.
        Los Angeles is supposed to have a cool winter, but since it's naturally warmer, it has gotten warmer due to climate change, thus a warmer winter. 
        On the other hand, Chicago and New York usually have cold winters, and they have been getting colder winters since the 1950 as well.")
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Generate a bar plot based on the city selected by the user
  output$scatterPlot <- renderPlot({
    generate_scatter_plot(input$city)
  })
  
  # Generate the summary paragraph 
  output$summary <- renderText({
    paste("My graph shows the average temperature of every decade based on January 1st. 
          As you can see on any major city, there has been a trend of worsening average land temperatures.
          In other words, cold places get colder, warm places get warmer, which causes unusually harsher seasons and climate.
          On a global spectrum, this is not normal.
          For example, Los Angeles hit an all-time low average temperature on January 1, 1950 of 6.5 degrees Celsius, but this has increased 
          since cars became a commodity and the end of the Great Depression in the US. As of January 1, 2010, the average temperature of Los Angeles is 10 degrees Celsius.
          Los Angeles is supposed to have a cool winter, but since it's naturally warmer, it has gotten warmer due to climate change, thus a warmer winter. 
          On the other hand, Chicago and New York usually have cold winters, and they have been getting colder winters since the 1950 as well.")
    
  })
  
})
