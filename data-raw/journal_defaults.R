## data-raw/journal_defaults.R

# 1. Define Helper (Internal Use Only)
add_journal <- function(df = NULL, publisher, journal, page_width, page_height, ncol, col_margin) {
  new_row <- data.frame(
    publisher   = publisher,
    journal     = journal,
    page_width  = page_width,
    page_height = page_height,
    ncol        = ncol,
    col_margin  = col_margin,
    stringsAsFactors = FALSE
  )
  
  if (is.null(df)) return(new_row)
  rbind(df, new_row)
}

# 2. Build Data
# 2. Build Data (Positional arguments: Publisher, Journal, Width, Height, Ncol, ColMargin)
jd <- NULL
jd <- add_journal(jd, "Frontiers", "Frontiers", 175, 240, 2, 5)
jd <- add_journal(jd, "Frontiers", "Frontiers in Ecology and Evolution", 175, 240, 2, 5)
jd <- add_journal(jd, "Nature",    "Nature", 183, 170, 2, 5)
jd <- add_journal(jd, "PLOS",      "PLOS One", 190, 210, 2, 10)
jd <- add_journal(jd, "Elsevier",  "Cell", 174, 230, 2, 5)
jd <- add_journal(jd, "Elsevier",  "Rhizosphere", 180, 240, 2, 10)
jd <- add_journal(jd, "Wiley",     "Global Change Biology", 178, 240, 2, 6)
jd <- add_journal(jd, "Wiley/ESA", "Ecological Applications", 178, 242, 2, 6)
jd <- add_journal(jd, "Wiley/ESA", "Ecological Monographs", 178, 242, 2, 6)
jd <- add_journal(jd, "Wiley/ESA", "Ecology", 178, 242, 2, 6)
jd <- add_journal(jd, "Wiley/ESA", "Ecosphere", 178, 242, 2, 6)
jd <- add_journal(jd, "Wiley/ESA", "Frontiers in Ecology and the Environment", 178, 242, 2, 6)
jd <- add_journal(jd, "Wiley/NSO", "Oikos", 178, 231, 2, 4.66)


# 3. Sort, Clean, and Save
# Sort by Publisher first, then Journal name
jd <- jd[order(jd$publisher, jd$journal), ]

# Reset row numbers so they go 1, 2, 3...
row.names(jd) <- NULL

journal_defaults <- jd

usethis::use_data(journal_defaults, overwrite = TRUE, internal = TRUE)