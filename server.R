# Load packages required
library(shiny)
library(ggplot2)
library(dplyr)


source("./Scripts/server_Erik.R")
source("./Scripts/server_Julia.R")
source("./Scripts/server_Raphael.R")
source("./Scripts/server_Alex.R")

shinyServer(function(input, output) {
  output$city_text <- renderText({
    generateCityText()
  })
  
  output$country_plot <- renderPlot({
    temperaturebycountry_plot(input$country)
  })
  
  output$major_city_plot <- renderPlot({
    generate_scatter_plot(input$city)
  })
  
  output$state_plot <- renderPlot({
    getStateTemp(input$date)
  })
  
  output$country_text <- renderText({
    generateCountryText()
  })
  
  output$state_text <- renderText({
    generateStateText()
  })
  
  output$global_plot <- renderPlot({
    global_temp_plot(input$global)
  })
  
  output$global_text <- renderText({
    generateGlobalText()
  })
})