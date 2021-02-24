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

# Plot code

# plot1
ggplot(data=household_power_consumption)+
    geom_histogram(mapping=aes(x=Global_active_power),binwidth = 0.40,fill="red",color="black")+
    xlab("Global active Power (kilowatts)")+ylab("Frequency")+
    xlim(0,6)+scale_y_continuous(breaks = seq(0,1200,200))+theme_bw()
ggsave("plot1.png")

