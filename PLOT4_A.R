# READING CODE FROM MY DIRECTORY

setwd("C:/Users/gog/OneDrive/Documentos/R/COURSERA/Exploratory DA/Week 1/exdata_data_household_power_consumption")
library(dplyr) ; library(tidyverse) ; library(ggplot2) ; library(lubridate) ;library(readr);library(reshape2)

# cleaning up

rm(list=ls()) 

# Code for reading the data

household_power_consumption <- read.table("~/R/COURSERA/Exploratory DA/Week 1/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";",header = TRUE, na.strings="?")
household_power_consumption<-as_tibble(household_power_consumption)
household_power_consumption$Date<-dmy(household_power_consumption$Date)
household_power_consumption$newdate <- with(household_power_consumption, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# Filtering the data according to the specified dates (feb-1-2007 and feb-2-2007). 
# Resulting data base

household_power_consumption<-filter(household_power_consumption, (year(household_power_consumption$Date)==2007) & month(household_power_consumption$Date)==2 & day(household_power_consumption$Date)<=2)

# Generate png plot4 (2 rows and 2 columns)

png(filename="plot4_.png")

par(mfrow = c(2,2))


# Code for Plot #1 Global Active Power (1st row,1st column)

plot(household_power_consumption$newdate,household_power_consumption$Global_active_power,type ="l", xlab="", ylab="Global Active Power")

# Code for Plot #2 Voltage (1st row, 2nd column)

plot(x=household_power_consumption$newdate, y=household_power_consumption$Voltage, type = "l",xlab = "datetime",ylab = "Voltage")

# Code for plot #3 Energy sub metering (2nd row, 1st column)

plot(household_power_consumption$newdate,household_power_consumption$Sub_metering_1,type ="l",xlab="",ylab = "Energy sub metering")
lines(household_power_consumption$newdate,household_power_consumption$Sub_metering_2,col = "red")
lines(household_power_consumption$newdate,household_power_consumption$Sub_metering_3, col = "blue")
legend("topright",legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n",lty=c(1,1,1),col = c("black","red","blue"))

# Code for plot #4 Global reactive power (2nd row, 2nd column)

plot(household_power_consumption$newdate,household_power_consumption$Global_reactive_power,type ="l",xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
