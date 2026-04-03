#' Set Default Output Paths for Figures
#'
#' Registers one or more output directories that \code{publish_fig()} will
#' automatically save to. When paths are registered, passing a bare filename
#' (i.e. \code{infigurate.name}) to \code{publish_fig()} will save the figure to
#' every registered directory, eliminating the need for manual path construction.
#'
#' @param ... Character. One or more directory paths.
#' @param create Logical. If \code{TRUE}, create any directories that do not
#'   already exist. Default \code{FALSE}.
#'
#' @details
#' Paths are stored in the R option \code{infigurate_paths} for the duration of the
#' session. Call \code{set_paths()} with no arguments to clear all registered
#' paths.
#'
#' @return Invisibly returns the registered paths.
#'
#' @examples
#' \dontrun{
#' set_paths("report/assets", "figures")
#' # publish_fig() will now save to both directories automatically
#' }
#'
#' @seealso \code{\link{publish_fig}}, \code{\link{set_journal}}
#' @export
set_paths <- function(..., create = FALSE) {
  paths <- c(...)

  # Called with no arguments: clear registered paths
  if (is.null(paths) || length(paths) == 0) {
    options(infigurate_paths = NULL)
    message("infigurate output paths cleared.")
    return(invisible(NULL))
  }

  if (create) {
    lapply(paths, dir.create, recursive = TRUE, showWarnings = FALSE)
  }

  missing_dirs <- paths[!dir.exists(paths)]
  if (length(missing_dirs) > 0) {
    warning(
      "The following directories do not exist: ",
      paste(missing_dirs, collapse = ", "),
      "\nUse set_paths(..., create = TRUE) to create them.",
      call. = FALSE
    )
  }

  options(infigurate_paths = paths)
  message("infigurate output paths set to:\n", paste0("  - ", paths, collapse = "\n"))
  invisible(paths)
}
