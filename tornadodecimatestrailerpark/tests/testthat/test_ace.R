test_that( "ace_of_storm function looks ok", {
  expect_equal(
    ace_of_storm(data,"AL122007"),3.885
  )
  expect_equal(
    ace_of_storm(data,"AL051895"),34.1175
  )

})
