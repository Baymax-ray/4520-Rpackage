#scratch paper
lon=-94.8
lat=28
devtools::load_all()
devtools::test()
devtools::document()
load("~/4520-Rpackage/tornadodecimatestrailerpark/data/hurdat.RData")
interpolate_storm_track_30m(data[1:100,])
plot_storm_tracks(data,c("AL122007","AL021929"))
plot_storm_size(data, 44703)
plot_storm_size(data, 30480)
storm_US_landfall(data,"AL122007")
ace_of_storm(data,"AL122007")
?interpolate_storm_track_30m

# unique storm ids
unique_storm_data <- data[!duplicated(data$id),]
# Assuming storm_data is already loaded and storm_US_landfall() function is defined
unique_storm_data$us_landfall <- sapply(unique_storm_data$id, storm_US_landfall,storm_data = data)
# get the year of each storm
unique_storm_data$unique_year <- as.numeric(substr(unique_storm_data$date, 1, 4))
# aggregate the number of landfalls per year
landfall_per_year <- aggregate(us_landfall ~ unique_year, data=unique_storm_data,sum)
# train a linear model
model <- lm(us_landfall ~ unique_year, data = landfall_per_year)
summary(model)

# I define a landfalling hurricane as one that makes landfall in the continental United States.
# I set the time period to be one year. If a hurricane that makes landfall in the US exists for more than one year, it counts for the first year.
# No matter how many times a hurricane makes landfall in the US, it is counted as one landfalling hurricane as long as its id is the same.
# I use a linear model to fit the number of landfalling hurricanes per year. The model is: number of landfalling hurricanes = b0 + b1 * year, where b0 is the intercept, and b1 is the coefficient of the year variable.
# The estimated coefficient of year is 0.010311 with a p-value of 0.000465. Although it is small, its p-value is statistically significant (p < 0.05). So the number of landfalling hurricanes is increasing over time.


# only data with status=HU/TS/TD
tropical_cyclones <- data[data$status %in% c("HU","TS","TD"),]
a<-data$status[1]
b<-data[grepl("HU"),data$status]






storm_row <- data[44703, ]


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
p <- ggplot2::ggplot() + ggplot2::geom_polygon(data = world_map, ggplot2::aes(x = long, y = lat, group = group), fill = "lightgrey", color = "black") +
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

