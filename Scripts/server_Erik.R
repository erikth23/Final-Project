library(shiny)
library(ggplot2)
library(dplyr)
library(maps)
library(usmap)

stateTemp <- read.csv("data/GlobalLandTemperaturesByState.csv");
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
    scale_fill_gradient(name="Average Temperature (Celsius)",limits=c(-10, 25), low="white", high="blue") + 
    theme(legend.position = "right") +
    ggtitle(paste("Average Temperature United States"), date)
}

generateStateText <- function() {
  paste("The map here shows the average temperature in each state of the United States relative to each other.
        You are able to use the slider to go through each decade and see the change across the timeline. As 
        you can see there is an increase in the average temperature as you go from 1850 to 2010, indicating 
        a change in climate and providing evidence for global warming.  The reason for this increase is most
        likely due to the industrial revolution which started in 1850.  This would've produced green house
        gasses that depleted the o-zone layer and thus providing for solar radiation hitting the earth and 
        an increase in temperature.")
}
