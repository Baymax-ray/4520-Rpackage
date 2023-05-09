test_that( "plot_storm_tracks function looks ok", {
  expect_error(plot_storm_tracks(storm_data, "BL011851"), "One or more of the storm ids is not in the data")


})
