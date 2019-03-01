#' Summary
#'
#' @description
#' It will determine the main data type of the column by calculated the type
#' of each row entry in the column, and using the most frequent data type as
#' the expected input for that column. It will perform two different summary
#' statistics based on 2 different groups of datatypes of either 1) string or
#' 2) int/float. For number columns it returns a dataframe of columns which
#' contain dataframes of summary statistics including mean value for each column,
#' min, max, count (number of non NA values per column) and count_NA (number of
#' NA values per column). Similarly, for string columns it returns the unique
#' string values and their counts. It will also provide a count of NA values
#' which will include empty strings, and anything other than the correct data
#' type for each column.
#'
#' @param data (tbl_df, df, data.frame) dataframe that the function will use to locate NAs
#'
#' @return a nested dataframe of columns with their summary statistics
#' @export
get_numeric_stats <- function(column_data) {
  stats_df <- list(
    "count"       =   length(column_data),
    "count_unique"=   length(unique(column_data)),
    "unique"      =   unique(column_data),
    "count_NAs"   =   sum(is.na(column_data)),
    "min_"        =   min(column_data, na.rm = T),
    "max_"        =   max(column_data, na.rm = T),
    "mean"        =   mean(column_data, na.rm = T),
    "median"      =   median(column_data, na.rm = T)
  )
  return(stats_df)
}

get_categorical_stats <- function(column_data){
  # find unique strings and count missing strings
  stats_df = list(
    "count"        <- length(column_data),
    "count_unique" <- length(unique(column_data)),
    "unique"       <- unique(column_data),
    "count_NAs"    <- sum(is.na(column_data))
  )
  return(stats_df)
}

summary_r <- function(data) {
  # check if data is a dataframe or tibble
  if (!('data.frame' %in% class(data))) {
    stop("Input data type is not of class data.frame.")
  }
  # check dimensions
  if (length(dim(data)) >= 3) {
    stop("Summary is not implemented on objects with more than 2 dimensions")
  }
  cols <- colnames(data)
  all_stats <- list()
  for (i in cols) {
    vec <- get(i, data)
    if(is.numeric(vec)) {
      stats <- get_numeric_stats(vec)
    } else if (is.character(vec)) {
      stats <- get_categorical_stats(vec)
      names(stats) <- c("count", "count_unique", "unique", "count_NAs")
    }
    all_stats <- append(all_stats, list(stats))
  }
  names(all_stats) <- cols
  return(all_stats)
}
