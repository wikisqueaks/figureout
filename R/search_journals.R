#' Search for Available Journals
#'
#' Search the internal database for journals matching a text pattern.
#'
#' @param pattern Character. A text string to search for (e.g., "nature", "cell"). Case-insensitive.
#'
#' @return A data frame of matching journals and their publishers.
#' @export
#'
#' @examples
#' search_journals("nature")
#' search_journals("comms")
search_journals <- function(pattern) {
  # 1. Find indices of matches (ignore case)
  # We search the 'journal' column.
  matches <- grep(pattern, journal_defaults$journal, ignore.case = TRUE)
  
  if (length(matches) == 0) {
    message("No journals found matching '", pattern, "'.")
    return(invisible(NULL))
  }
  
  # 2. Return a clean data frame of results
  # We select just the publisher and journal columns for a clean view
  results <- journal_defaults[matches, c("publisher", "journal", "ncol")]
  
  return(results)
}