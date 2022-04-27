
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



#' @title WinBox
#'
#' @description A window manager with JavaScript library [WinBox.js](https://nextapps-de.github.io/winbox/).
#'
#' @param title Title for the window.
#' @param ui Content of the window.
#' @param options List of options, see [wbOptions()].
#' @param controls List of controls, see [wbControls()].
#' @param id An unique identifier for the window.
#' @param session Shiny session.
#'
#' @return No value.
#'
#' @name WinBox
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
WinBox <- function(title,
                   ui,
                   options = wbOptions(),
                   controls = wbControls(),
                   id = NULL,
                   session = shiny::getDefaultReactiveDomain()) {
  res <- utils::getFromNamespace("processDeps", "shiny")(ui, session)
  if (is.null(id))
    id <- genId()
  options$id <- id
  options$title <- as.character(title)
  options$class <- controls
  session$sendCustomMessage("WinBox-show", list(
    html = res$html,
    deps = res$deps,
    options = options
  ))
}

#' @rdname WinBox
#' @export
closeWinBox <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("WinBox-close", list(id = id))
}



#' WinBox Options
#'
#' @param width,height Set the initial width/height of the window (supports units "px" and "%").
#' @param minwidth,minheight Set the minimal width/height of the window (supports units "px" and "%").
#' @param x,y Set the initial position of the window (supports: "right" for x-axis, "bottom" for y-axis,
#'  "center" for both, units "px" and "%" for both).
#' @param max Automatically toggles the window into maximized state when created.
#' @param top,right,bottom,left Set or limit the viewport of the window's available area (supports units "px" and "%").
#' @param background Set the background of the window (supports all CSS styles which are also supported by the style-attribute "background",
#'  e.g. colors, transparent colors, hsl, gradients, background images).
#' @param border Set the border width of the window (supports all css units, like px, %, em, rem, vh, vmax).
#'
#' @return A `list` of options to use in [WinBox()].
#' @export
#'
#' @example inst/examples/options.R
wbOptions <- function(width = NULL,
                      height = NULL,
                      minwidth = NULL,
                      minheight = NULL,
                      x = NULL,
                      y = NULL,
                      max = NULL,
                      top = NULL,
                      right = NULL,
                      bottom = NULL,
                      left = NULL,
                      background = NULL,
                      border = NULL) {
  dropNulls(list(
    width = width,
    height = height,
    minwidth = minwidth,
    minheight = minheight,
    x = x,
    y = y,
    max = max,
    top = top,
    right = right,
    bottom = bottom,
    left = left,
    background = background,
    border = border
  ))
}


#' WinBox controls
#'
#' @param animation If `FALSE`, disables the windows transition animation.
#' @param shadow If `FALSE`, disables the windows drop shadow.
#' @param header If `FALSE`, hide the window header incl. title and toolbar.
#' @param min If `FALSE`, hide the minimize icon.
#' @param max If `FALSE`, hide the maximize icon.
#' @param full If `FALSE`, hide the fullscreen icon.
#' @param close If `FALSE`, hide the close icon.
#' @param resize If `FALSE`, disables the window resizing capability.
#' @param move If `FALSE`, disables the window moving capability.
#'
#' @return A `list` of controls to use in [WinBox()].
#' @export
#'
#' @example inst/examples/controls.R
wbControls <- function(animation = TRUE,
                       shadow = TRUE,
                       header = TRUE,
                       min = TRUE,
                       max = TRUE,
                       full = FALSE,
                       close = TRUE,
                       resize = TRUE,
                       move = TRUE) {
  classes <- c(
    animation = animation,
    shadow = shadow,
    header = header,
    min = min,
    max = max,
    full = full,
    close = close,
    resize = resize,
    move = move
  )
  classes <- paste0("no-", names(classes)[!unname(classes)])
  list1(classes)
}
