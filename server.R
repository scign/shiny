#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data <- reactive({
    x.lo <- -1; x.hi <- 1
    y.lo <- -1; y.hi <- 1
    if (!is.null(input$plotBrush)) {
      x.lo <- input$plotBrush$xmin
      x.hi <- input$plotBrush$xmax
      y.lo <- input$plotBrush$ymin
      y.hi <- input$plotBrush$ymax
    }
    xmu <- (x.lo + x.hi) / 2
    ymu <- (y.lo + y.hi) / 2
    xsd <- (x.hi - x.lo) / 4
    ysd <- (y.hi - y.lo) / 4
    data.frame(
      x = rnorm(input$samples, xmu, xsd),
      y = rnorm(input$samples, ymu, ysd)
    )
  })
  
  output$normPlot <- renderPlot({
    g <- ggplot(data(), aes(x=x,y=y)) +
      geom_point() +
      coord_cartesian(xlim = c(-3, 3), ylim = c(-3, 3))
    if(input$contours) {
      g <- g + geom_density2d()
    }
    g
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste0("gaussian", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(data(), file, row.names = FALSE)
    },
    contentType = "text/csv"
  )

})
