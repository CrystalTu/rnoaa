% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/seaice.r
\name{seaice}
\alias{seaice}
\title{Get sea ice data.}
\usage{
seaice(url, ...)
}
\arguments{
\item{url}{A url for a NOAA sea ice ftp file}

\item{...}{Further arguments passed on to readshpfile function, see
\code{readshpfile}}
}
\value{
A data.frame
}
\description{
Get sea ice data.
}
\details{
If you want to reproject the shape files, use
\code{\link{readshpfile}} to read in shape file, then reproject, and so on.
}
\examples{
\dontrun{
# Look at data.frame's for a series of years for Feb, South pole
urls <- sapply(seq(1979,1990,1), function(x) seaiceeurls(yr=x, mo='Feb', pole='S'))
out <- lapply(urls, seaice)
lapply(out, head)

# Map a single year/month/pole combo
urls <- seaiceeurls(mo='Apr', pole='N', yr=1990)
out <- seaice(urls)
library('ggplot2')
ggplot(out, aes(long, lat, group=group)) +
   geom_polygon(fill="steelblue") +
   theme_ice()

# Map all years for April only for North pole
library('plyr')
library('doMC')
urls <- seaiceeurls(mo='Apr', pole='N')
registerDoMC(cores=4)
out <- llply(urls, seaice, .parallel=TRUE)
names(out) <- seq(1979,2013,1)
df <- ldply(out)
ggplot(df, aes(long, lat, group=group)) +
  geom_polygon(fill="steelblue") +
  theme_ice() +
  facet_wrap(~ .id)
}
}

