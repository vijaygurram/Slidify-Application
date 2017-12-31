---
title       : Chick Weight Application
subtitle    : Developing Data Products - Pitch Application
author      : Vijay Gurram
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Chick Weight Application

This application predicts the weight of chick based on two parameters

- 1. Number of days (between 1 and 21)

- 2. Type of diet (1, 2, 3 or 4)


The working application can be accessed at RStudio site

[Chick Weight Application](https://vijaygurram.shinyapps.io/ChickWeight/)

The code files can be accessed at the Github site

[Git Hub Code Files](https://github.com/)

--- .UIcode

## Shiny UI Code is as below
library(shiny)

shinyUI(fluidPage(

  sidebarLayout(
    sidebarPanel(
       sliderInput("days",
                   "Number of Days:",
                   min = 1,
                   max = 21,
                   value = 10),
       sliderInput("diet",
                   "Type of Diet:",
                   min = 1,
                   max = 4,
                   value = 1)
    ),

    mainPanel(
       plotOutput("ChkWtPlot"),
       h3("Predicted Chick Weight is:"),
       textOutput("ChickWt")

    )
  )
))


--- .Servercode

## Shiney Server Code is as below


library(shiny)
library(caret)
library(lattice)

shinyServer(function(input, output) {
   
  data(ChickWeight)
    
    trainedModel <- lm(weight~Time, data=ChickWeight)

    predictWt <- reactive({
        

        myEntry <- data.frame(Time = input$days, Diet = input$diet)
        prediction <- predict(trainedModel, newdata = myEntry)
        
        return(prediction)
    })
    
  output$ChkWtPlot <- renderPlot({

      plot(ChickWeight$weight, ChickWeight$Time, xlab = "No. of Days", ylab = "Chick Weight", pch = 16, xlim = c(1, 21), ylim = c(10, 400))
      
      abline(trainedModel, col = "blue", lwd = 2)
      
      points(input$days, predictWt(), col = "red", pch = 16, cex = 2)

  })
  
   output$ChickWt <- renderText({
       
       predictWt()
   })

})


--- .Thk

## Thank You





