#' Create a new figure script with a unique ID
#'
#' @param dir Character. Directory in which to create the script file.
#' @param description Character. Short description of the figure produced by the script.
#' @param hash_length Integer. Length of the hash for the unique figure ID.
#' @return Invisibly returns the path to the created script.
#'
#' @details
#' Generates an 8-character alphanumeric ID, shortens the description into a
#' safe file-name component, and creates a file named:
#'   fig<id>-<safe-description>.R
#' The file contains a single line: the file name as a quoted string.
#'
#' @examples
#' \dontrun{
#' create_fig_script("analysis/figures", "retention geometry scaling")
#' }
#' @export
new_fig_script <- function(dir, description, hash_length = 2) {
  
  # random 8-char ID
  id <- {
    chars <- c(0:9, letters)
    paste0(sample(chars, hash_length, replace = TRUE), collapse = "")
  }
  
  # safe description: lowercase, alphanumeric + hyphens
  safe_desc <- tolower(description)
  safe_desc <- gsub("[^a-z0-9]+", "-", safe_desc)
  safe_desc <- gsub("^-+|-+$", "", safe_desc)
  
  # file name
  fname <- paste0("make-fig-", id, "-", safe_desc, ".R")
  outname <- paste0("fig-", id, "-", safe_desc, ".png")
  fpath <- file.path(dir, fname)
  
  # write scaffold: name declaration, code section, and publish stub
  sep <- paste0(rep("\u2500", 76), collapse = "")
  lines <- c(
    paste0("figR.name <- \"", outname, "\""),
    "",
    paste0("# \u2500\u2500 figure code ", sep),
    "",
    "",
    "",
    paste0("# ", sep),
    "publish_fig(<my.plot>, figR.name, fig_width = , fig_height = , draft = TRUE)"
  )
  writeLines(lines, con = fpath)
  
  invisible(fpath)
}
