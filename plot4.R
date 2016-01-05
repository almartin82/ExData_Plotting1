library(dplyr)
library(magrittr)

hpc <- read.table(
  file = 'household_power_consumption.txt', header = TRUE, 
  colClasses = c('character', 'character', 'numeric', 'numeric', 
                 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), 
  sep = ';', na = '?'
)

hpc$Date <- as.Date(hpc$Date, '%d/%m/%Y')
hpc$Time <- strptime(paste(hpc$Date, hpc$Time), '%Y-%m-%d %H:%M:%S') 
hpc$Time <- hpc$Time %>% as.POSIXct()

hpc_subset <- hpc %>%
  dplyr::filter(Date %in% as.Date(c('2007-02-01', '2007-02-02')))

png("plot4.png", width = 480, height = 480)

  #the grid
  par(mfrow = c(2,2))
  #plot 1
  plot(x = hpc_subset$Time, y = hpc_subset$Global_active_power, 
       type = "l", xlab = '', ylab = 'Global Active Power (kilowatts)')
  #plot 2
  plot(x = hpc_subset$Time, y = hpc_subset$Voltage, 
       type = "l", xlab = 'datetime', ylab = 'Voltage')
  #plot 3
  cols <- c('black', 'red', 'blue')
  plot(x = hpc_subset$Time, 
       y = hpc_subset$Sub_metering_1,
       col = cols[1], type = 'l', 
       xlab = '', ylab = 'Energy sub metering')
  lines(x = hpc_subset$Time, 
        y = hpc_subset$Sub_metering_2,
        col = cols[2], type = 'l')
  lines(x = hpc_subset$Time, 
        y = hpc_subset$Sub_metering_3,
        col = cols[3], type = 'l')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
         lwd = 1, col = cols)
  #plot 4
  plot(x = hpc_subset$Time, y = hpc_subset$Global_reactive_power, 
       type = "l", xlab = 'datetime', ylab = 'Global_reactive_power')
  
dev.off()