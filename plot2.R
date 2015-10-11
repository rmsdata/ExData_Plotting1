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

# plot2
png(file = "plot2.png", width = 480, height = 480)
with(df, plot(Time, Global_active_power, type = "s", xlab ="", ylab = "Global Active Power (kilowatts)"))
dev.off()

dfraw <- NULL
rm(dfraw)

