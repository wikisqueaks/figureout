# Save a Publication-Ready Figure with Journal-Specific Dimensions

Saves a `ggplot` object to file using dimensions tailored to a specific
journal's layout. Width is given in columns spanned. Height is given in
column units unless `page = TRUE`. Landscape figures use standard A4
landscape dimensions (297 x 210 mm), with `fig_width` and `fig_height`
as fractions. Additional `ggsave()` parameters can be passed via `...`.

When output paths have been registered with
[`set_paths`](https://wikisqueaks.github.io/figureout/reference/set_paths.md),
passing a bare filename (such as `figureout.name`) is sufficient — the
figure is saved to every registered directory automatically.

## Usage

``` r
publish_fig(
  plot,
  filename,
  fig_width,
  fig_height,
  journal = getOption("figureout_journal", "nature"),
  page = FALSE,
  landscape = FALSE,
  draft = FALSE,
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

  Character. A bare filename (e.g. `figureout.name`) or a vector of full
  paths. When paths are registered via
  [`set_paths`](https://wikisqueaks.github.io/figureout/reference/set_paths.md),
  the basename of each entry is expanded across all registered
  directories.

- fig_width:

  Integer. Number of columns spanned (portrait/page modes), or fraction
  of A4 landscape width (landscape mode).

- fig_height:

  Numeric. Number of column-width units tall (default), fraction of page
  height if `page = TRUE`, or fraction of A4 landscape height if
  `landscape = TRUE`.

- journal:

  Character. Name of the journal to use for default sizing. Defaults to
  `"nature"` or the value of `getOption("figR_journal")`.

- page:

  Logical. If `TRUE`, interpret `fig_height` as a fraction of page
  height. Default `FALSE`.

- landscape:

  Logical. If `TRUE`, ignore journal page dimensions and use standard A4
  landscape (297 x 210 mm), with `fig_width` and `fig_height` as
  fractions. Default `FALSE`.

- draft:

  Logical. If `TRUE`, save to a temporary file and preview immediately
  without writing to any registered output paths. Useful for iterating
  on a figure before committing it. Default `FALSE`.

- dpi:

  Numeric. Dots per inch resolution. Default `300`.

- units:

  Character. Units for ggsave. Default `"mm"`.

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

Invisibly returns `filename`.
