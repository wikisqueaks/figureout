# Set Default Output Paths for Figures

Registers one or more output directories that
[`publish_fig()`](https://wikisqueaks.github.io/figureout/reference/publish_fig.md)
will automatically save to. When paths are registered, passing a bare
filename (i.e. `figureout.name`) to
[`publish_fig()`](https://wikisqueaks.github.io/figureout/reference/publish_fig.md)
will save the figure to every registered directory, eliminating the need
for manual path construction.

## Usage

``` r
set_paths(..., create = FALSE)
```

## Arguments

- ...:

  Character. One or more directory paths.

- create:

  Logical. If `TRUE`, create any directories that do not already exist.
  Default `FALSE`.

## Value

Invisibly returns the registered paths.

## Details

Paths are stored in the R option `figureout_paths` for the duration of
the session. Call `set_paths()` with no arguments to clear all
registered paths.

## See also

[`publish_fig`](https://wikisqueaks.github.io/figureout/reference/publish_fig.md),
[`set_journal`](https://wikisqueaks.github.io/figureout/reference/set_journal.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set_paths("report/assets", "figures")
# publish_fig() will now save to both directories automatically
} # }
```
