# figR

## Overview

**figR** eliminates the guesswork of figure layout sizing in scientific
journals. It provides a consistent toolset to ensure your `ggplot2`
graphics meet journal requirements.

- [`publish_fig()`](https://wikisqueaks.github.io/figR/reference/publish_fig.md)
  saves plots with precise dimensions based on column widths.
- [`search_journals()`](https://wikisqueaks.github.io/figR/reference/search_journals.md)
  helps you find specific layout rules (Nature, Cell, Science).
- [`set_journal()`](https://wikisqueaks.github.io/figR/reference/set_journal.md)
  allows you to define a global target for your entire script.

These combine naturally to ensure that what you see in R is exactly what
appears in the PDF.

## Installation

You can install the development version of figR from
[GitHub](https://github.com/) with:

``` r

# install.packages("devtools")
devtools::install_github("wikisqueaks/figR")
```
