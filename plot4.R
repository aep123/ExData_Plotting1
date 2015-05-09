## Create four graphs using plot() for the  dates 1-2 Feb 2007 from the 
## household power consumption dataset. Plots should be in a 2x2 grid and
## include: Global Active Power by datetime, Voltage by datetime, Energy Sub Metering
## by datetime, and Global reactive power by datetime.

library(dplyr)

## read in the household power consumption table and filter it to get a table
## containing only measurements from 1-2 Feb 2007

energydf <- read.csv("household_power_consumption.txt", colClasses="character", 
                     sep = ";", header = TRUE)

energy <- tbl_df(energydf)

rm(energydf)

energy$Date <- as.Date(energy$Date, "%d/%m/%Y")
target <- as.Date(c('2007-02-01', '2007-02-02'))
twodays <- filter(energy, Date %in% target)

rm(energy)

## recreate the plot4 graphs as shown in the github fork

tdm <- mutate(twodays, datetime = as.POSIXct(paste(twodays$Date, twodays$Time), 
                                             format="%Y-%m-%d %H:%M:%S"))

tdm$Global_active_power <- as.numeric(tdm$Global_active_power)
tdm$Voltage <- as.numeric(tdm$Voltage)
tdm$Global_reactive_power <- as.numeric(tdm$Global_reactive_power)
tdm$Sub_metering_1 <- as.numeric(tdm$Sub_metering_1)
tdm$Sub_metering_2 <- as.numeric(tdm$Sub_metering_2)
tdm$Sub_metering_3 <- as.numeric(tdm$Sub_metering_3)

png("plot4.png")

par(mfrow = c(2,2), mar = c(4,4,2,1))

with(tdm, {
           plot(tdm$datetime, tdm$Global_active_power, type = "l", col = "black", 
                ylab = "Global Active Power", xlab = "", bg = "white")  
           plot(tdm$datetime, tdm$Voltage, type = "l", col = "black", 
                           ylab = "Voltage", xlab = "datetime")
           plot(tdm$datetime, tdm$Sub_metering_1, type = "l", col = "black", 
                ylab = "Energy sub metering", xlab = "", bg = "white")
           points(tdm$datetime, tdm$Sub_metering_2, type = "l", col = "red")
           points(tdm$datetime, tdm$Sub_metering_3, type = "l", col = "blue")
           legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = 
                  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  bty = "n")
           plot(tdm$datetime, tdm$Global_reactive_power, type = "l", col = "black",
                xlab = "datetime", ylab = "Global_reactive_power")
         })

dev.off()
