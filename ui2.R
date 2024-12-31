library(shiny)
library(bslib)  # For modern Bootstrap styling
library(shinyjs)  # For JavaScript operations
library(waiter)  # For loading screens

# Custom dark theme
dark_theme <- bs_theme(
  bg = "#1a1b26",
  fg = "#a9b1d6",
  primary = "#7aa2f7",
  secondary = "#bb9af7",
  success = "#9ece6a",
  info = "#7dcfff",
  warning = "#e0af68",
  danger = "#f7768e",
  base_font = "Inter, sans-serif",
  "input-bg" = "#1a1b26",
  "input-border-color" = "#414868"
)

ui <- fluidPage(
  theme = dark_theme,
  useWaiter(),  # Loading screen
  useShinyjs(),  # Enable JavaScript operations
  
  # Custom CSS
  tags$head(
    tags$link(href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap", rel="stylesheet"),
    tags$style("
      .content-wrapper {
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem;
      }
      .glass-card {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border-radius: 12px;
        padding: 2rem;
        border: 1px solid rgba(255, 255, 255, 0.1);
      }
    ")
  ),
  
  # Main content
  div(class = "content-wrapper",
      # Header
      div(style = "text-align: center; margin-bottom: 3rem;",
          h1("Twitter Scraper", style = "font-size: 3rem; font-weight: 600;"),
          p("Extract valuable insights from Twitter/X with our powerful scraping tool", 
            style = "color: #a9b1d6; font-size: 1.2rem;")
      ),
      
      # Input card
      div(class = "glass-card",
          textInput("url", "Twitter URL", 
                    placeholder = "https://twitter.com/username",
                    width = "100%"),
          actionButton("scrape", "Start Scraping",
                       class = "btn-primary",
                       style = "width: 100%; margin-top: 1rem;")
      ),
      
      # Results section (initially hidden)
      hidden(
        div(id = "results_section", class = "glass-card",
            style = "margin-top: 2rem;",
            h3("Results"),
            verbatimTextOutput("results")
        )
      )
  )
)

server <- function(input, output, session) {
  # Show loading screen when scraping
  w <- Waiter$new(id = "scrape",
                  html = spin_dots(),
                  color = "#1a1b26")
  
  observeEvent(input$scrape, {
    # Validate URL
    if (!grepl("^https://(twitter\\.com|x\\.com)/.*", input$url)) {
      showNotification("Please enter a valid Twitter/X URL",
                       type = "error")
      return()
    }
    
    w$show()  # Show loading screen
    
    # Your scraping logic goes here
    Sys.sleep(2)  # Simulate processing time
    
    # Show results
    shinyjs::show("results_section")
    output$results <- renderPrint({
      "Sample scraped data will appear here"
    })
    
    w$hide()  # Hide loading screen
  })
}

shinyApp(ui = ui, server = server)
