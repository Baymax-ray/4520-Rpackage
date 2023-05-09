test_that( "plot_storm_size function looks ok", {
    expect_error(plot_storm_size(data,-1),"row_index must be between 0 and nrow")
    a<-data.frame("storm_id"=c(1,2,3),"storm_size"=c(1,2,3))
    expect_error(plot_storm_size(a,2),"row_index must be a row with wind_radii data")

})
