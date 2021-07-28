#' Title
#'
#' @param indicator Character string based on the `indicator` column in the `wpp_bulk` data frame, representing the bulk file to be downloaded.
#' @param variant Character string based on the `variant` column in the `wpp_bulk` data frame, representing the bulk file to be downloaded.
#'
#' @return
#' @export
#'
#' @examples
get_undesa_wpp <- function(indicator = "pop", variant = "all"){
  read_with_progress <- function(f){
    pb$tick()
    readr::read_csv(f, col_types = readr::cols(), guess_max = 1e5)
  }
  d <- NULL
  d <- wpp_bulk %>%
    dplyr::filter(indicator == indicator)
  if(var != "all")
    d <- dplyr::filter(d, variant == variant)
  dd <- NULL
  pb <- progress::progress_bar$new(total = 30)
  # print("Downloading bulk file from UN DESA...")
  pb$tick(0)
  dd <- d %>%
    dplyr::mutate(d = purrr::map(.x = url, .f = ~read_with_progress(f = .x)))
  pb$terminate()
  # print("... Download complete.")
  dd %>%
    dplyr::select(d) %>%
    tidyr::unnest(cols = d)
}
# x <- get_undesa_wpp(indicator = "fertility")
# x %>%
#   filter(Location == "Italy",
#          Time %in% seq(1970, 2000, 5))
