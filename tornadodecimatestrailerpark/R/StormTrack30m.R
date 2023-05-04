#'Interpolate storm tracks with 30min interval
#'
#'A function for interpolating a storm track to 30 minute increments.
#'Non-numeric columns are filled with NA
#'Return the modified data frame.
#'
#'@param df the data frame to be modified
#'@return the interpolated data frame
#'@example
#'data_path <- system.file("data", "my_data.RData", package = "tornadodecimatestrailerpark")
#'load(data_path)
#'new_df<-Interpolate30m(data)
#'head(new_df)
#'@export
Interpolate30m<-function(storm_data){
  unique_storm<- unique(storm_data$id)
  interpolated_data <- data.frame()
  for (storm_id in unique_storms){
    storm_subset <- storm_data[storm_data$id == storm_id, ]
    storm_subset$datetime <- as.POSIXct(paste(storm_subset$date, storm_subset$time), format = "%Y%m%d %H%M")
    min_datetime <- min(storm_subset$datetime)
    max_datetime <- max(storm_subset$datetime)
    datetime_seq <- seq(from = min_datetime, to = max_datetime, by = "30 min")
    storm_name<-storm_subset$name[1]
    current_interpolated_data <- data.frame(id = storm_id, name=storm_name,datetime = datetime_seq)
    for (column_name in colnames(storm_subset)) {
      # Skip the 'name', 'date', 'time', and 'datetime' columns
      if (column_name %in% c("name", "date", "time", "datetime","id")) {
        next
      }
      # Check if the column is numeric
      if (is.numeric(storm_subset[[column_name]])) {
        # Interpolate the numeric column
        interpolated_values <- approx(storm_subset$datetime, storm_subset[[column_name]], datetime_seq)$y
      } else {
        # Fill non-numeric columns with NA
        interpolated_values <- rep(NA, length(datetime_seq))
      }
      # Add the interpolated values to the current storm's interpolated data frame
      current_interpolated_data[[column_name]] <- interpolated_values
    }
    # Append the interpolated data for the current storm to the final data frame
    interpolated_data <- rbind(interpolated_data, current_interpolated_data)
  }
  # Return the interpolated data
  return(interpolated_data)
}
