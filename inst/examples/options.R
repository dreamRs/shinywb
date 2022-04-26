
library(shiny)

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "Custom background color and border",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = optionsWinBox(background = "#112446", border = "0.5em")
    )
  })

  output$res <- renderPrint(input$month)

}

if (interactive())
  shinyApp(ui, server)
