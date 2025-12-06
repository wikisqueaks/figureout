#' Save a Publication-Ready Figure with Preset or Custom Dimensions
#'
#' @description
#' Saves a \code{ggplot} object using \code{ggsave}, with predefined dimensions for
#' common publication layouts or user-specified custom sizes. Multiple output files
#' can be written in one call by supplying a vector of filenames.
#'
#' Preset types:
#' \itemize{
#'   \item \code{"single"}: single-column width
#'   \item \code{"half"}: approximately half-page width
#'   \item \code{"double"}: two-column (full page) width
#'   \item \code{"custom"}: user-specified width and height
#' }
#'
#' @param plot A \code{ggplot} object to save.
#' @param filename A character vector giving one or more output filenames (e.g.,
#'   \code{c("figure.png", "figure.pdf")}).
#' @param type One of \code{"single"}, \code{"half"}, \code{"double"}, or \code{"custom"}.
#' @param dpi Numeric; dots per inch resolution. Default is \code{300}.
#' @param width Numeric; plot width in inches if \code{type = "custom"}.
#' @param height Numeric; plot height in inches if \code{type = "custom"}.
#'
#' @details
#' Preset dimensions (in inches):
#' \itemize{
#'   \item \code{single}: width = 3.5, height = 4
#'   \item \code{half}: width = 4.75, height = 4.5
#'   \item \code{double}: width = 7, height = 5
#' }
#' For \code{type = "custom"}, both \code{width} and \code{height} must be supplied.
#'
#' When multiple filenames are provided, the plot is saved once per filename with
#' the same dimensions and DPI.
#'
#' @return Invisibly returns \code{NULL}; the plot is saved to the specified file(s).
#'
#' @examples
#' \dontrun{
#' publish_fig(p, "fig_single.png", type = "single")
#' publish_fig(p, c("fig_half.png", "fig_half.pdf"), type = "half")
#' publish_fig(p, "fig_double.png", type = "double", dpi = 600)
#' publish_fig(p, "fig_custom.png", type = "custom", width = 6, height = 4)
#' }
#'
#' @export
publish_fig_legacy <- function(plot,
                               filename,
                               type = c("single", "half", "double", "custom"),
                               dpi = 300,
                               width = NA,
                               height = NA) {
  type <- match.arg(type)

  dims <- switch(type,
    single = list(width = 3.5, height = 4),
    half = list(width = 4.75, height = 4.5),
    double = list(width = 7, height = 4),
    custom = {
      if (is.na(width) || is.na(height)) {
        stop("For type = 'custom', both width and height must be specified.")
      }
      list(width = width, height = height)
    }
  )

  purrr::map(filename, ~ ggsave(.x, plot,
    width  = dims$width,
    height = dims$height,
    units  = "in",
    dpi    = dpi
  ))

  invisible(NULL)
}
