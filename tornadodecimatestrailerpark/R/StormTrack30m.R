#'Interpolate storm tracks with 30min interval
#'
#'A function for interpolating a storm track to 30 minute increments.
#'If one side is NA, the added value will also be NA.
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
    storm_subset$datetime <- as.POSIXct(paste(storm_subset$date, storm_subset$time), format = format = "%Y%m%d %H%M")
    min_datetime <- min(storm_subset$datetime)
    max_datetime <- max(storm_subset$datetime)
    datetime_seq <- seq(from = min_datetime, to = max_datetime, by = "30 min")

  }

}
