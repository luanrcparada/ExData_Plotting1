library(sqldf)
library(ggplot2)
library(scales)
library(ggpubr)
electric_consumption <- read.csv.sql("household_power_consumption.txt", 
                                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")
timeline = paste(electric_consumption[,'Date'],electric_consumption[,'Time'], sep = " ")
timeline = strptime(timeline,"%d/%m/%Y %H:%M:%S")
electric_consumption[,'Datetime'] = as.POSIXct(timeline)
ggplot(electric_consumption,aes(Datetime,Global_active_power)) + geom_line()+ scale_x_datetime(labels = date_format("%a %Hh",tz = "UTC"),
                                                                                                       breaks = pretty_breaks()) + theme(text = element_text(size=10))