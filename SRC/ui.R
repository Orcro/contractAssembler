# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

## ui.R

library(shiny)

shinyUI(fluidPage(

  # app header
  titlePanel("Contract assembler prototype, v0.1.0"),

  # user's csv input
  fileInput(inputId = "csvUpload", 
            label = "Upload CSV File", 
            accept = '.csv'),
  
  # schema view
  # header: "<h3>Input Schema:</h3>"
  tableOutput(outputId = "csvTitle"), 
  # display the input
  tableOutput(outputId = "userInput"), 
  
  ## testing only, remove?
  ## Contract fields view
  ## header: "<h3>Input Schema:</h3>"
  #tableOutput(outputId = "contractFieldsTitle"), 
  ## display the fields
  #textOutput(outputId = "contractFields"),
  
  # contract inputs, reacts to the schema
  # header "widgets"
  tableOutput(outputId = "widgetsTitle"),
  # the input boxes etc.
  wellPanel(
      uiOutput(outputId = "theForm")
  ), 
  
  # contract output, reacts to user input in the previous widgets
  tableOutput(outputId = "outputTitle"),
  tableOutput(outputId = "testIt"), 
  # the "raw" output (what format is this?)
  wellPanel(
      uiOutput(outputId = "theContract")
  ), 
  
  # download that contract
  downloadButton("downloadContract", "Export Contract"), 
  
  tableOutput(outputId = "blankSpace")
  
))
