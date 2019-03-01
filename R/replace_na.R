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

replace_na <- function(data) {

  if (!any(is.na(data))) {
    return ("Input must not all me missing values")


      # mean
  mean_na = list()
      for (i in 1:ncol(data)) {
        data[is.na(data[,i]), i] <- mean(data[,1], na.rm = TRUE)
      }
      return(mean_na)
    }

    # min
  min_na = list()
    for (i in 1:ncol(data)) {
      data[is.na(data[,i]), i] <- mean(data[,1], na.rm = TRUE)
    }
    return(min_na)
  }

  #  median

  median_na = list()
    for (i in 1:ncol(data)) {
    data[is.na(data[,i]), i] <- with(
      median(data[,2], na.rm = TRUE))
  }
  return(median_na)
}

# max

 max_na = list()
   for (i in 1:ncol(data)) {
  data[is.na(data[,i]), i] <- with(
    max(data[,2], na.rm = TRUE))
}
return(max_na)
}

