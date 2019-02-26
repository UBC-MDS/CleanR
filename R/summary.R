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


summary <- function(data) {
  
  # check if data is a dataframe or tibble
  if (!('data.frame' %in% class(data))) {
    stop("Input data type is not of class data.frame.")
  }
  # check if data is all NA
  if (!any(is.na(data) == FALSE)) {
    warning("All values are missing.")
  }
  
  # check dimensions
  if (length(dim(data)) >= 3) {
    stop("Summary is not implemented on objects with more than 2 dimensions")
  }
  #check that dataframe is not empty
  #if (length(dim(data)) == 2) & (ncol(data) == 0) {
   # stop("Cannot describe a column_dataFrame without columns")
  }
  
  
  #find data type in each column of input data
  column_names = colnames(data)
  summary_df = data.frame()
  for (column in column_names) {
    #check if data type is numeric or time obj
    if ((class(titanic[[column]]) == "numeric") | (class(titanic[[column]]) == "date")) {
      # Numeric Data Column
    summary_stats <- get_numeric_stats(data[[column]])
    }
    else { # assume everything else is Categorical Data Column
    summary_stats <- get_categorical_stats(data[[column]])
    }
    summary_df[column] <- summary_stats
  
  return(summary_df)
    
  # check if data has no NA
  if (!any(is.na(data))) {count_NA = 0 }
  
  get_numeric_stats <- function(column_data) {

    stats_df <- data.frame(
      "count"       <-   length(column_data),
      "count_unique"<-   length(unique(column_data)),
      "Unique"      <-   unique(column_data),
      "count_NAs"   <-   sum(isna(column_data)), 
      "min_"        <-   min(column_data),
      "max_"        <-   max(column_data),
      "mean"        <-   mean(column_data),
      "median"      <-   median(column_data),
    )
    return(stats_df)
  }
    
  get_categorical_stats <- function(column_data){
      #find unique strings and count missing strings 
    stats_df = data.frame(
      "count"        <- length(column_data),
      "count_unique" <- length(unique(column_data)),
      "Unique"       <- unique(column_data),
      "count_NAs"    <- sum(isna(column_data))
      )             
    return(stats_df)
    }

}
