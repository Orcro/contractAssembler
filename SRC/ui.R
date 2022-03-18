# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

## ui.R

library(shiny)

shinyUI(fluidPage(

  # app header
  titlePanel("Example CSV upload"),

  # user's csv input
  fileInput(inputId = "csvUpload", 
            label = "Upload CSV File", 
            accept = '.csv'),
  
  # display the input
  tableOutput("userInput"), 
  
  textOutput("csvNames")
  
))
