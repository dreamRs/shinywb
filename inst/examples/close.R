
library(shiny)

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox"),
  actionButton(inputId = "close", label = "Close WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      id = "mywinbox",
      title = "WinBox window",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      )
    )
  })

  observeEvent(input$close, closeWinBox("mywinbox"))

}

shinyApp(ui, server)
