% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edu_group_sum.R
\name{edu_group_sum}
\alias{edu_group_sum}
\title{Education Group Sums}
\usage{
edu_group_sum(d = NULL, n = 4, strip_totals = TRUE, factor_convert = TRUE)
}
\arguments{
\item{d}{Data frame downloaded from the}

\item{n}{Number of education groups (from 4, 6 or 8)}

\item{strip_totals}{Remove total sums in \code{epop} column. Will not strip education totals if \code{year < 2015} and \code{n = 8} as past data on population size by 8 education groups is unavailable.}

\item{factor_convert}{Convert columns that are character strings to factors, with levels based on order of appearance.}
}
\value{
A tibble with the data selected.
}
\description{
Cleans \code{epop} data downloaded using the \code{wcde()} function for summations of population by 4, 6 or 8 education groups.
}
\details{
Strips the \code{epop} data set to relevant rows for the \code{n} education groups.
}
\examples{
library(tidyverse)
epop_ssp2 \%>\%
  filter(year == 2020) \%>\%
  mutate(scenario = 2) \%>\%
  edu_group_sum()
}
