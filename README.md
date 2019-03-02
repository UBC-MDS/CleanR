# CleanR
This package cleans a dataset and returns summary statistics as well as number, proportion and location of NA values for string and number column inputs. Data cleaning made easy!

### Collaborators
Heather Van Tassel, Phuntsok Tseten, Patrick Tung

## Overview
There is a dire need for a good data cleaning package, and we are trying to develop our version of a good data cleaning package that will help users clean their data in a meaningful way. Data cleaning is usually the first step in any data science problem, and if you don’t clean your data well, it might be really difficult to proceed further. So our motivation for coming up with this idea was to address this very issue of messy data.

CleanR is especially developed to create a streamlined process to give you an easy to read summary statistics table about your data. CleanR is able to easily locate all the missing data for you and allow you to locate where exactly it occurs. Not only are you able to locate missing data, you can also define how you would like to deal with your missing data. 

## Functions
**Function 1)**`summary_r`: Summary statistics generator for string and numeric data for each column in a given dataframes.
```
#' Summary
#' 
#' @description
#'
#'    This function computes summary statistics for text and numerical column_data from a given column_dataframe.
#'    Input: dictionary or column_dataframe
#'    Returns summary statistics for each column in a nested dataframe. Since dataframes only accept one data type per column, 
#'    we only need to test the type of each column once.
#'    It will perform two different summary statistics based on 2 column_datatypes of either
#'    1) string/bool or 2) int/float/datetime object. For numeric data columns it returns a dictionary of summary statistics#'
#'    including mean value for each column, min, max, mean, median and count (number of non NA values per column) and count_NA
#'    (number of NA values per column). Similarly, for string columns it returns the unique string values and
#'    their counts in a dictionary. The column summary statistics are then nested into a pandas dataframe and returned.
#' @param data (tbl_df, df, data.frame) dataframe that the function will use    
    
#' @Returns
#' Summary dataframe of each column's summary statistics
#'    >>> summary_r(dataFrame("Likes coding"= c(1,0,1)))
#'    Data.Frame(
#'        min= 0
#'        max= 1
#'        mean= 2/3
#'        median= 1
#'        unique= 0, 1
#'        count= 3
#'        count_NA= 0)
#' @export
#' summary <- function(data) {

}
```

**Function 2)** `locate_na`: Returns a list of the count and indices of NA values.  This function takes in a dataframe and finds NA values and returns the location of these missing values.

```
#' Locate NAs
#'
#' @description
#' Locate and return the indices to all missing values within an inputted dataframe.
#' Each element of the returned list will be a column in a dataframe, which will hold
#' the row indices of the missing values.
#'
#' @param data (tbl_df, df, data.frame) dataframe that the function will use to locate NAs
#'
#' @return a list containing indices of missing values
#' @export
```

**Function 3)**`replace_na`:Replaces missing NA values with either min, max, median, or average (default) values of the column(s). There will be an option to remove the rows with NAs.
```
#' Replace NA
#' 
#' @description
#' This function replaces na values with either the min, max, #'median or average value or removes the rows.

#' @param input_df dataframe, dataframe that the  function #'will use to replace NAs.

#' @returns
#' A list of tuples where each NAs will be replaced by either #'min, max, median or average.
#' Each tuple in the list represents  the indices of a NA in #'the dataframe. 
   
#' @exports
#' replace_na<- input_df %>% 
        group_by(input_df) %>% 
        summarize(input_df)
```

## CleanR and R's Ecosystem

Sometimes it can get quite annoying dealing with data, so it is always nice to get some information about a quick summary of the data. A similar function in R that is implemented is the `summary_r()` function. CleanR's `summary_r()` function is very similar in the sense that it also produces summary statistics, but presented in a much more intuitive manner. Our `summary_r()` function also has more information such as the number of missing values, as well as provide summaries of text information. In regards to our `locate_na()` and `replace_na()`, there is no similar function created in the current R ecosystem that we know of. The only way to do this is to mannually combine a few functions including `is.na()`.

## Installation

To install `CleanR`, please follow these instructions:

1. First, check if `devtools` is installed and loaded into the environment. Install `devtools` with `install.packages("devtools")` and load it into the environment with `library(devtools)`.

2. Then input the following code into the console
``` r
devtools::install_github("UBC-MDS/CleanR")
library(CleanR)
```

## Usage
Let's assume that you have a tibble or dataframe like the following:
```{r}
toy_data_tbl <- tribble(
  ~x, ~y,  ~z,
  NA, 2,  3.6,
  "b", NA, 8.5,
  "c", NA, NA
)
```
1. `summary_r`
Arguments: 
    - `data`: dataframe or tibble that the function will provide summary statistics on
    - Example: `summary_r(toy_data_tbl)`
  
2. `locate_na`
Arguments:
    - `data`: dataframe or tibble that the function will use to locate NAs
    - Example: `locate_na(toy_data_tbl)`

3. `replace_na`
Arguments:
    - 
    - Example: 

## R Dependencies
- `broom` package
