##Reading the data
data<-read.table("household_power_consumption.txt",sep=";",header = T,
                 na.strings = "?")


DT<-paste(data$Date,data$Time,sep=" ")        #Read Date and Time from data
DT<-as.POSIXct(DT,format="%d/%m/%Y %H:%M:%S") #DT as POSIXct
data$Date<-NULL                               #Delete Date and Time from data
data$Time<-NULL
data<-cbind(DT,data)                          #Binding DT to original data


#Subseting original data whithin the dates "2007-02-01" and "2007-02-02"
names(data)[1]<-"Data_Time"
AsDate<-as.Date(data$Data_Time)
true.vector<-data[,1]>="2007-02-01 00:00:00" & data[,1]<="2007-02-02 23:59:00"
sub.data<-data[true.vector,]
row.names(sub.data)<-NULL

#ploting. no widht or heigh parameters added because by defualt it is 480x480

png("plot3.png")

plot( sub.data$Data_Time,sub.data$Sub_metering_1, 
      ylab="Energy sub meeting", xlab="",type = "l")

lines( sub.data$Data_Time,sub.data$Sub_metering_2,col="red", 
       ylab="Energy sub meeting", xlab="",type = "l")

lines( sub.data$Data_Time,sub.data$Sub_metering_3,col="blue", 
       ylab="Energy sub meeting", xlab="",type = "l")

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1))

dev.off()