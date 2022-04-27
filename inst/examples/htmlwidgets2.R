
library(shiny)
library(reactable)
library(ggplot2)
data("midwest", package = "ggplot2")

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {
  
  observeEvent(input$show, {
    inputId <- paste0("var", input$show)
    WinBox(
      title = "With an htmlwidget",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h3("Midwest demographics"),
        renderReactable({
          reactable(data = midwest, bordered = TRUE, striped = TRUE)
        })
      ),
      options = wbOptions(height = 630)
    )
  })
  
}

shinyApp(ui, server)
