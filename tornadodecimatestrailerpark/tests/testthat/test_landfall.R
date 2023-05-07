test_that( "landfall function looks ok", {
  expect_equal(
    storm_US_landfall(data,"AL122007"),FALSE
  )

})
