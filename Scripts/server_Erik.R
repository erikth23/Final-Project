library(shiny)
library(ggplot2)
library(dplyr)
library(maps)
library(usmap)

stateTemp <- read.csv("GlobalLandTemperaturesByState.csv");
stateTemp <- stateTemp %>% 
  filter(Country == "United States", State != "HI", State != "AK", as.POSIXct(dt) > as.POSIXct("1850-1-1")) %>%
  mutate(year = format(as.Date(dt), "%Y"))
stateTemp$year = as.integer(stateTemp$year) - (as.integer(stateTemp$year) %% 10)

getStateTemp <- function(date) {
  stateTemp <- stateTemp %>%
    filter(year == date)
  stateTemp <- summarise(group_by(stateTemp, State), mean(AverageTemperature))
  colnames(stateTemp) <- c("state", "AverageTemperature")
  plot_usmap(data = stateTemp, values = "AverageTemperature", lines = "red") +
    scale_fill_gradient(limits=c(-10, 25), low="white", high="blue") + 
    theme(legend.position = "right")
}
