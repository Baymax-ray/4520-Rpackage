test_that( "format_dataset object looks ok", {
  file=read.csv("~/4520-Rpackage/tornadodecimatestrailerpark/data/hurdat2-1851-2022-040723.txt",header= FALSE)
  fomatted <- format(file)
  expect_equal(
    names(fomatted),
    c("id","name","date","time","record_identifier","status","latitude","longitude","max_wind","min_pressure","34_wind_radii_northeastern","34_wind_radii_southeastern","34_wind_radii_southwestern","34_wind_radii_northwestern","50_wind_radii_northeastern","50_wind_radii_southeastern","50_wind_radii_southwestern","50_wind_radii_northwestern","64_wind_radii_northeastern","64_wind_radii_southeastern","64_wind_radii_southwestern","64_wind_radii_northwestern","radius_max_wind")
  )

})
