setwd("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2")
library(data.table); library(dplyr); library(tidyr)
read.table("features.txt", colClasses = "character", col.names = c("No", "features")) -> features
read.table("activity_labels.txt", colClasses = "character", col.names = c("Activity", "Description")) -> activity_labels
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/train/X_train.txt", col.names = features$features) -> X_train
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/train/subject_train.txt", col.names = "Subject") -> subject_train
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/train/y_train.txt", col.names = "Activity") -> y_train
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/test/X_test.txt", col.names = features$features) -> X_test
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/test/subject_test.txt", col.names = "Subject") -> subject_test
read.table("~/Desktop/Coursera/Getdata/UCI HAR Dataset-2/test/y_test.txt", col.names = "Activity") -> y_test
X_test <- cbind(y_test, subject_test, X_test)
X_train <- cbind(y_train, subject_train, X_train)
X_total <- rbind(X_test, X_train)

grep(fg, features$features) -> means
grep("std", features$features) -> std

reqd_features <- c(means+2, std+2)
X_reqd <- X_total[,c(1,2,reqd_features)]
group_by(X_reqd, Activity, Subject) ->gr_data
summarise_each(gr_data, funs(mean)) -> summary_data
tidy_data <- gather(summary_data, parameter, value, -Activity, -Subject)
tidy_final <- merge(tidy_data, activity_labels,by.x="Activity",by.y="Activity",all=TRUE)
tidy_final <-tidy_final[,c(5,2:4)]
write.table(tidy_final, file = "tidy_final.txt", row.names = FALSE)
