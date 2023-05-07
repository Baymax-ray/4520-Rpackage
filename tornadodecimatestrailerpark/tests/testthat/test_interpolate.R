test_that( "interpolate_storm_track_30m function looks ok", {
  interpolated <- interpolate_storm_track_30m(data[1:100,])
  expect_equal(
    names(interpolated),
    names(data)
  )
  expect_equal(
    interpolated$date[2],'18510625'
  )
  expect_equal(
    interpolated$time[2],"0030"
  )
})
