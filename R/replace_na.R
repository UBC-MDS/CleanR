#' Replace NAs
#'
#' @description
#' This function replaces na values with either the min, max,
#' median or average value or removes the rows.
#'
#' @param
#' data (tbl_df, df, data.frame) dataframe that the function will use to locate NAs
#'
#' @return
#' A list of tuples where each NAs will be replaced by either
#' min, max, median or average.
#'
#' @export

warn <- function(vec) {
  if (!any(is.na(vec))) {
    warning("There are no missing values.")
  } else if (!any(is.na(vec) == FALSE)) {
    stop("Cannot perform function when all values are missing.")
  } else if (!is.numeric(vec)) {
    stop("The column or columns you have inputted are not numeric.")
  }
}

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
  # mean
  if (replace=="mean") {
    for (i in columns) {
      vec <- get(i, data)
      # warning function
      warn(vec)
      # replace
      mean <- mean(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), mean)))
    }
  } else if (replace == "min") { # min
    for (i in columns) {
      vec <- get(i, data)
      # warning function
      warn(vec)
      # replace
      min <- min(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), min)))
    }
  } else if (replace == "max") { # max
    for (i in columns) {
      vec <- get(i, data)
      # warning function
      warn(vec)
      # replace
      max <- max(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), max)))
    }
  } else if (replace == "median") { # median
    for (i in columns) {
      vec <- get(i, data)
      # warning function
      warn(vec)
      # replace
      median <- median(vec, na.rm = T)
      data <- mutate_at(data, vars(i), funs(replace(., is.na(.), median)))
    }
  }
  return(data)
}
