

# Exemple Shiny.onInputChange ----


library("shiny")


ui <- fluidPage(
  tags$h1("Example ", tags$code("Shiny.onInputChange")),
  fluidRow(
    column(
      width = 6,
      tags$div(
        style = "width: 100%; height: 400px; border: 1px solid;",
        id = "mydiv"
      ),
      tags$script(
        "var wait = false;
        $('#mydiv').mousemove(function(event) {
        if (!wait) {
        Shiny.onInputChange('draw', {x:event.pageX, y: event.pageY});
        wait = true;
        setTimeout(function(){ wait = false; },200);
        }
        });"
     )
      ),
    column(
      width = 6,
      plotOutput(outputId = "plot")
    )
    )
)

server <- function(input, output, session) {
  
  r <- reactiveValues(x = 0, y = 0)
  
  observeEvent(input$draw, {
    r$x <- c(r$x, input$draw$x)
    r$y <- c(r$y, input$draw$y * -1)
  })
  
  
  output$plot <- renderPlot({
  par(mar = c(0, 0, 0, 0))
    plot(x = r$x, y = r$y, type = "l")
  })
  
}

shinyApp(ui = ui, server = server)
