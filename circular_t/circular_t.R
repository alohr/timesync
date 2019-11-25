library(readr)
library(purrr)
library(dplyr)
library(ggplot2)

nmilist <- c(
  'dtag',
  'ptb',
  'npl',
  'roa',
  'nist',
  'usno',
  'vsl',
  'estc',
  'op'
)

read_circular_t <- function(k) {
  url <- sprintf('ftp://ftp2.bipm.org/pub/tai/publication/utclab/utc-%s', k)
  
  dplyr::mutate(
    readr::read_table(
      url,
      col_names = c('mjd', 'utcdiff'),
      skip = 2,
      na = '-'
    ),
    k = k
  )
}

read_circular_t_list <- function(nmilist) {
  nmilist %>%
    purrr::map(read_circular_t) %>%
    purrr::reduce(rbind)
}

plot_circular_t <- function(d) {
  ggplot(d, aes(mjd, utcdiff, color=k)) +
    geom_line()
  
}