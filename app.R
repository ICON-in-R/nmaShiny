#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(sna)
library(NMA)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = bs_theme(bootswatch = "slate"), # Apply a Bootswatch theme
  
  # Application title
  titlePanel("NMA Shiny app"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(

      # Load data
      fileInput("dataFile", 
                "Upload CSV file", 
                accept = c(".csv")),
      
      # Set MCMC parameters
      selectInput("prog", 
                  "Version of BUGS to use:",
                  choices = c("OpenBUGS", "WinBUGS", "jags"),
                  selected = "OpenBUGS"),
      
      # type of data
      selectInput("dataType", 
                  "Data type:",
                  choices = c("bin_data", "count_data", "conts_data"),
                  selected = "bin_data"),
      
      numericInput("nBurnin", 
                   "Burn-in:", 
                   value = 1000, 
                   min = 1),
      
      numericInput("nSims", 
                   "Number of simulations:", 
                   value = 1500, 
                   min = 1),
      
      numericInput(inputId = "nChains",
                   label = "Number of chains:", 
                   value = 2, 
                   min = 1),
      
      numericInput("nThin", 
                   "Thinning rate:", 
                   value = 1, 
                   min = 1),
      
      # Random effects?
      checkboxInput("randomEffects", 
                    "Include random effects", 
                    value = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Input", verbatimTextOutput("nmaModel")),
        tabPanel("Data", tableOutput("dataTable")),
        tabPanel("Network", plotOutput("networkPlot")),
        tabPanel("Results", verbatimTextOutput("results"))
      )
    )
  )
)

server <- function(input, output) {
  
  data <- reactive({
    req(input$dataFile)  # Ensure a file is uploaded
    read.csv(input$dataFile$datapath, stringsAsFactors = FALSE)
  })
  
  output$dataTable <- renderTable({
    req(data())  # Ensure data is loaded
    data()
  })
  
  nma_model <- reactive({
    req(data())
    
    binData <- if (input$dataType == "bin_data") data() else NULL
    countData <- if (input$dataType == "count_data") data() else NULL
    ctsData <- if (input$dataType == "conts_data") data() else NULL
    
    refTx <- NULL
    if (!is.null(binData) && "treatment" %in% colnames(binData)) {
      refTx <- unique(binData$treatment)[1]
    } else if (!is.null(countData) && "treatment" %in% colnames(countData)) {
      refTx <- unique(countData$treatment)[1]
    } else if (!is.null(ctsData) && "treatment" %in% colnames(ctsData)) {
      refTx <- unique(ctsData$treatment)[1]
    }
    
    validate(
      need(!is.null(refTx), "Reference treatment is missing or invalid.")
    )
    
    NMA::new_NMA(
      binData = binData,
      countData = countData,
      contsData = ctsData,
      bugs_params = list(
        PROG = input$prog,
        N.BURNIN = input$nBurnin,
        N.SIMS = input$nSims,
        N.CHAINS = input$nChains,
        N.THIN = input$nThin
      ),
      is_random = input$randomEffects,
      data_type = input$dataType,
      label = "",
      endpoint = ""
    )
  })
  
  output$nmaModel <- renderPrint({
    req(nma_model())
    print(nma_model())
  })
  
  output$networkPlot <- renderPlot({
    req(nma_model())
    plotNetwork(nma_model())
  })
  
  nma_res <- reactive({
    NMA::NMA_run(nma_model(), save = FALSE)
  })
  
  output$results <- renderPrint({
    req(nma_res())
    print(nma_res())
  })
}

shinyApp(ui = ui, server = server)
