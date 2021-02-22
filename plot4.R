## READING CODE FROM MY DIRECTORY

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

#Metering data frame (df) FOR PLOT #3

library(reshape2)
df<-select(household_power_consumption,Sub_metering_1:newdate)
df<-melt(df,id.vars="newdate",variable.name="Sub_metering")

# code plot #4

#I WAS NOT ABLE TO PUT ALL THE GRAPHS IN THE ONE PLOT. 
# HERE IS THE CODE FOR EACH OF THE FOUR PLOTS

par(mfrow=c(2,2))
ggplot(data=household_power_consumption)
  +geom_histogram(mapping=aes(x=Global_active_power),binwidth = 0.40,fill="red",color="black")
  +xlab("Global active Power (kilowatts)")+ylab("Frequency")+xlim(0,6)
  +scale_y_continuous(breaks = seq(0,1200,200))
ggplot(df, aes(newdate,value)) + geom_line(aes(colour = Sub_metering))+xlab("")+ylab("")
ggplot(data=household_power_consumption)
  +geom_line(mapping=aes(x=newdate,Voltage),color="black")+xlab("")+ylab("")
ggplot(data=household_power_consumption)
  +geom_line(mapping=aes(x=newdate,Global_reactive_power),color="black")+xlab("")+ylab("")
ggsave("Plot4.png")

