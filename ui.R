# Author: Raphael Manansala

# Load packages required
library(shiny)

# Load Global Temeprature By Cities data 
global_cities <- read.csv(file = "GlobalLandTemperaturesByMajorCity.csv", sep = ",", stringsAsFactors = FALSE) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Climate Change In Major Cities"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      # This textbox will let users input cities that they want by name
      selectInput("city",
                label = "City",
                selected = "Los Angeles", # default city
                choices = unique(global_cities$City)
                )
      
    ),

    
    # Show a plot of the generated distribution
    mainPanel(
      # This is the UI for the scatter plot
      plotOutput("scatterPlot"),
      # This is the UI for the summary text
      textOutput("summary")
       
    )
  )
))
