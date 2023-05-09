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
ace_of_storm(data,"AL182012")
ace_of_storm(data,"AL122007")
devtools::run_examples()
