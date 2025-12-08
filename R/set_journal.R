#' Set Default Journal
#'
#' Sets a global option for the target journal. This prevents you from needing
#' to specify the `journal` argument in every call to `publish_fig()`.
#'
#' @param journal Character. Name of the journal (e.g., "Nature").
#'
#' @export
set_journal <- function(journal) {
  # Validate that the journal actually exists before setting it
  # We check against the internal data
  match_idx <- which(tolower(journal_defaults$journal) == tolower(journal))
  
  if (length(match_idx) == 0) {
    stop("Journal '", journal, "' not found. Cannot set as default.")
  }
  
  # Set the standard R option
  options(figR_journal = journal)
  message("Global journal set to: ", journal)
}