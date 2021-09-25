url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
if(!file.exists("exdata_data_household_power_consumption")){download.file(url, "exdata_data_household_power_consumption")}
if(!file.exists("household_power_consumption.txt")){unzip("exdata_data_household_power_consumption.zip")}
epc<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Libraries
library(lubridate)
library(dplyr)


## change to dates

epc<-mutate(epc, datetime = paste(epc$Date, epc$Time, sep = " ") )
colss<-c(3:8)
epc[colss] <-sapply(epc[colss], as.numeric)
epc$Date <-dmy(epc$Date)
epc$Time <- hms(epc$Time)
epc$datetime<-dmy_hms(epc$datetime)
str(epc)

##subsetting data by date
x<-subset(epc, epc$Date>=ymd(20070201)&epc$Date<= ymd(20070202))
## plot 1
hist(x$Global_active_power, col="red", main="Global Active Power", xlab="Clobal Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width = 600, height= 600)
dev.off()