#' Wrap character string to fit a target number of lines
#'
#' Inserts line breaks for spaces, where the position of the line breaks are chosen to provide the most balanced length of each line.
#'
#' @param string Character string to be broken up
#' @param n Number of lines to break the string over
#'
#' @details Function is intended for a small number of line breaks. The \code{n} argument is not allowed to be greater than 8 as all combinations of possible line breaks are explored.
#'
#' When there a number of possible solutions that provide equally balanced number of characters in each line, the function returns the character string where the number of spaces are distributed most evenly.
#' @return The original \code{string} with line breaks inserted at optimal positions.
#' @export
#'
#' @examples
#' str_wrap_n(string = "a bb ccc dddd eeee ffffff", n = 2)
#' str_wrap_n(string = "a bb ccc dddd eeee ffffff", n = 4)
#' str_wrap_n(string = "a bb ccc dddd eeee ffffff", n = 8)
str_wrap_n <- function(string = NULL, n = 2){
  # words
  w <- stringr::str_split(string = string, pattern = " ")[[1]]

  if(n > length(w)){
    n <- length(w)
    message("Asking for more lines than words")
  }
  if(n > 8){
    stop("n is too large to look at every combination")
  }

  # breaks that minimise variance of nchar between each line
  # if tie, chose one that miniises the variance of the number of spaces in each line
  i <- dd <- s <- nn <- var_n <- var_s <- value <- words <- NULL
  b <- utils::combn(x = 2:length(w)-1, m = n - 1) %>%
    t() %>%
    as.data.frame() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(i = 1:dplyr::n()) %>%
    tidyr::pivot_longer(cols = -i) %>%
    tidyr::nest(dd = c(name, value)) %>%
    dplyr::mutate(s = purrr::map(.x = dd, .f = ~dplyr::pull(.x, value)),
                  nn = purrr::map(.x = s, .f = ~nchars_wrap(b = .x, w = w))) %>%
    tidyr::unnest_wider(col = nn) %>%
    dplyr::mutate(var_n = purrr::map_dbl(.x = n, .f = ~stats::var(x = .x)),
                  var_s = purrr::map_dbl(.x = words, .f = ~stats::var(x = .x))) %>%
    dplyr::filter(var_n == min(var_n)) %>%
    dplyr::filter(var_s == min(var_s)) %>%
    dplyr::slice(1) %>%
    dplyr::pull(s)

  f <- NULL
  for(i in 2:length(w)-1){
    bb <- " "
    if(i %in% b[[1]])
      bb <- "\n"
    f <- paste0(f, w[i], bb)
  }
  f <- paste(c(f, w[length(w)]), collapse = "")
  return(f)
}

