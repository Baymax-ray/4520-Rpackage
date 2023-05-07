#'Compute the accumulated cyclone energy of the storm
#'
#'A function that returns the accumulated cyclone energy of a given storm
#'
#'@param storm_data data frame of storm data
#'@param id id of the storm to calculate
#'@return Energy accumulated cyclone energy of this storm
#'@examples
#'ace= ace_of_storm(storm_data,"AL122007")
#'@export
ace_of_storm <- function(storm_data, storm_id) {
  selected_storm <- storm_data[storm_data$id %in% storm_id, ]
  wind_speed <- selected_storm$max_wind
  ace <- (10^(-4)) * sum(wind_speed^2)
  return(ace)
}
