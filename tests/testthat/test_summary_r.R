# This script tests the summary() function
context("Replace NA function")
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
  expect_error(summary_r("Input Data"), "Input is not a data frame")
})


test_that("Dimensions are correct for a regular dataframe", {
  expect_error(summary_r("Input Data"), "Summary is not implemented on objects with more than 2 dimensions")
})

test_that("Test that the dataframe is not empty", {
  empty_df <- data.frame( )
  expect_error(summary_r(empty_df), "Cannot summarize a dataframe without observations")
    })

test_that("Test that the results for numerical and categorical data make sense", {
  toy_data_results <- list("x"= list("count"       =   3,
                                     "count_unique"=   3,
                                     "unique"      =   NA, "b", "c", 
                                     "count_NAs"   =   1),
                           "y" = list("count"       =   3,
                                      "count_unique"=   3,
                                      "unique"      =   2.0, 1.5, NA,
                                      "count_NAs"   =   3,
                                      "min_"        =   1.5,
                                      "max_"        =   2,
                                      "mean"        =   1.75,
                                      "median"      =   1.75))
                                
                         
                       
  expect_equal(summary_r(toy_data_df), toy_data_results)
})
