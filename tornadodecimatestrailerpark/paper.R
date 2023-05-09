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


