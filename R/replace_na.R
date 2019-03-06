library(dplyr)
library(stats)
#' Replace NAs
#'
#' @description
#' This function replaces na values with either the min, max,
#' median or average value or removes the rows.
#'
#' @param data (tbl_df, df, data.frame) dataframe that the function will use to replace NAs
#' @param columns (vector or list) columns that specify which column to replace
#' @param replace (character) the method to replace missing values with
#' @param remove (logical) set TRUE to remove missing value rows
#'
#' @return
#' A list of tuples where each NAs will be replaced by either
#' min, max, median or average.
#' @importFrom stats median na.omit
#' @importFrom dplyr mutate_at vars funs
#' @export
replace_na <- function(data, columns, replace="mean", remove=FALSE) {
  if (!is.logical(remove)) {
    stop("Argument remove should be logical.")
  }
  if (!(replace %in% c("mean", "min", "max", "median"))) {
    stop("Argument replace is not one of 'mean', 'min', 'max', or 'median'")
  }
  if (remove == TRUE) {
    return(na.omit(data))
  }
  # check if data is a dataframe or tibble
  if (!('data.frame' %in% class(data))) {
    stop("Input data type is not of class data.frame.")
  }
  for (i in columns) {
    vec <- get(i, data)
    if (!any(is.na(vec) == FALSE)) {
      stop("Cannot perform function when all values are missing.")
    } else if (!is.numeric(vec)) {
      stop("The column or columns you have inputted are not numeric.")
    }

    if (replace=="mean") {
      mean <- mean(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), mean)))
    } else if (replace == "min") {
      min <- min(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), min)))
    } else if (replace == "max") {
      max <- max(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), max)))
    } else if (replace == "median") {
      median <- median(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), median)))
    }
  }
  return(data)
}
