## Samsung_tidy_project
#Samsung tidy data project
I have used the following files :
Root Directory: features.txt and activity_labels.txt
Train directory: X_train.txt, y_train.txt and subject_train.txt
Test Directory: X_test.txt, y_test,txt and subject_test.txt
I have not used any files in the Inertial Signals directory in both train and test directories

#Step 0: Read the files into R
features.txt ---> features : 561 variables with 2 variables - No (character) and features (character)
activity_labels.txt ----> activity_labels: 6 obs with 2 variables - Activity (character) and Description (character)
X_train.txt ---> X_train. Names of variables are derived from features using col.names: 7352 obs with 561 variables
subject_train.txt ---> subject_train. 7352 obs with one character variable named Subject
y_train.txt ---> y_train. 7352 obs with one character variable named Activity
X_test.txt ---> X_test. Names of variables are derived from features using col.names: 2947 obs with 561 variables
subject_test.txt ----> subject_test. 2947 obs with one character variable named Subject
y_test.txt ----> y_test. 2947 obs with one character variable named Activity

#Step 1: Merge the train and test data
X_test is a combined dataset of y_test, subject_test and X_test (activity, subject and measurements). I have used cbind function. X_test has 2947 obs and 563 variables (Activity, Subject and 561 feature measurements)
Similarly, X_train is similar to X_test, except that it contains train data. It has 7352 obs and 563 variables similar to X_test.
X_total is a combined dataset of X_test and X_train datasets using rbind. It has 10299 obs and 563 variables

