# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

## ui.R

library(shiny)

shinyUI(fluidPage(

  # app header
  titlePanel("Example CSV upload"),

  # user input
  fileInput("csvUpload", "Upload CSV File", accept = '.csv'),
  
  # input display
  tableOutput("csvContents")
  
))
