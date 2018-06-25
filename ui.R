library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Twitter Sentiment Analysis"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderInput1",label = "No. Of Tweets",min = 2,max = 1000,value = 50,round = TRUE, post = " tweets"),
      textInput("txtKeyword",label = "Enter Keyword (using #)",placeholder = "e.g.Rutgers",value = "#Rutgers")
      # "Sidebar Panel"
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Welcome To Twitter Sentiment Analysis App",style="color:blue;"),
      br(),
      p("Use Slide Bar to select number of tweets"),
      p("Enter keyword to display relevant tweets"),
      plotOutput("distPlot"))
    
    # "Main Panel"
  )
))

