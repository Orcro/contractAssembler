
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: CC0-1.0


# setup.R


# don't execute this script every deployment! jump ahead to line 18

# required to connect to shinyapps.io (not necessary if self hosted?)
install.packages("rsconnect")
install.packages("shiny")

# deploy contractAssembler to  https://galacticalex.shinyapps.io/contractassembler/
library(rsconnect)

# run web dashboard (credentials omitted)
rsconnect::setAccountInfo(name = '<USERNAME>', 
                          token = '<TOKEN>', 
                          secret = '<SECRET>')
deployApp(localLocation, appName = "contractAssembler")

# run locally
library(shiny)
localLocation = "SRC"
setwd(localLocation)
runApp()
