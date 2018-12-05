library(shiny)

#stateTemp <- read.csv("../GlobalLandTemperaturesByState.csv");

ui <- fluidPage(
  titlePanel("Climate Change in the United States (1850-2010)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("dateSlider",
                  "Enter Decade to Analyze",
                  1850, 2010, 1850,
                  step = 10)
    ),
    mainPanel(
      plotOutput("map")
    )
  )
)