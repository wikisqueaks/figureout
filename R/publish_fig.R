#' Save a Publication-Ready Figure with Journal-Specific Dimensions
#'
#' @description
#' Saves a \code{ggplot} object to file using dimensions tailored to a specific journal's layout.
#' Width is given in columns spanned. Height is given in column units unless
#' \code{page = TRUE}. Landscape figures are treated as full-page figures and
#' automatically use page-based sizing.
#'
#' @param plot A \code{ggplot} object to save.
#' @param filename Character vector of one or more output filenames.
#' @param fig_width Integer. Number of columns spanned.
#' @param fig_height Numeric. Number of columns tall (default), or fraction of
#'   page height if \code{page = TRUE} or \code{landscape = TRUE}.
#' @param journal Character. Name of the journal to use for default sizing.
#'   Defaults to \code{"nature"}.
#' @param page Logical. If \code{TRUE}, interpret \code{fig_height} as fraction
#'   of page height. Default \code{FALSE}. Forced to \code{TRUE} when
#'   \code{landscape = TRUE}.
#' @param landscape Logical. If \code{TRUE}, swap page width and height and
#'   treat the figure as a full-page landscape spread.
#' @param dpi Numeric. Dots per inch resolution. Default \code{300}.
#' @param page_width Numeric. Portrait page text block width in mm. Overrides
#'   journal default if provided.
#' @param page_height Numeric. Portrait maximum figure height in mm. Overrides
#'   journal default if provided.
#' @param ncol Integer. Number of columns. Overrides journal default if provided.
#' @param col_margin Numeric. Spacing between columns in mm. Overrides journal
#'   default if provided.
#' @param row_margin Numeric. Spacing between rows (vertical gutters) in mm.
#'   Default \code{5}.
#'
#' @details
#' Default dimensions are loaded from \code{journal_defaults} based on the
#' specified journal. Users can override individual dimensions by providing
#' values for \code{page_width}, \code{page_height}, \code{ncol}, or
#' \code{col_margin}.
#'
#' @return Invisibly returns \code{NULL}.
#' @export
publish_fig <- function(plot,
                        filename,
                        fig_width,
                        fig_height,
                        journal = "nature",
                        page = FALSE,
                        landscape = FALSE,
                        dpi = 300,
                        page_width = NULL,
                        page_height = NULL,
                        ncol = NULL,
                        col_margin = NULL,
                        row_margin = 5) {
  
  defaults <- journal_defaults[[journal]]
  
  page_width  <- page_width  %||% defaults$page_width
  page_height <- page_height %||% defaults$page_height
  ncol        <- ncol        %||% defaults$ncol
  col_margin  <- col_margin  %||% defaults$col_margin
  
  if (landscape) {
    tmp <- page_width
    page_width <- page_height
    page_height <- tmp
    page <- TRUE
  }
  
  col_width <- (page_width - (ncol - 1) * col_margin) / ncol
  w <- fig_width * col_width + (fig_width - 1) * col_margin
  h <- if (page) page_height * fig_height else fig_height * col_width + (fig_height - 1) * row_margin
  
  purrr::walk(
    filename,
    ~ ggplot2::ggsave(
      filename = .x,
      plot     = plot,
      width    = w,
      height   = h,
      units    = "mm",
      dpi      = dpi
    )
  )
  
  invisible(NULL)
}
