#' Atlantic Hurricane Database
#'
#' A dataset with the information of all the Atlantic hurricane since 1851.This report updates the original HURDAT documentation to
#' reflect significant changes since 2012 to both the format and content for the tropical cyclones and subtropical cyclones of the Atlantic basin.
#'
#' @format a dataframe with 53872 rows and 23 columns
#' \describe{
#'     \item{id}{id of the hurricane}
#'     \item{name}{name of the hurricane,before 1950 referred to as “UNNAMED” }
#'     \item{date}{year, month, day of the hurricane}
#'     \item{time}{hours in UTC, minutes of the hurricane}
#'     \item{record_identifier}{}
#'     \item{latitude}{latitude of hurricane, in decimal degrees north}
#'     \item{longitude}{longitude of hurricane, in decimal degrees east}
#' }
"hurdat"
