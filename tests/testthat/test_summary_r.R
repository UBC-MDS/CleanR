# This script tests the summary() function
context("Replace NA function")
library(CleanR)

toy_data_tbl <- tribble(
  ~x, ~y,  ~z,
  NA, 2,  3.6,
  "b", NA, 8.5,
  "c", NA, NA
)
toy_data_df <- as.data.frame(toy_data_tbl)
toy_all_na <- tibble(x = c(NA,NA,NA), y = c(NA,NA,NA), z = c(NA, NA, NA))
toy_no_na <- tibble(x = c(1,2,3,4), y = c(5,6,7,8))
toy_same_dim <- tibble(x = c(3,4), y = c(5,6))

test_that("Test that input is a data frame", {
  expect_error(summary("Input Data"), "Input is not a data frame")
})

test_that("Test that input has NA", {
  all_na_result <- list(x=c(1,2,3), y=c(1,2,3), z=c(1,2,3))

  expect_warning(summary(toy_all_na), "There are no missing values")

})


test_that("Test that the input dimension equals the output dimension", {
  same_dim_result <- list(x=c(0), y=c(0))

  expect_warning(summary(toy_same_dim), "The dimensions don't match")
})
