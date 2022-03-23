# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

# shiny!
library(shiny)

# Server definition
shinyServer(function(input, output) {
  
  
  # hard-coded text on page:
  output$csvTitle = renderText({
    "<h3>Input Schema:</h3>"
  })
  # testing only, remove?
  #output$contractFieldsTitle = renderText({
  #    "<h3>Contract Fields:</h3>"
  #})
  output$tempTitle = renderText({
    "Title Field"
  })
  output$widgetsTitle = renderText({
    "<h3>Contract Widgets:</h3>"
  })
  output$outputTitle = renderText({
    "<h3>Contract Output:</h3>"
  })
  
  
  # a list to hold useful things
  ui.list = list()
  
  
  # the magic is here
  responsive.Widget = function(type, display) {
    
    #id = as.character(id)
    #output$id = renderText({ display })
    
    switch (type,
            qbox = textInput(inputId = "theForm", label = display), 
            title_text = NULL,
            c_text = NULL
    )
  }
  
  
  contract.Text = function(type, display) {
    
    #id = as.character(id)
    #output$id = renderText({ display })
    
    switch (type,
            qbox = NULL, 
            title_text = NULL,
            c_text = display
    )
  }
  
  
  # display the imported schema
  output$userInput = renderTable({
    req(input$csvUpload)
    read.csv(file = input$csvUpload$datapath)
  })
  
  
  # user uploaded schema
  inputSchema = reactive({
    read.csv(file = input$csvUpload$datapath)
  })
  
  # the fields on the contract
  #contract.Fields = reactive({
  #    unlist(inputSchema()[, "Type"])
  #})
  
  
  ## testing only, remove?
  #output$contractFields = renderText({
  #    tryCatch(
  #        {
  #            paste0(unlist(inputSchema()[, "Type"]), collapse = ", ")
  #        }, 
  #        error = function(cond){
  #            # is this scrappy? :-)
  #        })
  #})
  
  
  output$theForm = renderUI({
    tryCatch(
      {
        #c.index = 1:length(unlist(inputSchema()))
        
        mapply(responsive.Widget, 
        #       c.index,
               unlist(inputSchema()[, "Type"]),
               unlist(inputSchema()[, "Display"]))
      }, 
      error = function(cond){
        # 
      })
  })
  
  
  output$theContract = renderText({
    req(input$csvUpload)
    paste0(unlist(mapply(contract.Text, 
           unlist(inputSchema()[, "Type"]), 
           unlist(inputSchema()[, "Display"]))), 
           collapse = "</br>")
  })
  
  
})


will.not.be.run = function() {
  # for testing
  
  if (is.null(dim(input.data))) { 0 } else { dim(input.data[[1]]) }
  tdat = as.data.frame(cbind(c(1, 2, 3), c("a", "b", "c")))
  paste0(unlist(tdat[1, ]), collapse = "")
  ?paste0
}





