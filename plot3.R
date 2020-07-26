### Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### Electric power consumption

### Load dataset into R from zipfile saved in the working directory
data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), sep=";", header=TRUE)

### Get dates into correct format
data$Date <- as.Date( as.character(data$Date), "%d/%m/%Y")

### Take subset of data for the dates 2007-02-01 and 2007-02-02
data1 <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

### Create datetime field and add to dataframe
DateTime <- as.POSIXct(paste(data1$Date, data1$Time), format="%Y-%m-%d %H:%M:%S")
data1 <- cbind(data1, DateTime)

### Plot 3 - Line chart of the three Energy Sub Metering measurements over the two day period
### Construct plot as png file in the working directory
### Include y axis label. There are no labels for the x axis and no chart title
### Add legend to top right of chart
png(file = "plot3.png", width = 480, height = 480)
plot(data1$DateTime,as.numeric(data1$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(data1$DateTime,as.numeric(data1$Sub_metering_2), col="red")
lines(data1$DateTime,as.numeric(data1$Sub_metering_3), col="blue")
legend("topright", legend=c(names(data1[7:9])),
       col=c("black", "red", "blue"), lty=1, cex=0.8)
dev.off()