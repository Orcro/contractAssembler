
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


# ui.R


# User interface definition.
# Each function is a component on the webpage.
# Components that are related have no whitespace between them.
shinyUI(fluidPage(
    
    
    # Website Title
    titlePanel(title = "Contract assembler prototype, v0.1.1"),
    
    
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
    
    
    # Display html header: <h3>Contract Output:</h3>
    tableOutput(outputId = "outputTitle"),
    # Display contract output, reacts to input from the wellPanel component above.
    wellPanel(
        uiOutput(outputId = "theContract")
    ), 
    
    
    # Button with download file functionality, currently the text of theContract.
    downloadButton(outputId = "downloadContract", 
                   label = "Export Contract"), 
    
    
    # Whitespace for formatting.
    tableOutput(outputId = "blankSpace")
    
    
))
