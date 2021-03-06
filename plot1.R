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

# change date and time formats
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format ="%H:%M:%S")

# Subset date to daterange from 2020-02-01 to 2020-02-02
date1 <- as.Date("2007/02/01", format = "%Y/%m/%d" )
date2 <- as.Date("2007/02/02", format = "%Y/%m/%d" )
data <- subset(data, data$Date >=date1 & data$Date <= date2)
rm(date1, date2)

# Save plot to png
png(file="plot1.png", width=480, height=480)
hist(data$Global_active_power, main="Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()



