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
#'new_df<-Interpolate30m(hurdat)
#'head(new_df)
#'@export
Interpolate30m<-function(df){

}
