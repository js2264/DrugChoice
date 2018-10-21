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

## Define each dashbord tab individually ---------------------------------------------------------------------------

# Single-gene entry
TAB1 <- tabItem(
    tabName = 'drug',
    fluidPage(
        ## Row 1: Gene entry
        fluidRow(
            column(width = 4, {
                pickerInput(
                  inputId = "disease", 
                  label = "Select/deselect cancer type", 
                  choices = cancerTypes, 
                  options = list(`actions-box` = TRUE), 
                  multiple = F
                 )
            } ),
            column(width = 4, {
                pickerInput(
                  inputId = "drugs", 
                  label = "Select/deselect all drugs used", 
                  choices = drugs, 
                  options = list(`actions-box` = TRUE), 
                  multiple = TRUE
                 )
            } )
        ),
        br(),
        hr(),
        br(),
        fluidRow(
            column(width = 2, {
                fileInput(
                    inputId = "preDrug",
                    label = "Choose sequencing file (pre-treatment)",
                    accept = c(
                        "text/csv",
                        "text/comma-separated-values,text/plain",
                        ".csv"
                    ),
                    width = "95%"
                )
            } ),
            column(width = 2, br()),
            column(width = 2, {
                fileInput(
                    inputId = "postDrug",
                    label = "Choose sequencing file (post-treatment)",
                    accept = c(
                        "text/csv",
                        "text/comma-separated-values,text/plain",
                        ".csv"
                    ),
                    width = "95%"
                )
            } )
        ), 
        h4("Or..."),
        br(), 
        fluidRow(
            column(width = 4, {
                textAreaInput(
                    inputId = "preDrugURL",
                    label = "URL of sequencing data pre-treatment",
                    placeholder = 'https://illumina.com/runID/seqID',
                    width = "95%"
                )
            } ),
            column(width = 4, {
                textAreaInput(
                    inputId = "postDrugURL",
                    label = "URL of sequencing data post-treatment",
                    placeholder = 'https://illumina.com/runID/seqID',
                    width = "95%"
                )
            } )
        ),
        br(),
        br(),
        fluidRow(
            column(
                width = 6, 
                actionBttn(
                    inputId = "submitData", 
                    label = "Is the drug effective?", 
                    icon = icon("search", lib = "font-awesome"), 
                    style = "simple",
                    color = "warning",
                    size = "l",
                    block = T,
                    no_outline = TRUE
                )
            )
        )
    )
)

TAB2 <- tabItem(
    tabName = 'results',
    fluidPage(
        column(width = 7, 
            box(
                title = "Clustering of patient with database",
                status = "warning", 
                solidHeader = TRUE, 
                width = NULL,
                collapsible = TRUE,
                plotOutput("plot", height = '500px', width = "100%") %>% withSpinner(type = 6, color = "#421500", size = 0.5)
            )
        ),
        column(width = 1),
        column(width = 4, 
            box(
                title = "Should drug treatment be continued?",
                status = "primary", 
                solidHeader = TRUE, 
                width = NULL,
                collapsible = TRUE,
                collapsed = T,
                HTML(paste0(
                    br(),
                    paste0(h4("Average F1 score using Random Forest Algorithm: "), p("   ~ 0.95")),
                    br(),
                    paste0(h4("Average F1 score using k-NN Algorithm: "), p("   ~ 0.85")), 
                    br(),
                    br(),
                    br(),
                    actionBttn(inputId = NULL, label = "Continuing drug treatment is recommended.", style = 'bordered', size = 'l', block = T, color = "success")
                ))
            )
        )
    )
)

## Finalise UI ----------------------------------------------------------------------------------------------------

SIDEBAR <- sidebarMenu(
	id = "tabs", 
    menuItem("Input", tabName = "drug", icon = icon("ellipsis-h", lib = "font-awesome")),
    menuItem("Output", tabName = "results", icon = icon("ellipsis-h", lib = "font-awesome"))
)

BODY <- tabItems(TAB1, TAB2)

shinyUI <- dashboardPage(
    dashboardHeader(title = "Drug responsiveness prediction tool (DruRP)", titleWidth = 300),
    dashboardSidebar(
        SIDEBAR,
        collapsed = TRUE
    ),
    dashboardBody(
        shinyDashboardThemes(
          theme = "grey_light"
        ),
        BODY
    )
)

## 