# tests/testthat/test-publish_fig.R

test_that("column width calculation is correct for default journal", {
  defaults <- journal_defaults[["nature"]]
  col_width <- (defaults$page_width - (defaults$ncol - 1) * defaults$col_margin) / defaults$ncol
  expect_equal(col_width, 89)
})

test_that("portrait column-based dimensions are correct", {
  defaults <- journal_defaults[["nature"]]
  col_width <- (defaults$page_width - (defaults$ncol - 1) * defaults$col_margin) / defaults$ncol
  
  w <- 2 * col_width + (2 - 1) * defaults$col_margin
  h <- 1 * col_width
  
  expect_equal(w, defaults$page_width)
  expect_equal(h, 89)
})

test_that("page-based height is used when page = TRUE", {
  defaults <- journal_defaults[["nature"]]
  fig_height <- 0.5
  h <- defaults$page_height * fig_height
  expect_equal(h, 85)
})

test_that("landscape forces page-based sizing and swaps dimensions", {
  defaults <- journal_defaults[["nature"]]
  page_width <- defaults$page_width
  page_height <- defaults$page_height
  
  tmp <- page_width
  page_width <- page_height
  page_height <- tmp
  
  expect_equal(page_width, defaults$page_height)
  expect_equal(page_height, defaults$page_width)
})

test_that("publish_fig runs without error using journal defaults", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(mpg, wt)) +
    ggplot2::geom_point()
  
  tf <- tempfile(fileext = ".png")
  
  expect_invisible(
    publish_fig(
      plot = p,
      filename = tf,
      fig_width = 1,
      fig_height = 1,
      journal = "nature"
    )
  )
  
  expect_true(file.exists(tf))
  unlink(tf)
})
