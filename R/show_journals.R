#' List Available Journals
#'
#' @description
#' Returns a data frame of journal names for which default figure dimensions are available.
#'
#' @return A data frame with one column, \code{Journals}, containing sorted journal names.
#' @export
show_journals <- function() {
  journals <- sort(names(journal_defaults))
  data.frame(Journals = journals, stringsAsFactors = FALSE)
}
