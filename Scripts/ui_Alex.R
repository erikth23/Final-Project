# Author: Alex Capi
library(shiny)

global_data <- read.csv('data/GlobalTemperatures.csv', stringsAsFactors = FALSE)

All_Decades <- c("1850-01-01", "1860-01-01", "1870-01-01", "1880-01-01",
  "1890-01-01", "1990-01-01", "1910-01-01", "1920-01-01",
  "1930-01-01", "1940-01-01", "1950-01-01", "1960-01-01",
  "1970-01-01", "1980-01-01", "1990-01-01", "2000-01-01",
  "2010-01-01")

x_values <- c("LandAverageTemperature", "LandAverageTemperatureUncertainty",
              "LandMaxTemperature", "LandMaxTemperatureUncertainty",
              "LandMinTemperature", "LandMinTemperatureUncertainty",
              "LandAndOceanAverageTemperature",	"LandAndOceanAverageTemperatureUncertainty")

shinyUI(fluidPage(
  
  titlePanel("Climate Change around the Globe"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('select',
                  label = 'Select Year',
                  choices = All_Decades)
    ),
    mainPanel(
      plotOutput('visualization'),
      textOutput('summary')
    )
  )
))