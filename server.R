# Load packages required
library(shiny)
library(ggplot2)
library(dplyr)

setwd("~/Desktop/INFO_201/Final-Project")
source("scripts/server_Raphael.R")
source("scripts/server_Erik.R")
source("scripts/server_Julia.R")

shinyServer(function(input, output) {
  output$major_city_plot <- renderPlot({
    generate_scatter_plot(input$city)
  })
  
  output$home <-renderText({
    paste("Welcome")
  })
  
  output$city_text <- renderText({
    generateCityText()
  })
  
  output$country_plot <- renderPlot({
    temperaturebycountry_plot(input$country)
  })
  
  output$state_plot <- renderPlot({
    getStateTemp(input$date)
  })
  
  output$country_text <- renderText({
    generateCountryText()
  })
})