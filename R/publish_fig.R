#' Save a Publication-Ready Figure with Journal-Specific Dimensions
#'
#' @description
#' Saves a \code{ggplot} object to file using dimensions tailored to a specific journal's layout.
#' Width is given in columns spanned. Height is given in column units unless
#' \code{page = TRUE}. Landscape figures use standard A4 landscape dimensions (297 x 210 mm),
#' with \code{fig_width} and \code{fig_height} as fractions. Additional \code{ggsave()}
#' parameters can be passed via \code{...}.
#'
#' When output paths have been registered with \code{\link{set_paths}}, passing a bare
#' filename (such as \code{figR.name}) is sufficient — the figure is saved to every
#' registered directory automatically.
#'
#' @param plot A \code{ggplot} object to save.
#' @param filename Character. A bare filename (e.g. \code{figR.name}) or a vector of full
#'   paths. When paths are registered via \code{\link{set_paths}}, the basename of each
#'   entry is expanded across all registered directories.
#' @param fig_width Integer. Number of columns spanned (portrait/page modes), or fraction
#'   of A4 landscape width (landscape mode).
#' @param fig_height Numeric. Number of column-width units tall (default), fraction of
#'   page height if \code{page = TRUE}, or fraction of A4 landscape height if
#'   \code{landscape = TRUE}.
#' @param journal Character. Name of the journal to use for default sizing.
#'   Defaults to \code{"nature"} or the value of \code{getOption("figR_journal")}.
#' @param page Logical. If \code{TRUE}, interpret \code{fig_height} as a fraction
#'   of page height. Default \code{FALSE}.
#' @param landscape Logical. If \code{TRUE}, ignore journal page dimensions and use
#'   standard A4 landscape (297 x 210 mm), with \code{fig_width} and \code{fig_height}
#'   as fractions. Default \code{FALSE}.
#' @param draft Logical. If \code{TRUE}, save to a temporary file and preview
#'   immediately without writing to any registered output paths. Useful for
#'   iterating on a figure before committing it. Default \code{FALSE}.
#' @param dpi Numeric. Dots per inch resolution. Default \code{300}.
#' @param units Character. Units for ggsave. Default \code{"mm"}.
#' @param page_width Numeric. Portrait page text block width in mm. Overrides
#'   journal default if provided.
#' @param page_height Numeric. Portrait maximum figure height in mm. Overrides
#'   journal default if provided.
#' @param ncol Integer. Number of columns. Overrides journal default if provided.
#' @param col_margin Numeric. Spacing between columns in mm. Overrides journal
#'   default if provided.
#' @param row_margin Numeric. Spacing between rows (vertical gutters) in mm.
#'   Default \code{5}.
#' @param ... Additional arguments passed to \code{ggsave()} (e.g., \code{device},
#'   \code{limitsize}, \code{bg}).
#'
#' @return Invisibly returns \code{filename}.
#' @export
publish_fig <- function(plot,
                        filename,
                        fig_width,
                        fig_height,
                        journal = getOption("figR_journal", "nature"),
                        page = FALSE,
                        landscape = FALSE,
                        draft = FALSE,
                        dpi = 300,
                        units = "mm",
                        page_width = NULL,
                        page_height = NULL,
                        ncol = NULL,
                        col_margin = NULL,
                        row_margin = 5,
                        ...) {

  # 1. Lookup Journal in Internal Dataframe
  match_idx <- which(tolower(journal_defaults$journal) == tolower(journal))

  if (length(match_idx) == 0) {
    stop("Journal '", journal, "' not found. Use list_journals() to see available options.", call. = FALSE)
  }

  defaults <- as.list(journal_defaults[match_idx, ])

  # 2. Apply Defaults (using internal helper `%||%`)
  page_width  <- page_width  %||% defaults$page_width
  page_height <- page_height %||% defaults$page_height
  ncol        <- ncol        %||% defaults$ncol
  col_margin  <- col_margin  %||% defaults$col_margin

  # 3. Compute figure dimensions
  if (landscape) {
    # A4 landscape: fig_width and fig_height are fractions (0-1) of 297 x 210 mm.
    w <- 297 * fig_width
    h <- 210 * fig_height
  } else if (page) {
    # A4 portrait: fig_width and fig_height are fractions (0-1) of 210 x 297 mm.
    w <- 210 * fig_width
    h <- 297 * fig_height
  } else {
    # Column grid: fig_width and fig_height are column-width units.
    col_width <- (page_width - (ncol - 1) * col_margin) / ncol
    w <- fig_width  * col_width + (fig_width  - 1) * col_margin
    h <- fig_height * col_width + (fig_height - 1) * row_margin
  }

  # 4. Draft mode: save to temp file and preview; skip registered paths
  if (draft) {
    tmp <- file.path(tempdir(), basename(filename[[1]]))
    ggplot2::ggsave(
      filename = tmp,
      plot     = plot,
      width    = w,
      height   = h,
      units    = units,
      dpi      = dpi,
      ...
    )
    if (rstudioapi::isAvailable()) rstudioapi::viewer(tmp)
    return(invisible(tmp))
  }

  # 5. Resolve filenames against registered paths (if any)
  fig_paths <- getOption("figR_paths")
  if (!is.null(fig_paths)) {
    filename <- as.vector(outer(fig_paths, basename(filename), file.path))
  }

  # 6. Save (loop over filenames)
  for (f in filename) {
    ggplot2::ggsave(
      filename = f,
      plot     = plot,
      width    = w,
      height   = h,
      units    = units,
      dpi      = dpi,
      ...
    )
  }

  invisible(filename)
}
