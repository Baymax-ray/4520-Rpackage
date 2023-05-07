
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
#'     \item{record_identifier}{record identifier,options are: C,G,I,L,P,R,S,T,W}
#'     \item{status}{status of system, options are: TD,TS,HU,EX,SD,SS,LO,WV,DB}
#'     \item{latitude}{latitude of hurricane, in decimal degrees north}
#'     \item{longitude}{longitude of hurricane, in decimal degrees east}
#'     \item{max_wind}{maximum sustained wind, in knots}
#'     \item{min_pressure}{minimum pressure, in millibars}
#'     \item{34_wind_radii_northeastern}{34 kt wind radii maximum extent in northeastern quadrant (in nautical miles)}
#'     \item{34_wind_radii_southeastern}{34 kt wind radii maximum extent in southeastern quadrant (in nautical miles)}
#'     \item{34_wind_radii_southwestern}{34 kt wind radii maximum extent in southwestern quadrant (in nautical miles)}
#'     \item{34_wind_radii_northwestern}{34 kt wind radii maximum extent in northwestern quadrant (in nautical miles)}
#'     \item{50_wind_radii_northeastern}{50 kt wind radii maximum extent in northeastern quadrant (in nautical miles)}
#'     \item{50_wind_radii_southeastern}{50 kt wind radii maximum extent in southeastern quadrant (in nautical miles)}
#'     \item{50_wind_radii_southwestern}{50 kt wind radii maximum extent in southwestern quadrant (in nautical miles)}
#'     \item{50_wind_radii_northwestern}{50 kt wind radii maximum extent in northwestern quadrant (in nautical miles)}
#'     \item{64_wind_radii_northeastern}{64 kt wind radii maximum extent in northeastern quadrant (in nautical miles)}
#'     \item{64_wind_radii_southeastern}{64 kt wind radii maximum extent in southeastern quadrant (in nautical miles)}
#'     \item{64_wind_radii_southwestern}{64 kt wind radii maximum extent in southwestern quadrant (in nautical miles)}
#'     \item{64_wind_radii_northwestern}{64 kt wind radii maximum extent in northwestern quadrant (in nautical miles)}
#'     \item{radius_max_wind}{radius of Maximum Wind (in nautical miles)}
#' }
"data"
