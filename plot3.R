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

# Plot code # 3
#Metering data frame (df)
library(reshape2)
df<-select(household_power_consumption,Sub_metering_1:newdate)
df<-melt(df,id.vars="newdate",variable.name="Sub_metering")
ggplot(df, aes(newdate,value)) + geom_line(aes(colour = Sub_metering))
ggsave("plot3.png")