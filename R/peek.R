#' Preview exported figure files
#'
#' Opens one or more exported figure files in the RStudio Viewer by copying each
#' file to a session temp directory and generating a small HTML wrapper. This
#' avoids broken links caused by Viewer restrictions on local file URLs.
#'
#' @param filename Character vector of file paths, typically the (invisible)
#'   return value from [publish_fig()].
#' @param viewer Where to preview files. `"auto"` uses the RStudio Viewer when
#'   available and otherwise falls back to the system handler; `"rstudio"` forces
#'   the RStudio Viewer; `"system"` forces the system handler.
#'
#' @return Invisible character vector of normalized file paths.
#'
#' @export
peek <- function(filename, viewer = c("auto", "rstudio", "system")) {
  viewer <- match.arg(viewer)
  
  files <- as.character(filename)
  files <- files[!is.na(files) & nzchar(files)]
  if (length(files) == 0) stop("peek(): no filenames provided.", call. = FALSE)
  
  files <- normalizePath(files, winslash = "/", mustWork = TRUE)
  
  have_rstudio <- requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()
  
  use_rstudio <- (viewer %in% c("auto", "rstudio")) && have_rstudio
  
  if (!use_rstudio) {
    if (viewer == "rstudio" && !have_rstudio) {
      stop("peek(): RStudio Viewer not available (rstudioapi missing or not in RStudio).", call. = FALSE)
    }
    for (f in files) utils::browseURL(paste0("file:///", f))
    return(invisible(files))
  }
  
  v <- getOption("viewer", rstudioapi::viewer)
  
  for (f in files) {
    ext <- tolower(tools::file_ext(f))
    
    d <- tempfile("figR_peek_")
    dir.create(d)
    dest <- file.path(d, basename(f))
    file.copy(f, dest, overwrite = TRUE)
    
    # Prefer data-URI embedding for images (most reliable inside Viewer)
    body <- if (ext %in% c("png", "jpg", "jpeg", "gif", "svg", "webp")) {
      uri <- knitr::image_uri(dest)
      sprintf('<img src="%s" style="max-width:100%%;height:auto;display:block;margin:0 auto;">', uri)
    } else if (ext == "pdf") {
      sprintf('<embed src="%s" type="application/pdf" width="100%%" height="100%%">', basename(dest))
    } else {
      sprintf('<a href="%s">%s</a>', basename(dest), basename(dest))
    }
    
    html <- file.path(d, "index.html")
    writeLines(
      c(
        "<!doctype html>",
        "<html><head><meta charset='utf-8'></head>",
        "<body style='margin:0;padding:0;'>",
        body,
        "</body></html>"
      ),
      con = html
    )
    
    v(html)
  }
  
  invisible(files)
}
