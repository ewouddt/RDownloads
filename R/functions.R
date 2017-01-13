
########################################
## GENERAL PACKAGE DOCUMENTATION PAGE ##
########################################


#' Plotting download numbers from R Studio CRAN Mirror
#'
#' MyFirstPackage is a test package which includes a function to plot the download numbers from the R Studio CRAN Mirror.
#' 
#' @references Your submitted paper which is in revision for the last couple of months.
#'
#' @docType package
#' @name MyFirstPackage
NULL


########################################
## IMPORTING OTHER PACKAGES/FUNCTIONS ##
########################################


#' @import ggplot2
#' @importFrom cranlogs cran_downloads
NULL

##################
## EXAMPLE DATA ##
##################
#' @title Tidyverse Plots
#'
#' @description A \code{.RData} object which contains a couple of download plots of some packages of the Hadley Tidyverse.
#'
#' @format A list with 4 ggplot objects.
#' @source R script in \code{doc/} folder
#' @name TidyVerse_gplots
NULL

###################
## MAIN FUNCTION ##
###################

#' @export
#' @title Plotting R Package Downloads by month or day.
#' @description This functions creates a ggplot2 graph of the number of downloads of a chosen package from the R Studio CRAN mirror. 
#' The graph can be by month or by day.
#' @param PackageName Name of the package.
#' @param from Start date, in \code{yyyy-mm-dd} format.
#' @param to End date, in \code{yyyy-mm-dd} format.
#' @param by Plot downloads by \code{"day"} or \code{"month"}. It is advised to only use \code{"day"} for shorter periods of time to 
#' avoid too much clutter.
#' @details When plotting by day, each month/year combination is assigned a different colour.
#' @return A \code{\link{ggplot2}} object based on the parameter settings.
#' @author Ewoud De Troyer
#' @examples
#' \dontrun{
#' plotDownloads("ggplot2",from="2015-01-01",to="2016-11-30")
#' plotDOwnloads("ggplot2",from="2016-04-01",to="2016-11-30",by="day")
#' }
#' @references Not really.
plotDownloads <- function(PackageName="ggplot2",from="2016-04-01",to="2016-11-30",by="month"){
  
  if(!(by %in% c("day","month"))){stop("by parameter should be either \"day\" or \"month\"")}
  
  x <- cran_downloads(packages=PackageName,from=from,to=to)
  gplot <- plot_cranlogs(x=x,from=from,to=to,by=by,name=PackageName)
  
  return(gplot)
}

