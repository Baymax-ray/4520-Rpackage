test_that( "plot_storm_tracks function looks ok", {
  len=plot_storm_tracks(data,"AL011851",return=T)
  expect_equal(
    len,23
  )

})
