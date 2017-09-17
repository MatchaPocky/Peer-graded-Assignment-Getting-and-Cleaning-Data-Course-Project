## Data
The following files were used to obtain the tidy data set

- X_train.txt: Training set
- y_train.txt: Training labels
- subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- X_test.txt: Test set
- y_test.txt: Test labels
- subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- features.txt: List of all features
- activity_labels.txt: Links the class labels with their activity name

## Variables

- Subject: Integer. Ranging from 1 to 30
- Activity: Factor with 6 levels, "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING
" "STANDING" "LAYING"

- tBodyAcc.mean...X ~ fBodyBodyGyroJerkMag.meanFreq..: Numeric. The average values of the corresponding variables.

## Transformation

1. From left to right, subject_train.txt, y_train.txt and X_train.txt were merged to form the traindata data set using the cbind() function
2. From left to right, subject_test.txt, y_test.txt and X_test.txt were merged to form the testdata data set using the cbind() function
3. The traindata and testdata data sets were combined to form the MergeData data set using the rbind() function
4. From the features.txt, variables containing either "mean" or "std" in the variable name were identified using the grep() function
5. Extract the identified variables from the MergedData data set to form the ExtractData data set
6. Read the activity_labels.txt and match it with column 2 of the ExtractData data set(data from y_test.txt and y_train.txt) to the corresponding activity names using the match() function
7. Extract the variable names of the identified variables from Step 4 to form the list of variable names using the grep() function, value = TRUE
8. Add variable names "Subject" and "Activity" to represent the participant number as well as the type of activity to the list of variable names
9. Amend the column names of ExtractData to the list of variable names using the colnames() function
10. Using the ddply() function from the plyr library, group ExtractData by the variables "Subject" and "Activity" and apply the colMeans function on the rest of the variables to obtain the average of each variable for each activity and each subject.
11. Extract the data using the write.table() function into "TidyDataSet.txt"

read.table("TidyDataSet.txt"):
There are a total of 180 observation in the "TidyDataSet.txt" file which corresponds to 30 participants x 6 activities.
As every variable measured is in one column and each different observation is in a different row, the "TidyDataSet.txt" is a tidy data set.
