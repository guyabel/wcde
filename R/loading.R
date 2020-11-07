#' Helper function to load a .Rdata inside a function
#'
#' @description Intended for internal use.
#'
#' @param rdata_file A .Rdata file
#'
#' @return An environment
#' @source \url{https://stackoverflow.com/a/32065204/513463}
#' @export
#' @keywords internal
#'
#' @examples
#' # not run
#' # x <- 1:10
#' # y <- runif(10)
#' # save(x, y, file = "test.RData")
#' # data_env <- loading("test.RData")
#' # ls.str(data_env)
loading <- function(rdata_file){
  # rdata_file = d
  e <- new.env()
  load(rdata_file, envir = e)
  e
}
