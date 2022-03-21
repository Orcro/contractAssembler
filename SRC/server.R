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
    output$contractFieldsTitle = renderText({
        "<h3>Contract Fields:</h3>"
    })
    output$tempTitle = renderText({
        "Title Field"
    })
    output$widgetsTitle = renderText({
        "<h3>Contract Widgets:</h3>"
    })
    
    
    # a list to hold useful things
    ui.list = list()
    
    
    # the magic is here
    responsive.Field = function(type) {
        switch (type,
                Qbox = textInput(inputId = "theContract", label = "Good"), 
                Title_Text = textOutput(outputId = "tempTitle"), 
                Dynamic_Example = NULL
        )
    }
    
    
    # does the csv import properly? display
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
    
    
    output$contractFields = renderText({
        tryCatch(
            {
                paste0(unlist(inputSchema()[, "Type"]), collapse = ", ")
            }, 
            error = function(cond){
                # is this scrappy? :-)
            })
    })
    
    
    output$theContract = renderUI({
        tryCatch(
            {
                lapply(unlist(inputSchema()[, "Type"]), responsive.Field)
            }, 
            error = function(cond){
                # 
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

