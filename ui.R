library(shiny)

my.ui <- navbarPage(
  "Global Climate Change",
  
  tabPanel("Home",
           sidebarLayout(
             sidebarPanel(),
             mainPanel(
               textOutput("home")
             )
           )),
  tabPanel("Major Cities",
           sidebarLayout(
             sidebarPanel(
               selectInput("city",
                           label = "City",
                           selected = "Los Angeles", # default city
                           choices = unique(global_cities$City)
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
               selectInput('country',
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
             plotOutput("state_plot")
           )
  )
)