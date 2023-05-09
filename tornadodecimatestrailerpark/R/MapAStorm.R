#'Plot the position and size of a storm
#'
#'A function to plot a map that contains a polygon of the storm from the given row.
#'Use the 34(blue), 50(green), and 64(orange) knot extent variables to determine the polygon.
#'1 nautical mile â‰? 1/60 degrees of latitude
#'1 nautical mile â‰? 1/(60 * cos(latitude)) degrees of longitude are used for approximations.
#'
#'@param storm_data data frame of storm data
#'@param row_index row index of the storm to plot
#'@return missing points of path(0-30)
#'@examples
#'plot_storm(your_storm_data, 1)
#'@export
plot_storm <- function(storm_data, row_index) {
  # Extract the data for the specified row
  storm_row <- storm_data[row_index, ]


  # Extract storm position and extent variables
  latitude <- storm_row$latitude
  longitude <- storm_row$longitude

  # Calculate the degree in latitude for each wind radii; north is positive, south is negative
    extent_34_ne_la <- (storm_row["34_wind_radii_northeastern"][[1]]/sqrt(2))/60
    extent_34_se_la <- -1*(storm_row["34_wind_radii_southeastern"][[1]]/sqrt(2))/60
    extent_34_sw_la <- -1*(storm_row["34_wind_radii_southwestern"][[1]]/sqrt(2))/60
    extent_34_nw_la <- (storm_row["34_wind_radii_northwestern"][[1]]/sqrt(2))/60
    extent_50_ne_la <- (storm_row["50_wind_radii_northeastern"][[1]]/sqrt(2))/60
    extent_50_se_la <- -1*(storm_row["50_wind_radii_southeastern"][[1]]/sqrt(2))/60
    extent_50_sw_la <- -1*(storm_row["50_wind_radii_southwestern"][[1]]/sqrt(2))/60
    extent_50_nw_la <- (storm_row["50_wind_radii_northwestern"][[1]]/sqrt(2))/60
    extent_64_ne_la <- (storm_row["64_wind_radii_northeastern"][[1]]/sqrt(2))/60
    extent_64_se_la <- -1*(storm_row["64_wind_radii_southeastern"][[1]]/sqrt(2))/60
    extent_64_sw_la <- -1*(storm_row["64_wind_radii_southwestern"][[1]]/sqrt(2))/60
    extent_64_nw_la <- (storm_row["64_wind_radii_northwestern"][[1]]/sqrt(2))/60
 # Calculate the degree in longitude for each wind radii; east is positive, west is negative
    extent_34_ne_lo <- (storm_row["34_wind_radii_northeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_34_se_lo <- (storm_row["34_wind_radii_southeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_34_sw_lo <- -1*(storm_row["34_wind_radii_southwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_34_nw_lo <- -1*(storm_row["34_wind_radii_northwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_50_ne_lo <- (storm_row["50_wind_radii_northeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_50_se_lo <- (storm_row["50_wind_radii_southeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_50_sw_lo <- -1*(storm_row["50_wind_radii_southwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_50_nw_lo <- -1*(storm_row["50_wind_radii_northwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_64_ne_lo <- (storm_row["64_wind_radii_northeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_64_se_lo <- (storm_row["64_wind_radii_southeastern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_64_sw_lo <- -1*(storm_row["64_wind_radii_southwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
    extent_64_nw_lo <- -1*(storm_row["64_wind_radii_northwestern"][[1]]/sqrt(2))/(60*cos(latitude * pi / 180))
 # Calculate edge points
    edge_points_34 <- data.frame(latitude = c((latitude + extent_34_ne_la), (latitude + extent_34_se_la),
                                              (latitude + extent_34_sw_la), (latitude + extent_34_nw_la)),
                                 longitude = c((longitude + extent_34_ne_lo), longitude + extent_34_se_lo,
                                               longitude + extent_34_sw_lo, longitude + extent_34_nw_lo))

    edge_points_50 <- data.frame(latitude = c(latitude + extent_50_ne_la, latitude + extent_50_se_la,
                                              latitude + extent_50_sw_la, latitude + extent_50_nw_la),
                                 longitude = c(longitude + extent_50_ne_lo, longitude + extent_50_se_lo,
                                               longitude + extent_50_sw_lo, longitude + extent_50_nw_lo))

    edge_points_64 <- data.frame(latitude = c(latitude + extent_64_ne_la, latitude + extent_64_se_la,
                                              latitude + extent_64_sw_la, latitude + extent_64_nw_la),
                                 longitude = c(longitude + extent_64_ne_lo, longitude + extent_64_se_lo,
                                               longitude + extent_64_sw_lo, longitude + extent_64_nw_lo))
    # Close the paths by adding the first row to the end of each edge_points data frame
    edge_points_34 <- rbind(edge_points_34, edge_points_34[1, ])
    edge_points_50 <- rbind(edge_points_50, edge_points_50[1, ])
    edge_points_64 <- rbind(edge_points_64, edge_points_64[1, ])
  # generate map
  world_map <- ggplot2::map_data("world")
  offset<-max(extent_34_ne_la, -extent_34_se_la, -extent_34_sw_la, extent_34_nw_la,
              extent_50_ne_la, -extent_50_se_la, -extent_50_sw_la, extent_50_nw_la,
              extent_64_ne_la, -extent_64_se_la, -extent_64_sw_la, extent_64_nw_la,
              extent_34_ne_lo, extent_34_se_lo, -extent_34_sw_lo, -extent_34_nw_lo,
              extent_50_ne_lo, extent_50_se_lo, -extent_50_sw_lo, -extent_50_nw_lo,
              extent_64_ne_lo, extent_64_se_lo, -extent_64_sw_lo, -extent_64_nw_lo,10)

  # Create a ggplot object with the base map
  p <- ggplot2::ggplot() + ggplot2::geom_polygon(data = world_map, ggplot2::aes(x = longitude, y = latitude, group = group), fill = "lightgrey", color = "black") +
    ggplot2::coord_fixed(1.3, xlim = c(longitude-offset, longitude+offset), ylim = c(latitude-offset, latitude+offset)) +
    ggplot2::theme_classic()

  # Add storm position and extent path
  p <- p +
    ggplot2::geom_point(ggplot2::aes(x = longitude, y = latitude), color = "red", size = 2) +
    ggplot2::geom_path(data = edge_points_34, ggplot2::aes(x = longitude, y = latitude), color = "blue") +
    ggplot2::geom_path(data = edge_points_50, ggplot2::aes(x = longitude, y = latitude), color = "green") +
    ggplot2::geom_path(data = edge_points_64, ggplot2::aes(x = longitude, y = latitude), color = "orange")


  # Display the plot
  suppressWarnings(print(p))
  return(sum(is.na(edge_points_34)+is.na(edge_points_50)+is.na(edge_points_64)))
}


