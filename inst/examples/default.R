
library(shiny)

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show1", label = "Show WinBox"),
  verbatimTextOutput("res")
)

server <- function(input, output, session) {

  observeEvent(input$show1, {
    WinBox(
      title = "WinBox window",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox.",
        selectInput("month", "Select a month:", month.name)
      ),
      options = list()
    )
  })

  output$res <- renderPrint(input$month)

}

shinyApp(ui, server)
