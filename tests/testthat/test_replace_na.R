# This script tests the replace_na() function
context("Replace NA function")
library(dplyr)
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
  expect_error(replace_na("Input Data", "x"), "Input data type is not of class data.frame.")
  expect_error(replace_na(c(1:10), "y"), "Input data type is not of class data.frame.")
  expect_error(replace_na(list(1:3), "z"), "Input data type is not of class data.frame.")
})

test_that("Test that input column are all NAs", {
  expect_error(replace_na(toy_all_na, "x"), "Cannot perform function when all values are missing.")
  expect_error(replace_na(toy_all_na, "y"), "Cannot perform function when all values are missing.")
})

test_that("Test warning if there are no missing values", {
  expect_warning(replace_na(toy_no_na, "x"), "There are no missing values.")
  expect_warning(replace_na(toy_no_na, "y"), "There are no missing values.")
})

test_that("Test warning if there are no missing values", {
  expect_error(replace_na(toy_data_tbl, "x"), "The column or columns you have inputted are not numeric.")
})

test_that("Test that the input dimension equals the output dimension", {
  expect_equal(ncol(replace_na(toy_data_tbl, "y")), ncol(toy_data_tbl))
  expect_equal(ncol(replace_na(toy_no_na, "y")), ncol(toy_no_na))
  expect_lte(nrow(replace_na(toy_data_df, "z")), nrow(toy_data_df))
  expect_lte(nrow(replace_na(toy_data_df, "z", remove=TRUE)), nrow(toy_data_df))
  expect_lte(nrow(replace_na(toy_no_na, "y")), nrow(toy_no_na))
})

test_that("Test that the input dimension equals the output dimension", {
  expect_equal(ncol(replace_na(toy_data_tbl, "y")), ncol(toy_data_tbl))
  expect_equal(ncol(replace_na(toy_no_na, "y")), ncol(toy_no_na))
  expect_lte(nrow(replace_na(toy_data_df, "z")), nrow(toy_data_df))
  expect_lte(nrow(replace_na(toy_data_df, "z", remove=TRUE)), nrow(toy_data_df))
  expect_lte(nrow(replace_na(toy_no_na, "y")), nrow(toy_no_na))
})

test_that("Test for correct functionality of the function", {
  toy_result_max <- tibble(x = c(NA,"b","c"), y = c(2,2,2), z = c(3.6, 8.5, NA))
  toy_result_min <- tibble(x = c(NA,"b","c"), y = c(2,NA,NA), z = c(3.6, 8.5, 3.6))
  toy_result_median <- tibble(x = c(NA,"b","c"), y = c(2,NA, NA), z = c(3.6, 8.5, 6.05))
  expect_equal(replace_na(toy_data_tbl, "y", replace = "max"), toy_result_max)
  expect_equal(replace_na(toy_data_tbl, "z", replace = "min"), toy_result_min)
  expect_equal(replace_na(toy_data_tbl, "z", replace = "median"), toy_result_median)
})

test_that("Test replace and remove argument", {
  expect_error(replace_na(toy_data_tbl, "y", replace=5), "Argument replace is not one of 'mean', 'min', 'max', or 'median'")
  expect_error(replace_na(toy_data_tbl, "y", replace=TRUE), "Argument replace is not one of 'mean', 'min', 'max', or 'median'")
  expect_error(replace_na(toy_data_tbl, "y", remove="hi"), "Argument remove should be logical.")
  expect_error(replace_na(toy_data_tbl, "y", remove=c(1,2,3)), "Argument remove should be logical.")
  })
