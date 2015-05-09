## Create a graph using plot() for global active power vs. frequency for the
## dates 1-2 Feb 2007 from the household power consumption dataset

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

## recreate the plot1 graph as shown in the github fork

twodays$Global_active_power <- as.numeric(twodays$Global_active_power)

hist(twodays$Global_active_power, freq = TRUE, main = "Global Active Power",
     col = "red", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()
