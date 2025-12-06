#' Save a Publication-Ready Figure for Nature Publishing Group Layout
#'
#' @description
#' Saves a \code{ggplot} object with dimensions in column units by default.
#' Width and height are integers giving the number of columns spanned.
#' Optionally, height can instead be a fraction of page height if
#' \code{page = TRUE}.
#'
#' @param plot A \code{ggplot} object to save.
#' @param filename Character vector of one or more output filenames.
#' @param fig_width Integer. Number of columns spanned.
#' @param fig_height Numeric. Number of columns tall (default), or
#'   fraction of page height if \code{page = TRUE}.
#' @param page Logical. If \code{TRUE}, interpret \code{fig_height}
#'   as fraction of page height. Default \code{FALSE}.
#' @param dpi Numeric; dots per inch resolution. Default \code{300}.
#' @param page_width Numeric; page text block width in mm. Default \code{183}.
#' @param page_height Numeric; max figure height in mm. Default \code{170}.
#' @param ncol Integer; number of columns. Default \code{2}.
#' @param col_margin Numeric; spacing between columns in mm. Default \code{5}.
#'
#' @details
#' Defaults follow Nature Publishing Group:
#' \itemize{
#'   \item Single column = 89 mm
#'   \item Double column = 183 mm
#'   \item Maximum height = 170 mm
#' }
#'
#' @return Invisibly returns \code{NULL}.
#' @export
publish_fig <- function(plot,
                        filename,
                        fig_width,
                        fig_height,
                        page = FALSE,
                        dpi = 300,
                        page_width = 183,
                        page_height = 170,
                        ncol = 2,
                        col_margin = 5) {
  # base column width
  col_width <- (page_width - (ncol - 1) * col_margin) / ncol

  # width in mm
  w <- fig_width * col_width + (fig_width - 1) * col_margin

  # height in mm
  if (page) {
    h <- page_height * fig_height
  } else {
    h <- fig_height * col_width + (fig_height - 1) * col_margin
  }

  purrr::map(filename, ~ ggplot2::ggsave(.x, plot,
    width  = w,
    height = h,
    units  = "mm",
    dpi    = dpi
  ))

  invisible(NULL)
}
