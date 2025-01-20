library(shiny)
library(DT)
ui <- fluidPage(
  
  titlePanel("Twitter Scraper: Buscá por hashtag"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("hashtag", "Hashtag:", value = "#"),
      numericInput("n_tweets", "Número de tweets:", value = 100, min = 1),
      dateInput("since", "Fecha de inicio:", value = "2024-11-26"),
      dateInput("until", "Fecha de fin:", value = "2024-11-30"),
      actionButton("run", "Obtener Tweets")
    ),
    
    mainPanel(
      DTOutput("tweetsTable")
    )
  )
)