
library(shiny)
library(apexcharter)
library(ggplot2)
data("economics", package = "ggplot2")

ui <- fluidPage(
  tags$style("body {min-height: 100vh;}"),
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "With an htmlwidget",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Economic chart"),
        selectInput("var", "Select a variable:", names(economics)[-1]),
        renderApexchart({
          apex(data = economics, type = "line", mapping = aes(x = date, y = !!sym(input$var))) %>%
            ax_stroke(width = 1)
        })
      ),
      options = optionsWinBox(height = 630)
    )
  })

}

shinyApp(ui, server)
