#=============================================================================#
#                                                                             #
#     USAGE: THIS IS NOT A FUNCTIONAL SCRIPT.                                 #
#     It is a part of a Shiny app                                             #
#                                                                             #
#     AUTHOR: Jacques SERIZAY                                                 #
#     CREATED: 2018/07/13                                                     #
#     REVISION: 2018/10/05                                                    #
#                                                                             #
#=============================================================================#

## Load libraries ----------------------------------------------------------------------------------------------------

require(shiny)
require(shinydashboard)
require(shinyWidgets)
require(dashboardthemes)
require(ggplot2)
require(magrittr)
require(shinycssloaders)

## Load important data ----------------------------------------------------------------------------------------------------
cancerTypes <- readLines('http://tispelegans.site/www_DrugChoice/cancerTypes.txt')
drugs <- readLines('http://tispelegans.site/www_DrugChoice/drugs.txt')
#
### Read Amber's simulated data
#ToyMetadata <- read.csv('http://tispelegans.site/www_DrugChoice/ToyMetadata.csv', stringsAsFactors = F)
#ToyDataset <- read.csv('http://tispelegans.site/www_DrugChoice/ToyDataset.csv')
#row.names(ToyDataset) <- ToyDataset[,1]
#ToyDataset <- ToyDataset[,-1]
#tab <- ToyDataset
#tabMetadata <- ToyMetadata
#save.image('RData.R')
#
load('RData.R')

## Define functions ----------------------------------------------------------------------------------------------------
# Function to input several genes separated by newlines
textareaInput <- function(inputId, label, value = "", placeholder = "", rows = 2)
{
  tagList(
    div(strong(label), style="margin-top: 5px;"),
    tags$style(type="text/css", "textarea {width:100%; margin-top: 5px;}"),
    tags$textarea(id = inputId, placeholder = placeholder, rows = rows, value))
}

