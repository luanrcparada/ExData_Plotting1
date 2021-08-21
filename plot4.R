library(sqldf)
library(ggplot2)
library(scales)
library(ggpubr)
electric_consumption <- read.csv.sql("household_power_consumption.txt", 
                      sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")
timeline = paste(electric_consumption[,'Date'],electric_consumption[,'Time'], sep = " ")
timeline = strptime(timeline,"%d/%m/%Y %H:%M:%S")
electric_consumption[,'Datetime'] = as.POSIXct(timeline)
plot1 = ggplot(electric_consumption,aes(Datetime,Global_active_power)) + geom_line()+ scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                              breaks = pretty_breaks()) + theme(text = element_text(size=8))
plot2 = ggplot(electric_consumption,aes(Datetime,Voltage)) + geom_line()+ scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                                       breaks = pretty_breaks()) + theme(text = element_text(size=8))
plot3 = ggplot(electric_consumption) + geom_line(aes(Datetime,Sub_metering_1,color="Sub metering 1")) + geom_line(aes(Datetime,Sub_metering_2,color="Sub metering 2"))+ geom_line(aes(Datetime,Sub_metering_3,color="Sub metering 3")) + scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                           breaks = pretty_breaks()) + theme(text = element_text(size=8),legend.position = c(0.8, 0.85),legend.text = element_text(size=6),legend.key.size = unit(0.1, 'cm'),legend.title=element_blank()) + ylab("Energy sub metering")
plot4 = ggplot(electric_consumption,aes(Datetime,Global_reactive_power)) + geom_line()+ scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                                       breaks = pretty_breaks()) + theme(text = element_text(size=8))
ggarrange(plot1,plot2,plot3,plot4)