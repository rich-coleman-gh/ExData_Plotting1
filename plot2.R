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

####################################plot 2############################################
dfTemp <- df
dfTemp$Global_active_power_kilo <- dfTemp$Global_active_power/100
dfTemp$day_of_week <- weekdays(dfTemp$Date)
dfTemp$date_time <- paste(dfTemp$Date,dfTemp$Time)

dfTemp <- sqldf("
                select sum(Global_active_power_kilo) as Global_active_power_kilo
                ,date_time
                from dfTemp
                where day_of_week in ('Thursday','Friday','Saturday')
                group by 2
                ")

dfTemp$date_time <- strptime(dfTemp$date_time, "%Y-%m-%d %H:%M:%S")

# ggplot(data=dfTemp,aes(y=Global_active_power_kilo,x=date_time)) +
#   geom_line(stat="identity")
png(filename="plot2.png")

plot(y=dfTemp$Global_active_power_kilo,x=dfTemp$date_time,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()