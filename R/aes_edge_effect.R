#' Initialize plotting environment
#'
#' Defines palettes, labels, line widths, and shading color used for figures.
#'
#' @return A named list of plotting defaults.
#' @export
theme_edge <- function() {
  pal <- ggsci::pal_npg()
  edge_pal <- pal(5)
  edge_labs <- c("10 m", "25 m", "50 m", "75 m", "100 m")
  edge_lw <- 0.8
  shaded_region_col <- "grey70"
  shaded_region_alpha <- 0.20

  list(
    pal = pal,
    edge_pal = edge_pal,
    edge_labs = edge_labs,
    edge_lw = edge_lw,
    shaded_region_col = shaded_region_col,
    shaded_region_alpha = shaded_region_alpha
  )
}
