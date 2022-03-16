# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

# shiny!
library(shiny)

# Server definition
shinyServer(function(input, output) {

  data <- reactive({
    req(input$csv)
    read.csv(input$csv$datapath)
  })
  
  output$distPlot = renderPlot({

    # generate bins based on input$bins from ui.R
    x    = faithful[, 2]
    bins = seq(from       = min(x), 
               to         = max(x), 
               length.out = (input$bins + 1))

    # draw the histogram with the specified number of bins
    hist(x      = x, 
         breaks = bins, 
         col    = 'darkgray', 
         border = 'white')

  })

})
