#combine test and training data
setwd("/Users/ximi/Downloads/UCI HAR Dataset/test")
subject_test<- read.table("subject_test.txt", header=F)
X_test<- read.table("X_test.txt", header=F)
y_test<- read.table("y_test.txt", header=F)
test<- cbind(y_test, subject_test, X_test)

setwd("../train")
subject_train<- read.table("subject_train.txt", header=F)
X_train<- read.table("X_train.txt", header=F)
y_train<- read.table("y_train.txt", header=F)
train<- cbind(y_train, subject_train, X_train)

data<-rbind(test,train)

setwd("..")
features<- read.table("features.txt", header=F)
colnames<- c("y", "subject", as.character(features$V2))

#change columnaes to descriptive labels
colnames<-gsub('[()]', '', colnames, perl=T)
colnames<-gsub("sma", "signal_mag_area", colnames, perl=T)
colnames<-gsub("iqr", "interquartile_range", colnames, perl=T)
colnames<-gsub("arCoeff", "AutoreggrCoeff", colnames, perl=T)
colnames(data)<- colnames

#appropriately labels the data set
data$y<-gsub("1","WALKING", data$y, perl=T)
data$y<-gsub("2","WALKING_UPSTAIRS", data$y, perl=T)
data$y<-gsub("3","WALKING_DOWNSTAIRS", data$y, perl=T)
data$y<-gsub("4","SITTING", data$y, perl=T)
data$y<-gsub("5","STANDING", data$y, perl=T)
data$y<-gsub("6","LAYING", data$y, perl=T)

mean<-grepl("mean", colnames)
std<- grepl("std", colnames)
mean_std<- mean + std
#include also y data and subject data, i.e., columns 1 and 2
mean_std[1:2]=c(1,1)
mean_std<-which(mean_std==1)
data_mean_std<- data[mean_std]


#creates a second, independent tidy data set with average of each variable for each activity and each subject
avg<-aggregate(data_mean_std, list(data_mean_std$subject, data_mean_std$y), mean)
avg$y<-avg$Group.2
avg$Group.1<-NULL
avg$Group.2<-NULL

write.table(avg, "avg_data.txt", row.name=F)
