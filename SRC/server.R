# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

# shiny!
library(shiny)

# Server definition
shinyServer(function(input, output) {
  
  # for testing really... does the csv import properly?
  output$userInput = renderTable({
    
    req(input$csvUpload)
    read.csv(file = input$csvUpload$datapath)
    
  })
  
  inputData = reactive({
    read.csv(file = input$csvUpload$datapath)
  })
  
  output$csvNames = renderText({
    tryCatch(
      {
        unlist(inputData()[1, ])
      }, 
      error=function(cond){
        # is this scrappy? :-)
      })
  })
  
})

will.not.be.run = function() {
  # for testing
  
  if (is.null(dim(input.data))) { 0 } else { dim(input.data[[1]]) }
  tdat = as.data.frame(cbind(c(1, 2, 3), c("a", "b", "c")))
  paste0(unlist(tdat[1, ]), collapse = "")
  ?paste0
}