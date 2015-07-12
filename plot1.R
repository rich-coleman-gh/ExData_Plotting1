options(scipen=5)

library(ggplot2)
library(sqldf)
library(reshape2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 1/")

df <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
df$Date <- as.Date(df$Date,format= "%e/%m/%Y")
df$month <- format(df$test,"%m")
df$year <- format(df$test,"%Y")
df$day <- format(df$test,"%e")
df$Global_active_power<- as.numeric(as.character(df$Global_active_power))

df <- df[df$Date=='2007-02-01' | df$Date=='2007-02-02',]

######################################plot 1######################################
dfTemp <- df

png(filename="plot1.png")

p1 <- hist(dfTemp$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",xlim=c(0,8))

dev.off()
