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

png("plot2.png", width = 480, height = 480)
  plot(x = hpc_subset$Time, y = hpc_subset$Global_active_power, 
       type = "l", xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()