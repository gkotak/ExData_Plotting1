#read contents of file efficiently by using colclasses. 
initial <- read.table("household_power_consumption.txt", header=TRUE, nrows = 100, sep=";")
classes <- sapply(initial, class)
allData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=classes, na.strings="?")

#now convert the date. I'm first going to create a copy just in case
allData$Datebackup <- allData$Date
allData$Timebackup <- allData$Time
allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")

#now filter for the 2 days
allData <- allData[allData$Date >= as.Date("2007-02-01"),]
allData <- allData[allData$Date <= as.Date("2007-02-02"),]

#now get apply strptime. i think we first need to concatenate date and string
allData$Time <- paste(allData$Datebackup, allData$Timebackup)
allData$Time <- strptime(allData$Time, "%d/%m/%Y %H:%M:%S")

#now plot 3
with(allData, plot(Time, Sub_metering_1, type="n", ylab="Energy Submetering", xlab=""))
with(allData, lines(Time, Sub_metering_1))
with(allData, lines(Time, Sub_metering_2, col="red"))
with(allData, lines(Time, Sub_metering_3, col="blue"))
legend("topright", pch="______", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.copy(png, file="plot3.png", width=480, height=480)

