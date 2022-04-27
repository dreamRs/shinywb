
library(shiny)

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "Custom controls",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      controls = wbControls(
        min = FALSE, 
        max = FALSE,
        resize = FALSE
      )
    )
  })

  output$res <- renderPrint(input$month)

}

if (interactive())
  shinyApp(ui, server)
