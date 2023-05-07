test_that( "plot_storm function looks ok", {
  dev.off()
  missing_len=plot_storm(data,43825)
  expect_equal(
    missing_len,0
  )
  missing_len=plot_storm(data,30480)
  expect_equal(
    missing_len,30
  )

})
