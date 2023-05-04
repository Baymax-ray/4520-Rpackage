dat <- read.csv("hurdat2-1851-2022-040723.txt", header= FALSE)
v=which(unlist(lapply(as.numeric(dat$V1),is.na))==TRUE)
code=dat[v,1]
name=dat[v,2]
data=dat[-v,]
v2=c(v[-1],nrow(dat)+1)
freqs=(v2-v)-1
data=data.frame(id=rep(code,times=freqs),name=rep(name,times=freqs),data)
data$V5= as.numeric(substr(data$V5,1,nchar(data$V5)-1))
data$V6= -as.numeric(substr(data$V6,1,nchar(data$V6)-1))
data[data == -999] <- NA
data[data == -99] <- NA
colnames(data)=c("id","name","date","time","record_identifier","status","latitude","longitude","max_wind","min_pressure","wind_radii_northeastern","wind_radii_southeastern","wind_radii_southwestern","wind_radii_northwestern","wind_radii_northeastern","wind_radii_southeastern","wind_radii_southwestern","wind_radii_northwestern","wind_radii_northeastern")
save(data, file = "data.RData")
