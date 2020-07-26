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

### Plot 2 - Line chart of Global Active Power (kilowatts) over the two day period
### Construct plot as png file in the working directory
### Include y axis label. There are no labels for the x axis and no title chart
png(file = "plot2.png", width = 480, height = 480)
plot(data1$DateTime,as.numeric(data1$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
