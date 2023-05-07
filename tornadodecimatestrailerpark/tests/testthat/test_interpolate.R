test_that( "interpolate_storm_track_30m function looks ok", {
  interpolated <- interpolate_storm_track_30m(data)
  expect_equal(
    names(interpolated),
    c("id","name","date","time","record_identifier","status","latitude","longitude","max_wind","min_pressure","34_wind_radii_northeastern","34_wind_radii_southeastern","34_wind_radii_southwestern","34_wind_radii_northwestern","50_wind_radii_northeastern","50_wind_radii_southeastern","50_wind_radii_southwestern","50_wind_radii_northwestern","64_wind_radii_northeastern","64_wind_radii_southeastern","64_wind_radii_southwestern","64_wind_radii_northwestern","radius_max_wind")
  )

})
