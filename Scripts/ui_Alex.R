# Author: Alex Capi
library(shiny)
library(rsconnect)

global_data <- read.csv('data/GlobalTemperatures.csv', stringsAsFactors = FALSE)
df <- as.data.frame(global_data, stringsAsFactors = FALSE)

shinyUI(fluidPage(
  
  titlePanel("Climate Change around the Globe"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('select',
                  label = 'Select Year',
                  choices = unique(filter_by_decade$dt))
    ),
    mainPanel(
      plotOutput('visualization'),
      textOutput('summary')
    )
  )
))