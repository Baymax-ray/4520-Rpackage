#scratch paper
lon=-94.8
lat=28
devtools::load_all()
devtools::test()
devtools::document()
load("~/4520-Rpackage/tornadodecimatestrailerpark/data/hurdat.RData")
format_dataset(data)
interpolate_storm_track_30m(data)
plot_storm_tracks(data,"AL011851")
