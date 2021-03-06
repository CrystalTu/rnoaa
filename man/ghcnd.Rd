% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ghcnd.R
\name{ghcnd}
\alias{ghcnd}
\alias{ghcnd_countries}
\alias{ghcnd_search}
\alias{ghcnd_splitvars}
\alias{ghcnd_states}
\alias{ghcnd_stations}
\alias{ghcnd_version}
\title{Get GHCND daily data from NOAA FTP server}
\usage{
ghcnd(stationid, path = "~/.rnoaa/ghcnd", overwrite = TRUE, ...)

ghcnd_search(stationid, date_min = NULL, date_max = NULL, var = "all",
  path = "~/.rnoaa/ghcnd", overwrite = TRUE, ...)

ghcnd_splitvars(x)

ghcnd_stations(..., n = 10)

ghcnd_states(...)

ghcnd_countries(...)

ghcnd_version(...)
}
\arguments{
\item{stationid}{Stationid to get}

\item{path}{(character) A path to store the files, Default: \code{~/.rnoaa/isd}}

\item{overwrite}{(logical) To overwrite the path to store files in or not, Default: TRUE.}

\item{...}{Curl options passed on to \code{\link[httr]{GET}}}

\item{date_min,date_max}{(character) Minimum and maximum dates. Use together to get a
date range}

\item{var}{(character) Variable to get, defaults to "all", which gives back all variables
in a list. To see what variables are available for a dataset, look at the dataset returned
from \code{ghcnd()}.}

\item{x}{Input object to print methods. For \code{ghcnd_splitvars()}, the output of a call
to \code{ghcnd()}.}

\item{n}{Number of rows to print}
}
\description{
Get GHCND daily data from NOAA FTP server
}
\examples{
\dontrun{
# Get metadata
ghcnd_states()
ghcnd_countries()
ghcnd_version()

# Get stations, ghcnd-stations and ghcnd-inventory merged
(stations <- ghcnd_stations())

# Get data
ghcnd(stationid="AGE00147704")
ghcnd(stations$data$id[40])
ghcnd(stations$data$id[4000])
ghcnd(stations$data$id[10000])
ghcnd(stations$data$id[80000])
ghcnd(stations$data$id[80300])

library("dplyr")
ghcnd(stations$data$id[80300])$data \%>\% select(id, element) \%>\% head

# manipulate data
## using built in fxns
dat <- ghcnd(stationid="AGE00147704")
(alldat <- ghcnd_splitvars(dat))
library("ggplot2")
ggplot(subset(alldat$tmax, tmax >= 0), aes(date, tmax)) + geom_point()

## using dplyr
library("dplyr")
dat <- ghcnd(stationid="AGE00147704")
dat$data \%>\%
 filter(element == "PRCP", year == 1909)

# Search based on variable and/or date
ghcnd_search("AGE00147704", var = "PRCP")
ghcnd_search("AGE00147704", var = "PRCP", date_min = "1920-01-01")
ghcnd_search("AGE00147704", var = "PRCP", date_max = "1915-01-01")
ghcnd_search("AGE00147704", var = "PRCP", date_min = "1920-01-01", date_max = "1925-01-01")
ghcnd_search("AGE00147704", date_min = "1920-01-01", date_max = "1925-01-01")
ghcnd_search("AGE00147704", var = c("PRCP","TMIN"))
ghcnd_search("AGE00147704", var = c("PRCP","TMIN"), date_min = "1920-01-01")
ghcnd_search("AGE00147704", var="adfdf")
}
}

