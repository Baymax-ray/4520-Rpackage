#'Plot storm tracks of selsected storms
#'
#'A function for plotting a map of storm tracks for a selection of storms ids in a vector.
#'The map includes country and US state boundaries.
#'
#'@param ids id of the storm
#'@return Null
#'@examples
#'plot_storm_tracks(your_storm_data, c("storm_id_1", "storm_id_2"))
#'@export
plot_storm_tracks <- function(storm_data, storm_ids) {
  # Filter the storm data to include only the selected storm_ids
  selected_storms <- storm_data[storm_data$id %in% storm_ids, ]
  # create error message if any of the storm_ids are not in the data
  if (length(unique(selected_storms$id)) != length(storm_ids)) {
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
    lines(storm_subset$longitude, storm_subset$latitude, col = "red", lwd = 2)
  }
}
