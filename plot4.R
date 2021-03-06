# Initialization
install.packages("dplyr")
install.packages("tidyverse")
install.packeges("readr")
install.packeges("base")
library("dplyr")
library("tidyverse")
library("readr")
library("base")

# check for existing data and download data if not existing
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/exdata_data_household_power_consumption.zip"
unzipped <- "./data/household_power_consumption.txt"
if (!file.exists(destfile)) { 
  dir.create("data")
  download.file(fileURL, destfile = destfile)
}
if (!file.exists(unzipped)) {
  unzip(destfile, exdir = "./data/")
}
rm(fileURL, destfile, unzipped)

# read data to environment
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

# change date and time formats and set new Datetime column
data$Datetime <- as.POSIXct(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset date to daterange from 2020-02-01 to 2020-02-02
date1 <- as.Date("2007/02/01", format = "%Y/%m/%d" )
date2 <- as.Date("2007/02/02", format = "%Y/%m/%d" )
data <- subset(data, data$Date >=date1 & data$Date <= date2)
rm(date1, date2)

# Save plot to png
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(data$Datetime, data$Global_active_power, type = "l", lty =1, ylab = "Global Active Power (kilowatts)", xlab = NA)
plot(data$Datetime, data$Voltage, type = "l", lty =1, ylab = "Voltage", xlab = "datetime")
plot(data$Datetime, data$Sub_metering_1, type = "l", lty =1, ylab = "Energy sub metering", xlab = NA)
lines(data$Datetime, data$Sub_metering_2, col = "red", lty = 1)
lines(data$Datetime, data$Sub_metering_3, col = "blue", lty = 1)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty = 1)
plot(data$Datetime, data$Global_reactive_power, type = "l", lty =1, ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
