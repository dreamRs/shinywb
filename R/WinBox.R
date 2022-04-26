
#' Dependencies
#'
#' Include dependencies, place anywhere in the shiny UI.
#'
#' @importFrom shiny singleton tags
#'
#' @export
html_dependency_winbox <- function(){
  htmltools::htmlDependency(
    name = "winbox",
    version = packageVersion("winboxr"),
    src = list(file = "packer"),
    package = "winboxr",
    script = "WinBox.js"
  )
}

#' WinBox
#'
#' Show a vanilla JavaScript alert.
#'
#' @param msg Message to display.
#' @param session A valid shiny `session`.
#'
#' @export
WinBox <- function(ui, options = list(), id = NULL, session = shiny::getDefaultReactiveDomain()) {
  res <- utils::getFromNamespace("processDeps", "shiny")(ui, session)
  if (is.null(id))
    id <- genId()
  options$id <- id
  session$sendCustomMessage("WinBox-show", list(
    html = res$html,
    deps = res$deps,
    options = options
  ))
}

