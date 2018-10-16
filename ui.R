## UI

library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(gplots)
library(DESeq2)

header <- dashboardHeader(
  title = "Screen Analysis"
)

sidebar <- dashboardSidebar( 
  sidebarMenu(id="menu1",
              menuItem("Intro", icon = icon("user"),
                       menuSubItem("Hello", tabName = "intro"),
                       menuSubItem("Workflow", tabName = "workflow")
              ),
              menuItem("Data Input", icon = icon("file"),
                       menuSubItem("Screen data", tabName = "datainput")
              ),
              menuItem("Summary", tabName="dataSummary", icon = icon("table")),
              
              menuItem("Analysis", icon = icon("area-chart"),
                       menuSubItem("DEseq2", tabName="deseq2")
              ),
              menuItem("Comparison", icon = icon("bar-chart-o"),tabName="compare")
              
  ),helpText("Door Mascha")
)

body <- dashboardBody(
  tabItems(
    ### Intro panel
    tabItem(tabName = "intro",
            h2("Intro"),
            p("Hier komt tekst", style = "padding-left: 0em"),
            
            ## Data input
            h3("1. Data input", style = "padding-left: 1em"),
            p("Input data in '.txt' or '.csv' format", style = "padding-left: 2em"),
            h4("1.1 Count data", style = "padding left: 3em"), 
            tableOutput("counttable"),
            
            h4("1.2 Meta", style = "padding-left: 3em"),
            p("Meta data", style = "padding-left: 5em"),
            tableOutput("metatable"),
            
            ### Analysis
            h3("3. Analysis", style = "padding-left: 1em"),
            p("This app implements ", a("DESeq2 ", href="http://bioconductor.org/packages/release/bioc/html/DESeq2.html"),
              "for analysis", style = "padding-left: 2em")
  ),
  
  tabItem(tabName = "workflow",
          h3("Analysis Workflow"),
          
          p(strong("Step 1: Data Input "), "Upload your input data ('Raw Count Table' and 'Meta-data Table')
            via 'Data Input' section panel for single-factor or multi-factor experiment, 
            a summary of your input data will be presented."
            , style="padding-left: 2em; padding-top: 1em"),
          p(strong("Step 2: Data Summarization "), "Filter out the low expression genetic features via 'Data Summarization' section panel, 
            summarized count results after filtering will be presented here."
            , style="padding-left: 2em"),
          p(strong("Step 3: DE analysis (3 methods) "), "Conduct DE analysis on the 'Data Analysis' section."
            , style="padding-left: 2em"),
          p(strong("Step 4: Methods Comparison "), "Compare/cross-validate DE analysis results via 'Methods Comparison' section panel."
            , style="padding-left: 2em"), 
          ),
  
  tabItem(tabName = "datainput",
          
          fluidRow(
            box(title = "Data Input",
                solidHeader = TRUE, status = "info",
                collapsible = TRUE, collapsed = FALSE,
                width = 12,
                
                fluidRow(
                  box(title = "Count data",
                      solidHeader = TRUE, status = "info",
                      width = 6,
                      helpText("Data upload", style = "color:black; padding-riht:0em"),
                      
                      fileInput(inputId = "countfile",
                                label = NULL,
                                accept = c("text/tab-seperated-values",
                                           "text/csv",
                                           "text/comma-seperated-values",
                                           "text/tab-seperated-values",
                                           ".txt",
                                           ".csv",
                                           ".tsv")
                                ),
                      radioButtons(inputId = "countfilesep",
                                   label = "seperator",
                                   choices = c(Comma = ',',
                                               Semicolon = ';',
                                               Tab = '\t'),
                                   selected = '\t')
                      ),
                  
                  ## Meta
                  
                  box(title = "Meta",
                      solidHeader = TRUE, status = "info",
                      width = 6,
                      helpText("Upload meta table", style = "color:black; padding-right:0em"),
                      
                      fileInput(inputId = "metatab",
                                label = NULL,
                                accept = c('text/tab-seperated-values',
                                           'text/csv',
                                           'text/comma-seperated-values',
                                           'text/tab-seperated-values',
                                           '.txt',
                                           '.csv',
                                           '.tsv')
                                ),
                      radioButtons(inputId = "metasep",
                                   label = "seperator",
                                   choices = c(Comma = ',',
                                               Semicolon = ';',
                                               Tab = '\t'),
                                   selected = '\t'),
                      helpText("hier kan helptext over metatable", style = "color:black;")
                      )
                ),
                
                actionButton("datasubmit", label = "submit"),
                tags$style("button#datasubmit {margin-left:auto;margin-right:auto;display:block; background-color:#00CCF;
                           padding: 5px; font-family:Andika, Arial, sans-serif; font-size:1.5em; letter-spacing:0.05em;
                           text-transform:uppercase ;color:#fff; text-shadow: 0px 1px 10px #000;border-radius: 15px;box-shadow:
                           rgba(0, 0, 0, .55) 0 1px 6px;}"),
                helpText(textOutput("errorinputsingle"), style = "color:red;")
                         
                )
          ),
          
          ## Input information 
          fluidRow(
            
          )
          )
))