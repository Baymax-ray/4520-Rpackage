#'Plot storm tracks of selsected storms
#'
#'A function for plotting a map of storm tracks for a selection of storms ids in a vector.
#'The map includes country and US state boundaries.
#'
#'@param storm_data the data frame to be modified
#'@param storm_ids id of the storm
#'@return NULL
#'@examples
#'plot_storm_tracks(data,c("AL122007","AL021929"))
#'@import maps
#'@export
plot_storm_tracks <- function(storm_data, storm_ids) {
  # Filter the storm data to include only the selected storm_ids
  selected_storms <- storm_data[storm_data$id %in% storm_ids, ]
  #print(length(selected_storms))
  # create error message if any of the storm_ids are not in the data
  if (length(unique(selected_storms$id)) != length(unique(storm_ids))) {
    stop("One or more of the storm ids is not in the data")
  }

  # Create a base map with country and US state boundaries
  map("world", interior = TRUE)
  map("state", add = TRUE, interior = TRUE)

  # Loop through the unique storm names in the selected storms
  for (storm_id in unique(selected_storms$id)) {
    # Subset the data for the current storm
    storm_subset <- selected_storms[selected_storms$id == storm_id, ]

    # Plot the storm track
    # with a random color but not white or black
    lines(storm_subset$longitude, storm_subset$latitude, col = sample(c(1:7, 9:15), 1), lwd = 2)
  }
}
