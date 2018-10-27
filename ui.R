library(shiny)

shinyUI(fluidPage(
  titlePanel("Gaussian data"),
  sidebarLayout(
    sidebarPanel(
      fluidRow("The rnorm function in R generates random numbers from a normal distribution. This app provides a graphical front end to that function."),
      fluidRow("Drawing a box in the graph space on the right will generate two series of normally distributed random numbers and plot them as x and y coordinates."),
      fluidRow("The means are the centre of the box and the standard deviations are set such that the bounds of the box are at 2 standard deviations from the mean."),
      hr(),
      sliderInput(
        min = 1, max = 1000, value = 100,
        "samples", "Number of samples:"
      ),
      checkboxInput("contours", "Show data contours"),
      downloadButton("downloadData", "Download"),
      hr(),
      fluidRow("Drag the slider to change the number of random numbers generated."),
      fluidRow("The 'download' button allows you to export the two sets of data to a CSV file.")
    ),
    mainPanel(
      plotOutput("normPlot", brush = "plotBrush")
    )
  )
))
