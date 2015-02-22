## Samsung_tidy_project
#Samsung tidy data project
I have used the following files :
Root Directory: features.txt and activity_labels.txt
Train directory: X_train.txt, y_train.txt and subject_train.txt
Test Directory: X_test.txt, y_test,txt and subject_test.txt
I have not used any files in the Inertial Signals directory in both train and test directories

#Step 0: Read the files into R
features.txt ---> features : 561 variables with 2 variables - No (character) and features (character)
activity_labels.txt ----> activity_labels: 6 obs with 2 variables - Act.No (character) and Activity.Description (character)
X_train.txt ---> X_train. Names of variables are derived from features using col.names: 7352 obs with 561 variables
subject_train.txt ---> subject_train. 7352 obs with one character variable named Subject
y_train.txt ---> y_train. 7352 obs with one character variable named Act.No
X_test.txt ---> X_test. Names of variables are derived from features using col.names: 2947 obs with 561 variables
subject_test.txt ----> subject_test. 2947 obs with one character variable named Subject
y_test.txt ----> y_test. 2947 obs with one character variable named Act.No

#Step 1: Merge the train and test data
X_test is a combined dataset of y_test, subject_test and X_test (activity, subject and measurements). I have used cbind function. X_test has 2947 obs and 563 variables (Act.No, Subject and 561 feature measurements)
Similarly, X_train is similar to X_test, except that it contains train data. It has 7352 obs and 563 variables similar to X_test.
X_total is a combined dataset of X_test and X_train datasets using rbind. It has 10299 obs and 563 variables

#Step 2: Select only variables related to mean and standard deviation
I have used grep function to select indices corresponding to mean and std variables
The logic used was to identify those observations in features that contained the string "mean" or "std".
I first collected the indices of variables containing the string "mean" in an integer vector called "means". Its length is 46.
Then, indices of variables containing the string "std" in an integer vector called "std". Its length is 33.
Finally, these two integer vectors were combined into one integer vector called reqd_features with length 79.

These indices also represent the column indices in X_total. However, since I introduced 2 additional variables (Activity and Subject), I have to increment the indices in reqd_features by 2 to correspond to the column indices.

X_reqd is a subset of X_total with only the columns corresponding to the indices in reqd_features. X_reqd has 10299 obs with 81 variables (Activity, Subject, mean variables - 46; std variables - 33).

#Find average of each variable by Activity and Subject
I grouped _reqd by Activity and Subject and stored this in another dataset called gr_data. This has 10299 obs with 81 variables
Then, I summarised this using summarise_each function. Thanks to the online community for this. The results of this summary are stored in summary_data. summary_data has 180 obs of 81 variables

#Collapse into 4 variables
Using gather function, I then reduced the 79 variables into 2 variables - parameter and value. The results are stored in tidy_data. tidy_data has 14220 obs with 4 variables (Activity, Subject, parameter, value)

##Get Activity descriptions
I used merge function to merge activity_labels and tidy_data to get the description of Activity. These results are stored in tidy_final dataset which has 14220 obs with 5 variables (the Activity.Description is the additional variable introduced)
Finally, the Activity variable is dropped to get the final dataset.
tidy_final has 14220 obs with 4 variables (Activity.Description, Subject, parameter and value)



