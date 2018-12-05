##
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# by Julia Summers
#load required packages
library(shiny)


data <- read.csv("data/GlobalLandTemperaturesByCountry.csv", sep = ",", stringsAsFactors = FALSE)


# Define UI for application that draws a histogram
UI <- fluidPage(
  
  # Graph Title
  titlePanel("Climate Change in Major Countries"),
  
  # Sidebar with a slider input for one bin
  sidebarLayout(
    sidebarPanel(
      selectInput('Country',
                  label = 'Country',
                  choices = unique(data$Country))),
  
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("bar_plot")
  #    textOutput ("text")
    )
  )
  )

