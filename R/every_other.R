#' Select every other (nth) element from a vector
#'
#' @param x Vector to select (remove) elements from
#' @param n Numeric value for the number of elements to skip. Default is 2, i.e. skips every second element
#' @param start Numeric value to indicate which element of the vector to commence from.
#' @param fill Character string to be used in place of skipped element. By default is `NULL` and hence skipped elements are removed rather than replaced.
#'
#' @return Vector with elements removed
#' @export
#'
#' @examples
#' every_other(x = letters)
#' every_other(LETTERS, n = 3, start = 6)
#' every_other(x = letters, fill = "")
every_other <- function(x, n = 2, start = 1, fill = NULL){
  nn <- length(x)
  x0 <- x[seq(from = start, to = nn, by = n)]
  if(!is.null(fill)){
    x1 <- x
    x1[!x1 %in% x0] <- fill
    x0 <- x1
  }
  return(x0)
}
