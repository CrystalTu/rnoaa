#' Search NOAA datasets
#' 
#' @template rnoaa
#' @return A data.frame for all datasets, or a list of length two, each with a data.frame.
#' @examples \dontrun{
#' # Get a table of all datasets
#' datasets()
#' 
#' # Get details from a particular dataset
#' datasets(dataset='ANNUAL')
#' }
#' @export
datasets <- function(dataset=NULL, startdate=NULL, enddate=NULL, page=NULL, year=NULL, month=NULL, token=getOption("noaakey", stop("you need an API key NOAA data")))
{
  url <- "http://www.ncdc.noaa.gov/cdo-services/services/datasets"
  if(!is.null(dataset))
    url <- paste(url, "/", dataset, sep="")
  args <- compact(list(startdate=startdate,enddate=enddate,page=page,year=year,month=month,token=token))
  tt <- content(GET(url, query=args))
  if(!is.null(dataset)){
    one <- data.frame(tt$dataSetCollection$dataSet[[1]][c('id','name','description','minDate','maxDate')])
    two <- ldply(tt$dataSetCollection$dataSet[[1]]$attributes$attribute, function(x) data.frame(x[c('name','defaultValue','indexNumber')]))
    list(one, two)
  } else
  {
    ldply(tt$dataSetCollection$dataSet, function(x) data.frame(x[c('id','name','description','minDate','maxDate')]))
  }
}