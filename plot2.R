# Create Plot 2

library(dplyr)
library(lubridate)

# dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
power_data <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE)

# convert data with strptime() and as.Date
power_data$Time <- strptime(paste(power_data$Date,power_data$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
power_data$Date <- strptime(power_data$Date, format = "%d/%m/%Y", tz="GMT")
# power_data$Time <- as.numeric(power_data$Time)
power_data$Date <- as.numeric(power_data$Date)

col_names <- colnames(power_data)
col_names[2] <- "DateTime"
colnames(power_data) <- col_names

# Select subset of two days 01-02-2007 and 02-02-2007 
lower <- as.numeric(dmy("01-02-2007", tz="GMT"))
upper <- as.numeric(dmy("02-02-2007", tz="GMT"))
subset <- as.tbl(power_data)
# subset <- cbind(weekdays(subset$DateTime, abbreviate = FALSE), subset)
subset$DateTime <- as.numeric(subset$DateTime)
# subset <- select(subset, -DateTime)
subset <- filter(subset, power_data$Date == lower | power_data$Date == upper)
subset$Global_active_power <- as.numeric(as.character(subset$Global_active_power))
subset$DateTime <- as.POSIXct(subset$DateTime, tz="GMT", origin="1970-01-01")

summary(subset)

# Create plot in plot2.png
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12)
with(subset, plot(Global_active_power ~ DateTime, col = "black", typ = "l", 
                  ylab= "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()




