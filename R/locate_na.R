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

locate_na <- function(data) {
  # check if data is a dataframe or tibble
  if (!('data.frame' %in% class(data))) {
    stop("Input data type is not of class data.frame.")
  }
  # check if data is all NA
  if (!any(is.na(data) == FALSE)) {
    warning("All values are missing.")
  }
  # check if data has no NA
  if (!any(is.na(data))) {
    warning("No NAs are in the input data.")
  }
  # code to locate_na
  col_na = list()
  columns <- colnames(data)
  for (i in columns) {
    row_na = c()
    for (j in c(1:nrow(data[i]))) {
      if (is.na(data[j, i])) {
        row_na <- c(row_na, j)
      }
    }
    col_na[[i]] <- row_na
  }
  return(col_na)
}
