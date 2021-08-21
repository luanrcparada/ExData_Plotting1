library(sqldf)
library(ggplot2)
library(scales)
library(ggpubr)
electric_consumption <- read.csv.sql("household_power_consumption.txt", 
                                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")

ggplot(electric_consumption,aes(Global_active_power)) + geom_histogram(binwidth=0.5, fill="#69b3a2", color="#e9ecef", alpha=0.9) + theme(text = element_text(size=10)) + ggtitle("Global Active Power")+ xlab("Global Active Power (kilowatts)") + ylab("Frequency") +
  theme(plot.title = element_text(hjust = 0.5))
