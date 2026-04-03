# Search or List Available Journals

Search the internal database for journals matching a text pattern in
either the journal name or the publisher name. If no pattern is
provided, returns the entire table of journals.

## Usage

``` r
search_journals(pattern = NULL)
```

## Arguments

- pattern:

  Character (Optional). A text string to search for (e.g., "nature").
  Case-insensitive. If `NULL` (the default), returns all journals.

## Value

A data frame of journal definitions.

## Examples

``` r
# Show all available journals
search_journals()
#>    publisher                                  journal page_width
#> 1   Elsevier                                     Cell        174
#> 2   Elsevier                              Rhizosphere        180
#> 3  Frontiers       Frontiers in Ecology and Evolution        175
#> 4     Nature                                   Nature        183
#> 5       PLOS                                 PLOS One        190
#> 6      Wiley                    Global Change Biology        178
#> 7  Wiley/ESA                  Ecological Applications        178
#> 8  Wiley/ESA                    Ecological Monographs        178
#> 9  Wiley/ESA                                  Ecology        178
#> 10 Wiley/ESA                                Ecosphere        178
#> 11 Wiley/ESA Frontiers in Ecology and the Environment        178
#> 12 Wiley/NSO                                    Oikos        178
#>    page_height ncol col_margin
#> 1          230    2       5.00
#> 2          240    2      10.00
#> 3          240    2       5.00
#> 4          170    2       5.00
#> 5          210    2      10.00
#> 6          240    2       6.00
#> 7          242    2       6.00
#> 8          242    2       6.00
#> 9          242    2       6.00
#> 10         242    2       6.00
#> 11         242    2       6.00
#> 12         231    2       4.66

# Search by Journal Name
search_journals("comms")
#> No journals found matching 'comms'.

# Search by Publisher
search_journals("Elsevier")
#>   publisher     journal page_width page_height ncol col_margin
#> 1  Elsevier        Cell        174         230    2          5
#> 2  Elsevier Rhizosphere        180         240    2         10
```
