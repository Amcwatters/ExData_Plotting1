### 
### Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### Electric power consumption

### Load dataset into R from zipfile saved in the working directory
data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), sep=";", header=TRUE)

### Get dates into correct format
data$Date <- as.Date( as.character(data$Date), "%d/%m/%Y")

### Take subset of data for the dates 2007-02-01 and 2007-02-02
data1 <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

### Plot 1 - Histogram of Global Active Power (kilowatts)
### Include title and axis labels, set colour of bars as red
### Construct plot as png file
png(file = "plot1.png", width = 480, height = 480)
hist(as.numeric(data1$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
