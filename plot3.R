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

#################################plot 3########################################
dfTemp <- df
dfTemp$day_of_week <- weekdays(dfTemp$Date)
dfTemp$date_time <- paste(dfTemp$Date,dfTemp$Time)
dfTemp$date_time <- strptime(dfTemp$date_time, "%Y-%m-%d %H:%M:%S")
names <- names(dfTemp)[-1]

png(filename="plot3.png")

plot(y=dfTemp$Sub_metering_1,x=dfTemp$date_time,type="l",xlab="",ylab="Energy sub metering")
lines(y=dfTemp$Sub_metering_2,x=dfTemp$date_time,col='red')
lines(y=dfTemp$Sub_metering_3,x=dfTemp$date_time,col='blue')
legend('topright', names[6:8] , lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

dev.off()