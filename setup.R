# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


# don't execute this script every deployment! jump ahead to line 18

# required to connect to shinyapps.io (not necessary if self hosted?)
install.packages("rsconnect")
install.packages("shiny")


# deploy contractAssembler to  https://galacticalex.shinyapps.io/contractassembler/
library(rsconnect)

# run w/ credentials from web dashboard
rsconnect::setAccountInfo(name = 'galacticalex', 
                          token = '<TOKEN>', 
                          secret = '<SECRET>')
localLocation = "."
deployApp(localLocation)

# run locally
library(shiny)
runApp()
