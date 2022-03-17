# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

# shiny!
library(shiny)

# Server definition
shinyServer(function(input, output) {
  
  output$csvContents = renderTable({
    file = input$csvUpload
    file.ext = tools::file_ext(file$datapath)
    
    req(file)
    
    # this needs to be specific to schema, just verifies csv for now
    validate(need(file.ext == "csv", "CSV file required."))
    
    read.csv(file$datapath)
  })

#  data <- reactive({
#    uploadedFile = input$csvUpload
#    
#    if (is.null(uploadedFile))
#      return(NULL)
#    
#    tbl = read.csv(uploadedFile$datapath)
#    return(tbl)
#  })
  
})
