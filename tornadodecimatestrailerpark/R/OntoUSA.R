#'If the storm landed on USA
#'
#'A function for determining whether the storm made landfall in the continental United States
#'Note:continental US includes Alaska(?), but excludes Hawaii and the U.S. territories such as Puerto Rico and the U.S. Virgin Islands.
#'No use of the unreliable record identifier variable for this part.
#'Return true if it landed in the continental United States, false otherwise.
#'
#'@param storm_data data frame of storm data
#'@param storm_id id of this storm
#'@return true or false
#'@examples
#'IfLandfall<-storm_US_landfall(data,"AL122007")
#'@import maps
#'@import sp
#'@export
storm_US_landfall <- function(storm_data,storm_id) {
  # Extract the data
  storm_subset <- storm_data[storm_data$id == storm_id, ]

  # Get US boundaries from the maps package
  us_map <- map("state", plot = FALSE)

  # Convert the US boundaries to a data frame
  us_boundary <- data.frame(x = us_map$x, y = us_map$y)

  # Loop through each row of the storm_subset data frame
  for (i in 1:nrow(storm_subset)) {
    latitude <- storm_subset$latitude[i]
    longitude <- storm_subset$longitude[i]

    # Check if the storm's latitude and longitude are within the US boundaries
    in_us <- point.in.polygon(point.x = longitude, point.y = latitude, pol.x = us_boundary$x, pol.y = us_boundary$y)
    # If the storm made landfall in the continental US, return TRUE
    if (in_us == 1) {
      return(TRUE)
    }
  }
  # If the loop completes without finding a landfall, return FALSE
  return(FALSE)
}
