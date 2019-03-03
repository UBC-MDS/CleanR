# This script tests the summary() function
context("Summary_r function")
library(CleanR)

toy_data_tbl <- tribble(
  ~x, ~y,
  NA, 2,
  "b", 1.5,
  "c", NA
)
toy_data_df <- as.data.frame(toy_data_tbl)
toy_all_na <- tibble(x = c(NA,NA,NA), y = c(NA,NA,NA), z = c(NA, NA, NA))
toy_no_na <- tibble(x = c(1,2,3,4), y = c(5,6,7,8))
toy_categorical <- tibble(x= c(1,2))
test_that("Test that input is a data frame", {
  expect_error(summary_r("Input Data"), "Input data type is not of class data.frame.")
})

test_that("Test that the dataframe is not empty", {
  empty_df <- data.frame()
  expect_error(summary_r(empty_df), "Cannot summarize a dataframe without observations")
    })

test_that("Test that the results for numerical and categorical data make sense", {
  toy_data_results <- list("x"= list("count"       =   3,
                                     "count_unique"=   3,
                                     "unique"      =   c(NA, "b", "c"),
                                     "count_NAs"   =   1),
                           "y" = list("count"       =   3,
                                      "count_unique"=   3,
                                      "unique"      =   c(2.0, 1.5, NA),
                                      "count_NAs"   =   1,
                                      "min_"        =   1.5,
                                      "max_"        =   2,
                                      "mean"        =   1.75,
                                      "median"      =   1.75))

  expect_equal(summary_r(toy_data_df), toy_data_results)
})
