
#' Format the hurdat dataset in the data directory
#'
#' Get a data frame with the following qualities:
#' no storm id rows.
#' instead of storm id rows, an id column to signify which storm id each row corresponds to.
#' a name column for the name of the storm
#' missing value codes replaced with NAs
#' meaningful column names. (see documentation)
#' numeric latitude and longitude columns, in degrees north and degrees east, respectively.
#'
#'
#'@param dat the text file to be formatted
#'@return the formatted data frame save as RData
#'@examples
#'dat <- read.csv("hurdat2-1851-2022-040723.txt", header= FALSE)
#'format(dat)
#'@export
format <- function(dat){
  v=which(unlist(lapply(suppressWarnings(as.numeric(dat$V1)),is.na))==TRUE)
  code=dat[v,1]
  name=dat[v,2]
  data=dat[-v,]
  v2=c(v[-1],nrow(dat)+1)
  freqs=(v2-v)-1
  data=data.frame(id=rep(code,times=freqs),name=rep(name,times=freqs),data)
  data$V5= suppressWarnings(as.numeric(substr(data$V5,1,nchar(data$V5)-1)))
  data$V6= suppressWarnings(-as.numeric(substr(data$V6,1,nchar(data$V6)-1)))
  data[data == -999] <- NA
  colnames(data)=c("id","name","date","time","record_identifier","status","latitude","longitude","max_wind","min_pressure","34_wind_radii_northeastern","34_wind_radii_southeastern","34_wind_radii_southwestern","34_wind_radii_northwestern","50_wind_radii_northeastern","50_wind_radii_southeastern","50_wind_radii_southwestern","50_wind_radii_northwestern","64_wind_radii_northeastern","64_wind_radii_southeastern","64_wind_radii_southwestern","64_wind_radii_northwestern","radius_max_wind")
  data$max_wind <- ifelse(data$max_wind == -99, NA, data$max_wind)
  w=which(abs(data$longitude)>180)
  ori=data$longitude[w]
  data$longitude[w]=360+ori
  #rownames(data) <- c(1 : nrow(data))
  return(data)
}
