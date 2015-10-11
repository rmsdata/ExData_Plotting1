file <- ("./household_power_consumption.txt")
dfraw <- read.table(file, sep = ";", header = T, stringsAsFactors = FALSE, na.strings = c("?",""))
str(dfraw)
# convert date var from char to date
dfraw$Date <- as.Date(dfraw$Date, "%d/%m/%Y")
# subsetting data into df
df <- dfraw[(dfraw$Date == as.Date("2007-02-01") | dfraw$Date == as.Date("2007-02-02")),]  
# convert Time var from char to date and Time
df$DateTime <- paste(df$Date, df$Time)
df$Time <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
df$DateTime <- NULL
str(df)  
# convert remaining vars into appropriate data types
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)

# plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar =c(4,4,2,1))
with(df, {
        plot(Time, Global_active_power, type = "s", xlab ="", ylab = "Global Active Power")
        plot(Time, Voltage, type = "s", xlab = "datetime", ylab = "Voltage")
        plot(Time, Sub_metering_1, type = "s", xlab = "", ylab = "Energy Sub Metering")
        lines(df$Time, df$Sub_metering_2, col = "red")
        lines(df$Time, df$Sub_metering_3, col = "blue")
        legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.col = c("black", "red", "blue"))
        plot(Time, Global_reactive_power, type = "s", xlab ="")
})
dev.off()
