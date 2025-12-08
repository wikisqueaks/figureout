# figR <a href="https://wikisqueaks.github.io/figR/"><img src="man/figures/logo-hex.png" align="right" height="138" /></a>

## Overview

**figR** eliminates the guesswork of scientific figure sizing. It provides a consistent toolset to ensure your `ggplot2` graphics meet journal requirements without manual resizing:

- `publish_fig()` saves plots with precise dimensions based on column widths.
- `search_journals()` helps you find specific layout rules (Nature, Cell, Science).
- `set_journal()` allows you to define a global target for your entire script.

These combine naturally to ensure that what you see in R is exactly what appears in the PDF.

## Installation

You can install the development version of figR from [GitHub](https://github.com/) with:

```r
# install.packages("devtools")
devtools::install_github("wikisqueaks/figR")