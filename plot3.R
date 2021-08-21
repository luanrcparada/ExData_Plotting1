library(sqldf)
library(ggplot2)
library(scales)
library(ggpubr)
electric_consumption <- read.csv.sql("household_power_consumption.txt", 
                                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")
timeline = paste(electric_consumption[,'Date'],electric_consumption[,'Time'], sep = " ")
timeline = strptime(timeline,"%d/%m/%Y %H:%M:%S")
electric_consumption[,'Datetime'] = as.POSIXct(timeline)
ggplot(electric_consumption) + geom_line(aes(Datetime,Sub_metering_1,color="Sub metering 1")) + geom_line(aes(Datetime,Sub_metering_2,color="Sub metering 2"))+ geom_line(aes(Datetime,Sub_metering_3,color="Sub metering 3")) + scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                                                                                                                                                                                          breaks = pretty_breaks()) + theme(text = element_text(size=10),legend.position = c(0.85, 0.85),legend.text = element_text(size=8),legend.key.size = unit(0.5, 'cm'),legend.title=element_blank()) + ylab("Energy sub metering")