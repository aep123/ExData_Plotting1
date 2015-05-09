## Create a graph using plot() for global active power for the
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

## recreate the plot2 graph as shown in the github fork

tdm <- mutate(twodays, datetime = as.POSIXct(paste(twodays$Date, twodays$Time), 
                                             format="%Y-%m-%d %H:%M:%S"))

png("plot2.png")
              
plot(tdm$datetime, tdm$Global_active_power, type = "l", col = "black", 
     ylab = "Global Active Power (kilowatts)", xlab = "", bg = "white")

box(col = "black")


dev.off()

