

# Exemple auto update data
options(shiny.reactlog=TRUE)


library("shiny")

ui <- fluidPage(
  tags$h1("Mise à jour de données automatique"),
  checkboxInput(inputId = "update", label = "Auto-update", value = TRUE),
  actionButton(inputId = "maj", label = "Maj !"),
  fluidRow(
    column(
      width = 4, br(), br(),
      uiOutput(outputId = "time_maj")
    ),
    column(
      width = 8,
      plotOutput(outputId = "graph")
    )
  )
)

server <- function(input, output, session) {
  
  data_maj <- reactiveValues()
  
  autoInvalidate <- reactiveTimer(2000)
  
  observe({
    if (input$update) {
      autoInvalidate()
    }
    input$maj
    data_maj$x <- c(isolate(data_maj$x), rnorm(1))
    data_maj$heure <- Sys.time()
    
  })
  
  output$time_maj <- renderUI({
    tags$span(format(data_maj$heure, format = "%H:%M:%S"), style = "font-weight: bold; font-size: 300%;")
  })
  
  
  output$graph <- renderPlot({
    plot(data_maj$x, type = "l", lwd = 2, col = "steelblue")
  })
  
}

shinyApp(ui = ui, server = server)


