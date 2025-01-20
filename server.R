if (!require("DT")) install.packages('DT')
library(shiny)
library(DT)
library(TweetScraperR)
library(dplyr)
##Sys.setenv(CHROMOTE_CHROME = "C:/Program Files (x86)/Microsoft/Edge/Application/new_msedge.exe")

server <- function(input, output, session) {
  observeEvent(input$run, {
    withProgress(message = "Sacando datos de Twitter/X...", value = 0, {
      # Empieza barra de progreso
      incProgress(0.2, detail = "Preparando parámetros...")
      
      # ingreso de inputs del usuario, los cuales se guardan en variables
      hashtag <- input$hashtag
      n_tweets <- input$n_tweets
      since <- input$since
      until <- input$until
      
      # barra de progreso: se descargan los datos
      incProgress(0.4, detail = "Descargando datos de Twitter/X...")
      tweets_data <- TweetScraperR::getTweetsHistoricalHashtag(
        hashtag = hashtag,
        n_tweets = n_tweets,
        since = since,
        until = until
      )
      
      # barra de progreso: se procesan los datos
      incProgress(0.3, detail = "Procesando datos...")
      
      # sacamos la columna que tiene imàgenes, no nos interesan
      tweets_data <- tweets_data[, !names(tweets_data) %in% "art_html"]
      
      # mostramos resultados (por el momento no se integró con frontend)
      output$result <- renderText({
        paste("Se han obtenido", nrow(tweets_data), "tweets con el hashtag", hashtag)
      })
      
      output$tweetsTable <- renderDT({
        datatable(tweets_data)
      })
    })
  })
}
