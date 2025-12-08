#' Search or List Available Journals
#'
#' Search the internal database for journals matching a text pattern in either
#' the journal name or the publisher name.
#' If no pattern is provided, returns the entire table of journals.
#'
#' @param pattern Character (Optional). A text string to search for (e.g., "nature").
#'   Case-insensitive. If \code{NULL} (the default), returns all journals.
#'
#' @return A data frame of journal definitions.
#' @export
#'
#' @examples
#' # Show all available journals
#' search_journals()
#'
#' # Search by Journal Name
#' search_journals("comms")
#'
#' # Search by Publisher
#' search_journals("Elsevier")
search_journals <- function(pattern = NULL) {
  
  # 1. If no pattern, return the whole table
  if (is.null(pattern)) {
    return(journal_defaults)
  }
  
  # 2. Search both 'journal' and 'publisher' columns
  # Find indices where pattern appears in Journal Name
  idx_journal <- grep(pattern, journal_defaults$journal, ignore.case = TRUE)
  
  # Find indices where pattern appears in Publisher Name
  idx_publisher <- grep(pattern, journal_defaults$publisher, ignore.case = TRUE)
  
  # Combine unique indices (OR logic)
  matches <- unique(c(idx_journal, idx_publisher))
  
  if (length(matches) == 0) {
    message("No journals found matching '", pattern, "'.")
    return(invisible(NULL))
  }
  
  # 3. Return the full rows for the matches
  # Sort them by publisher/journal for clean reading
  results <- journal_defaults[matches, ]
  results <- results[order(results$publisher, results$journal), ]
  
  return(results)
}