# R script for creating a line plot of energy sub meterings during 
# the dates of 2007-02-01 and 2007-02-02 for data described at
#
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# 
# Data was retrieved (once) and unpacked locally using the following commands

#   url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#   download.file(url, destfile="data.zip", method="curl", quiet=TRUE)
#   unzip("data.zip")

# The script performs the following operations:

# Reads the entire data set into memory (it takes only 126.8 Mb to load it)
alltime <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Selects data from the dates 2007-02-01 and 2007-02-02
# (Date is in format dd/mm/yyyy)
twodays <- subset(alltime, Date=="1/2/2007" | Date=="2/2/2007")

# Converts the Date and Time variables to Date/Time classes 
twodays$Time <- strptime(with(twodays, paste(Date,Time)),"%d/%m/%Y %H:%M:%S")
twodays$Date <- as.Date(as.character(twodays$Date),"%d/%m/%Y")

# Creates a line plot of energy sub meterings as function of time in the plot3.png file
# Roger's 4 plots are transparent, so we make this one transparent too
# His plots are also bigger (504x504) than the ones we have to make (480x480)
# For that reason, there might be minor differences between his plots and ours
png(file="plot3.png", bg="transparent")
with(twodays,{
   plot(range(Time),range(Sub_metering_1,Sub_metering_2,Sub_metering_3),
        type="n",xlab="",ylab="Energy sub metering")
   lines(Time,Sub_metering_1,type="l",col="black")
   lines(Time,Sub_metering_2,type="l",col="red")
   lines(Time,Sub_metering_3,type="l",col="blue")
   legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
})
dev.off()
