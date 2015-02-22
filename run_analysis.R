## Code to tidy data related to the Project 
## First step is to read the files into R. The following files are used
## features.txt is read into features with 2 variables - "No" and "features"
## activity_labels.txt is read into activity_labels with 2 variables - "Act.No" and "Activity.Description"
## X_train.txt is read into X_train. Here, the variable names are taken from "features" variable from features data frame
## subject_train.txt is read into subject_train with one variable named "Subject"
## y_train.txt is read into y_train with one variable named "Act.No". This matches the variable name in activity_labels
## X_test.txt is read into X_test. Here, the variable names are taken from "features" variable from features data frame
## subject_test.txt is read into subject_test with one variable named "Subject"
## y_test.txt is read into y_test with one variable named "Act.No". This matches the variable name in activity_labels

## Task 1: Merge train and test data into one dataset

## I have not used any data from the folders Inertial signals.

## Steps followed are:
## Step 1: Merge y_test, subject_test and X_test into X_test. I have used cbind
## Step 2: Merge y_train, subject_train and X_test into X_train using cbind
## Step 3: Combine the test and train data (X_test and X_train) into one dataframe X_total using rbind
## This achieves one combined data frame of all the data

## Task 2: Select only variables related to mean and standard deviation
## I have used grep function to achieve this
## Thanks to the discussion forum which helped me to get this. I have excluded the variables
## corresponding to rows 555-561 related to angle. We can also do this if necessary
## From the features list, I first selected only those indices of variables that have "mean" in them into a character variable "means". 
## This integer vector "means" has the required indices
## Then, I selected only those indices of variables that have "std" in them into a integer vector "std"
## Combining the two vectors into one vector reqd_features gives me all the indices of the variables I need
## I then subsetted X_total to extract only the variables I need into a new data frame called "X_reqd"
## This completed the second task of the Project

## Task 3: Use descriptive activity names to name the activities in the dataset
## I have done this after summarizing the dataset

## Task 4: Appropriately label the dataset with descriptive variable names
## This is already achieved when reading the data itself using the col.names parameter

## Task 5: Create an independent tidy data set with the average of each variable for each activity and each subject
## I first grouped the X_total dataset into gr_data by activity and subject using group_by function of dplyr
## I then used summarise_each function to find the average of all variables into a new dataset called summary_data
## Using gather function, I converted this into a dataset tidy_data with 4 variables - Act.No, Subject, parameter and value
## tidy_data contains 14220 obs with 4 variables
## I now used merge function to get the Activity description into tidy_data. 
## tidy_final is the final dataset with 14220 observations and 4 variables - Activity.Description, Subject, parameter and value


setwd("~/Desktop/Coursera/project_get_data")   # set working directory

## load required libraries
library(data.table); library(dplyr); library(tidyr)

## read the data into R

## features.txt --> features
read.table("features.txt", colClasses = "character", col.names = c("No", "features")) -> features

## activity_labels --> activity_labels
read.table("activity_labels.txt", colClasses = "character", col.names = c("Act.No", "Activity.Description")) -> activity_labels

## X_train.txt ---> X_train with all variables and column names derived from features
read.table("~/Desktop/Coursera/project_get_data/train/X_train.txt", col.names = features$features) -> X_train

## subject_train.txt ---> subject_train
read.table("~/Desktop/Coursera/project_get_data/train/subject_train.txt", col.names = "Subject") -> subject_train

## y_train.txt ----> y_train
read.table("~/Desktop/Coursera/project_get_data/train/y_train.txt", col.names = "Act.No") -> y_train

## X_test.txt ----> X_test with all variables and column names derived from features
read.table("~/Desktop/Coursera/project_get_data/test/X_test.txt", col.names = features$features) -> X_test

## subject_test.txt ---> subject_test
read.table("~/Desktop/Coursera/project_get_data/test/subject_test.txt", col.names = "Subject") -> subject_test

## y_test.txt ---> y_test
read.table("~/Desktop/Coursera/project_get_data/test/y_test.txt", col.names = "Act.No") -> y_test

## Combine activity, subject and observation of test (y_test, subject_test and X_test)
X_test <- cbind(y_test, subject_test, X_test)

## Combine activity, subject and observation of train (y_train, subject_train and X_train)
X_train <- cbind(y_train, subject_train, X_train)

## Combine test and train data into one combined dataset X_total
X_total <- rbind(X_test, X_train)
### Step 1 finished ###

## Step 2 start - get only mean and standard deviations 
grep("mean", features$features) -> means  ## indices of variables corresponding to mean
grep("std", features$features) -> std  ## indices of variables corresponding to std

reqd_features <- c(means+2, std+2) ## combining indices of mean and std variables.
## Indices are increased by 2 to accomodate the two additional variables in X_total (Activity and Subject)
X_reqd <- X_total[,c(1,2,reqd_features)]  ## subset only mean and std variables
## end of step 2

## Tidy data with average of each variable by activity and subject
group_by(X_reqd, Act.No, Subject) ->gr_data   ## grouped data by activity and subject
summarise_each(gr_data, funs(mean)) -> summary_data  ## average of each variable 
## summary_data has 180 obs of 81 variables (Activity, Subject, 46 mean variables and 33 std variables)

## Collapse into 4 variables (Activity, Subject, parameter and value)
tidy_data <- gather(summary_data, parameter, value, -Act.No, -Subject)   ## tidy data with 4 variables

## Get activity description from activity labels
tidy_final <- merge(tidy_data, activity_labels,by.x="Act.No",by.y="Act.No",all=TRUE) ## tidy data with 5 variables
tidy_final <-tidy_final[,c(5,2:4)]  ## tidy data with 4 variables and 14220 obs.
write.table(tidy_final, file = "tidy_final.txt", row.names = FALSE)  ## create txt file in working directory
