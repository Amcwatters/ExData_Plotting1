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

### Plot 4 - Four plots in one
### Construct plots into a png file in the working directory
png(file = "plot4.png", width = 480, height = 480)
### Set a 2 x 2 plot layout
par(mfrow = c(2, 2)) 
### Create top left chart - Line chart of Global Active Power (kilowatts) over the two day period
plot(data1$DateTime,as.numeric(data1$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
### Create top right chart - Line chart of voltage over 2 day period
plot(data1$DateTime,as.numeric(data1$Voltage), type="l", xlab="datetime", ylab="Voltage")
### Create bottom left chart - Line chart of the three Energy Sub Metering measurements over the two day period
plot(data1$DateTime,as.numeric(data1$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(data1$DateTime,as.numeric(data1$Sub_metering_2), col="red")
lines(data1$DateTime,as.numeric(data1$Sub_metering_3), col="blue")
legend("topright", inset= 0.01, legend=c(names(data1[7:9])),
       col=c("black", "red", "blue"), lty=1, box.lty=0)
### Create bottom right chart - 
plot(data1$DateTime,as.numeric(data1$Global_reactive_power), type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()