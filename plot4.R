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

##############################plot 4###########################################
dfTemp <- df
dfTemp$Global_active_power_kilo <- dfTemp$Global_active_power
dfTemp$day_of_week <- weekdays(dfTemp$Date)
dfTemp$date_time <- paste(dfTemp$Date,dfTemp$Time)

# dfPlot <- sqldf("
# select   date_time
#   ,sum(Global_active_power_kilo) as Global_active_power_kilo
#   ,sum(Voltage) as Voltage
# from dfTemp
# where day_of_week in ('Thursday','Friday','Saturday')
# group by 1
# ")

dfTemp$date_time <- strptime(dfTemp$date_time, "%Y-%m-%d %H:%M:%S")

names <- names(dfTemp)[-1]

png(filename="plot4.png")

par(mfrow=c(2,2))
plot(y=dfTemp$Global_active_power_kilo,x=dfTemp$date_time,type="l",xlab="",ylab="Global Active Power")
plot(y=dfTemp$Voltage,x=dfTemp$date_time,type="l",xlab="datetime",ylab="Voltage")
plot(y=dfTemp$Sub_metering_1,x=dfTemp$date_time,type="l",xlab="",ylab="Energy sub metering")
lines(y=dfTemp$Sub_metering_2,x=dfTemp$date_time,col='red')
lines(y=dfTemp$Sub_metering_3,x=dfTemp$date_time,col='blue')
legend('topright', names[6:8] , lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
plot(y=dfTemp$Global_reactive_power,x=dfTemp$date_time,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()
