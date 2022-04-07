
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


# server.R


# Server definition.
# To aid maintenance, code is written in this order:
# - Hard-coded values, followed by
# - Reactive value, followed by
# - Logic functions
# - Render functions
shinyServer(function(input, output) {
    
    
    # 
    # Hard-coded values #############################
    # 
    
    # Default filename for download
    download.filename = "export_contract.txt"
    
    output$csvTitle = renderText({
        "<h3>Input Schema:</h3>"
    })
    
    output$widgetsTitle = renderText({
        "<h3>Contract Widgets:</h3>"
    })
    
    output$outputTitle = renderText({
        "<h3>Contract Output:</h3>"
    })
    
    output$blankSpace = renderText({
        "<h3>  </h3>"
    })
    
    
    # 
    # Reactive values ###############################
    # 
    
     
    # Import user uploaded file (csvUpload is ID of input button).
    inputSchema = reactive({
        read.csv(file = input$csvUpload$datapath)
    })
    
    # Get list of input values from Shiny, for the dynamic form.
    list_of_inputs = reactive({ 
        reactiveValuesToList(input)
    })
    
    # Get list of field names from the uploaded schema.
    list_of_fields = reactive({ 
        req(input$csvUpload)
        inputSchema()[, "Field_Name"]
    })
    
    # Text output for preview before downloading. ## Needs work ##
    outputText = reactive({
        req(input$csvUpload)
        t.out = unlist(list_of_inputs())
        #paste0(t.out[6], " ", t.out[1])
        t.index = unlist(list_of_fields())
        
        a = t.out[t.index] # this works!
        b = unlist(mapply(contract.Text, 
                          unlist(inputSchema()[, "Type"]), 
                          unlist(inputSchema()[, "Display"]))) 
        c(a, b)
    })
    
    
    # 
    # Logic functions ###############################
    # 
    
    # Export user created contract (downloadContract is ID of UI button).
    output$downloadContract = downloadHandler(
        filename = download.filename, 
        # file is required by Shiny.
        content = function(file) { 
            write(paste0(outputText(), 
                         sep = "\n"), 
                  file = file) 
        }
    )
    
    # Generic widget type for use in UI. Currently only option is textInput().
    responsive.Widget = function(type, display, id) {
        switch (type,
                qbox = textInput(inputId = id, label = display), 
                title_text = NULL,
                c_text = NULL
        )
    }
    
    # Helper to display text prior to download (can this be merged with ^)?
    contract.Text = function(type, display) {
        switch (type,
                qbox = NULL, 
                title_text = NULL,
                c_text = display
        )
    }
    
    
    # 
    # Render functions ##############################
    # 
    
    
    # Display the user imported schema.
    output$userInput = renderTable({
        req(input$csvUpload)
        read.csv(file = input$csvUpload$datapath)
    })
    
    # Create dynamic user interface based on the imported schema.
    output$theForm = renderUI({
        tryCatch(
            {
                mapply(responsive.Widget, 
                       unlist(inputSchema()[, "Type"]),
                       unlist(inputSchema()[, "Display"]),
                       unlist(inputSchema()[, "Field_Name"]))
            }, 
            error = function(cond) {
                # Falls through if there's no schema uploaded.
                # This is just to prevent "red text" on the UI. 
                # No issues so far...
            })
    })
    
    # Dynamically display the text of the contract (this will be downloaded).
    output$theContract = renderText({
        paste0(outputText(), collapse = "</br>")
    })
    
    
})
