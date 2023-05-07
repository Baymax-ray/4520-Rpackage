#'Interpolate storm tracks with 30min interval
#'
#'A function for interpolating a storm track to 30 minute increments.
#'Only longitude and latitude will be filled with interpolated value.
#'Other columns will be filled with the same value in the preceding row
#'
#'@param df the data frame to be modified
#'@return the interpolated data frame
#'@examples
#'new_df <- interpolate_storm_track_30m(storm_data)
#'head(new_df)
#'@export
interpolate_storm_track_30m <- function(storm_data) {

  # Get the unique storm ids
  unique_storm_ids <- unique(storm_data$id)

  # Initialize an empty data frame to store the interpolated data
  interpolated_data <- data.frame()

  # Loop through the unique storm ids
  for (storm_id in unique_storm_ids) {
    # Subset the data for the current storm
    storm_subset <- storm_data[storm_data$id == storm_id, ]

    # Convert date and time to POSIXct
    storm_subset$datetime <- as.POSIXct(paste(storm_subset$date, storm_subset$time), format = "%Y%m%d %H%M")

    # Initialize an empty data frame for the current storm's interpolated data
    current_interpolated_data <- data.frame()

    # Loop through the storm_subset data frame row by row
    for (i in 1:(nrow(storm_subset) - 1)) {
      if (nrow(storm_subset)<=1){
        break
      }
      if (storm_subset$datetime[i + 1] <= storm_subset$datetime[i]) {
        next
      }
      # Create a sequence of datetimes at 30-minute intervals between current and next row
      datetime_seq <- seq(from = storm_subset$datetime[i], to = storm_subset$datetime[i + 1], by = "30 min")
      if(datetime_seq[length(datetime_seq)]==storm_subset$datetime[i+1]){
        datetime_seq<-datetime_seq[-length(datetime_seq)]}#remove the last element
      # Initialize an empty data frame for the current segment's interpolated data
      segment_interpolated_data <- data.frame(id = storm_id, datetime = datetime_seq)

      # Loop through each column in the storm_subset data frame
      for (column_name in colnames(storm_subset)) {
        # Skip the 'id', and 'datetime' columns
        if (column_name %in% c("id", "datetime")) {
          next
        }
        else if (column_name %in% c("latitude", "longitude")){
          # Interpolate the 'latitude' and 'longitude'
          interpolated_values <- approx(storm_subset$datetime[i:(i + 1)], storm_subset[[column_name]][i:(i + 1)], datetime_seq)$y
        }
        #from datetime_seq extract time and date
        else if (column_name == "time") {
          interpolated_values <- strptime(datetime_seq, "%H%M")
        }
        else if (column_name == "date") {
          interpolated_values <- strftime(datetime_seq, "%Y%m%d")
        }
        else{
          # for other columns, fill with the same value
          interpolated_values <- rep(storm_subset[[column_name]][i], length(datetime_seq))
        }

        # Add the interpolated values to the current segment's interpolated data frame
        segment_interpolated_data[[column_name]] <- interpolated_values
      }

      # Append the interpolated data for the current segment to the current storm's interpolated data frame
      current_interpolated_data <- rbind(current_interpolated_data, segment_interpolated_data)
    }

    # Append the interpolated data for the current storm to the final data frame
    interpolated_data <- rbind(interpolated_data, current_interpolated_data)
  }
  interpolated_data$datetime<-NULL
  # Return the interpolated data
  return(interpolated_data)
}
