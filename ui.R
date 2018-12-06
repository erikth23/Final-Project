library(shiny)

source("./Scripts/server_Erik.R")
source("./Scripts/server_Julia.R")
source("./Scripts/server_Raphael.R")
source("./Scripts/server_Alex.R")

my.ui <- navbarPage(
  "Global Climate Change",
  
  tabPanel("Home",
           tags$div(
             class = 'content-container',
             h1("Global Warming: The Raw Truth!"),
             p("Since Global Warming was refuted and denied by current administration, and it was announced that the United States is pulling out of the Paris Climate Accord, we decided to go back to the facts. While it is difficult to fully describe this phenomenon and carry out its importance, we thought data will have the power to speak for itself if represented right. Thus, our project presents the evidence of rising temperatures in many different ways so that the viewer has the chance to analyze and come to their own conclusion on how real Global Warming is.
               Initially, we wanted to plot the average temperatures data by different administrative units beginning with Industrial revolution, which was around 1850 and to present days. We then realized the data shows much more than just rising temperatures. We decided to analyze and present data in a few approaches. Plotting average temperatures of major cities around the world, countries around the world, data on each state in the United States, and globally."),
             h2("What you could think about when looking at this data:"),
             p("Check many different cities, different countries during different periods of times globally and see what you notice:
               Think of why some countries have more drastic temperature effects than others on average?
               We specifically plotted data using different histograms and maps so that the variety of visuals give a more complete picture of Global Warming.
               Each tab addressed average temperatures in different way.")
             )),
  tabPanel("Major Cities",
           sidebarLayout(
             sidebarPanel(
               selectInput("city",
                           label = "City",
                           selected = "Los Angeles", # default city
                           choices = unique(global_city$City)
               )
             ),
             mainPanel(
               plotOutput("major_city_plot"),
               textOutput("city_text")
             )
           )
  ),
  tabPanel("Countries",
           sidebarLayout(
             sidebarPanel(
               selectInput("country",
                           label = 'Country',
                           choices = unique(data$Country)
               )
             ),
             mainPanel(
               plotOutput("country_plot"),
               textOutput("country_text")
             )
           )
  ),
  tabPanel("United States",
           sidebarPanel(
             sliderInput("date",
                         "Enter Decade to Analyze",
                         1850, 2010, 1850,
                         step = 10)
           ),
           mainPanel(
             plotOutput("state_plot"),
             textOutput("state_text")
           )
  ),
  tabPanel("Global",
           sidebarLayout(
             sidebarPanel(
               selectInput('global',
                           label = 'Select Year',
                           choices = All_Decades)
             ),
             mainPanel(
               plotOutput("global_plot"),
               textOutput("global_text")
             )
           )
  )
)