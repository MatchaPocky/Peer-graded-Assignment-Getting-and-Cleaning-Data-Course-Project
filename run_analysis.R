## Step 1: 
##Merges the training and the test sets to create one data set.


## Read "X_train.txt", "y_train.txt" and "subject_train.txt"
## And combine them into traindata 
xtrain <- read.table("X_train.txt", header = FALSE)
ytrain <- read.table("y_train.txt", header = FALSE)
subtrain <-read.table("subject_train.txt", header = FALSE)
traindata <- cbind(subtrain, ytrain, xtrain)


## Read "X_test.txt", "y_test.txt" and "subject_test.txt"
## And combine them into the testdata
xtest <- read.table("X_test.txt", header = FALSE)
ytest <- read.table("y_test.txt", header = FALSE)
subtest <- read.table("subject_test.txt", header = FALSE)
testdata <-cbind(subtest, ytest, xtest)


## Combine the traindata set and testdata set into MergeData 
MergeData <- rbind(traindata, testdata)


## Step 2: 
##Extracts only the measurements on the mean and standard deviation for each measurement


## Read "features.txt" 
## And extract variables which have either "mean" or "std" in the variable name
features <- read.table("features.txt", header = FALSE)
MeanOrStd <- grep("mean|sd", features$V2)
MeanOrStd1 <- MeanOrStd +2
colno <- c(1, 2, MeanOrStd1)
ExtractData <- MergeData[,colno]


## Step 3:
## Uses descriptive activity names to name the activities in the data set


## Read "activity_labels.txt" 
## Match column 2 of ExtractData (ytrain/ytest) to the activity name in the "activity" table 
activity <- read.table("activity_labels.txt", header = FALSE)
ExtractData$V1.1 <- activity[match(ExtractData$V1.1, activity[['V1']]), 'V2']


##Step 4:
## Appropriately labels the data set with descriptive variable names. 


## Extract the variable names of variables which have either "mean" or "std" in the variable name
## Add "Subject" and "Activity" to the list of variable names
## Amend the column names of ExtractData to the list of variable names
Variablenames <- grep("mean|sd", features$V2, value = TRUE)
Variablenames1 <- c("Subject", "Activity", Variablenames)
colnames(ExtractData) <- Variablenames1


## Step 5:
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Load "plyr" package
## Group ExtractData by "Subject" and "Activity" and apply the colMeans function on the rest of the variables
## Export TidyData into"TidyDataSet.txt"
library(plyr)
TidyData <- ddply(ExtractData, .(Subject, Activity), function(x) colMeans(x[, 3:48]))
write.table(TidyData, "TidyDataSet.txt", row.name=FALSE)
