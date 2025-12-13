# Save a Publication-Ready Figure with Journal-Specific Dimensions

Saves a `ggplot` object to file using dimensions tailored to a specific
journal's layout. Width is given in columns spanned. Height is given in
column units unless `page = TRUE`. Landscape figures are treated as
full-page figures and automatically use page-based sizing. Additional
`ggsave()` parameters can be passed via `...`.

## Usage

``` r
publish_fig(
  plot,
  filename,
  fig_width,
  fig_height,
  journal = getOption("figR_journal", "nature"),
  page = FALSE,
  landscape = FALSE,
  dpi = 300,
  units = "mm",
  page_width = NULL,
  page_height = NULL,
  ncol = NULL,
  col_margin = NULL,
  row_margin = 5,
  ...
)
```

## Arguments

- plot:

  A `ggplot` object to save.

- filename:

  Character vector of one or more output filenames with extensions.

- fig_width:

  Integer. Number of columns spanned.

- fig_height:

  Numeric. Number of columns tall (default), or fraction of page height
  if `page = TRUE` or `landscape = TRUE`.

- journal:

  Character. Name of the journal to use for default sizing. Defaults to
  `"nature"` or the value of `getOption("figR_journal")`.

- page:

  Logical. If `TRUE`, interpret `fig_height` as fraction of page height.
  Default `FALSE`. Forced to `TRUE` when `landscape = TRUE`.

- landscape:

  Logical. If `TRUE`, swap page width and height and treat the figure as
  a full-page landscape spread.

- dpi:

  Numeric. Dots per inch resolution. Default `300`.

- units:

  Character. Units for ggsave. Default "mm".

- page_width:

  Numeric. Portrait page text block width in mm. Overrides journal
  default if provided.

- page_height:

  Numeric. Portrait maximum figure height in mm. Overrides journal
  default if provided.

- ncol:

  Integer. Number of columns. Overrides journal default if provided.

- col_margin:

  Numeric. Spacing between columns in mm. Overrides journal default if
  provided.

- row_margin:

  Numeric. Spacing between rows (vertical gutters) in mm. Default `5`.

- ...:

  Additional arguments passed to `ggsave()` (e.g., `device`,
  `limitsize`, `bg`).

## Value

Invisibly returns `NULL`.
