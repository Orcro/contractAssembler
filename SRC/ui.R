
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


# ui.R


# User interface definition.
# Each function is a component on the webpage.
# Components that are related have no whitespace between them.
shinyUI(fluidPage(
    
    
    # Website Title
    h1(id = "titleMain", "Contract assembler prototype, v0.2.1"), 
    tags$style(HTML("#titleMain{color: #e6523b;}")), 
    
    
    # Button with upload file functionality, accepts .csv files only.
    fileInput(inputId = "csvUpload", 
              label = "Upload CSV File", 
              accept = '.csv'),
    
    
    # Display html header: <h3>Input Schema:</h3>
    tableOutput(outputId = "csvTitle"), 
    # Show the schema uploaded by the user (raw .csv data).
    tableOutput(outputId = "userInput"), 
    
    
    # Display html header: <h3>Contract Widgets:</h3>
    tableOutput(outputId = "widgetsTitle"),
    # Provide input components based on user-uploaded schema.
    wellPanel(
        uiOutput(outputId = "theForm")
    ), 
    
    
    # Side-by-side contract preview and controls.
    sidebarLayout(
        mainPanel(
            # Display html header: <h4>Contract output:</h4>
            tableOutput(outputId = "outputTitle"), 
            # Display contract output, reacts to input from the wellPanel component above.
            wellPanel(
                uiOutput(outputId = "theContract")
            ), 
        ), 
        sidebarPanel(
            # Radio controls which file type to parse the download as.
            radioButtons(inputId = "exportFormat", 
                         label = "Export control", 
                         choices = c("Text", "PDF", "Markdown"), 
                         inline = T), 
            # Button with download file functionality, currently the text of theContract.
            downloadButton(outputId = "downloadContract", 
                           label = "Export Contract"), 
        )
    ), 
    
    
    # Whitespace for formatting.
    tableOutput(outputId = "blankSpace")
    
    
))
