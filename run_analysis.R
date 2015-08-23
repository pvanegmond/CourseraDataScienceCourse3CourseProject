##run_analysis.R
cat("\014 run_analysis.R\n") 

# This script does the following: 
# 
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extract only the measurements on the mean and standard deviation for each measurement. 
# 3.	Uses descriptive activity names to name the activities in the data set
# 4.	Appropriately label the data set with descriptive variable names. 
# 5.	From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Data obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#

dbug <- TRUE
if (dbug) {
  closeAllConnections()
  rm(list=ls())
} 

library( data.table )
library( plyr )
library( dplyr )
library( reshape )
library( reshape2 )


## Data source and directory constants
workingDirectory <- ""
zipFile <- "./data/C3P1/Dataset.zip"
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filePath <- file.path("./data/C3P1" , "UCI HAR Dataset") 


## Only download the files if they don't already exist 
if(!file.exists("./data/C3P1")) {dir.create("./data/C3P1")}
if ( file.exists(zipFile)) {
  cat( "File ", zipFile, " exists\n")
} else {
  download.file(zipUrl, destfile = zipFile, mode = "wb")
  unzip( zipfile = zipFile, exdir = "./data/C3P1" )
}


## Now start the processing

## Read and tidy the features data
features <- read.table(file.path(filePath, "features.txt"),head=FALSE)
colnames(features)<-c("number", "feature")

## Read and format the activity label data
activityLabels <- read.table(file.path(filePath, "activity_labels.txt"),header = FALSE)
colnames(activityLabels)<-c("number", "label")
activityLabels[, 2] <- tolower(as.character(activityLabels[, 2]))
activityLabels[, 2] <- gsub("_", " ", activityLabels[, 2])

## Read the Test data
# X data is the "observed values"
# Y data is the "activity code" looked up in the activitylables data set
# Subject data has the subject ID that performed the test

xTest  <- read.table(file.path(filePath, "test" , "X_test.txt" ),header = FALSE)
yTest  <- read.table(file.path(filePath, "test" , "Y_test.txt" ),header = FALSE)
subjectTest  <- read.table(file.path(filePath, "test" , "subject_test.txt" ),header = FALSE)

# read the Train data
xTrain <- read.table(file.path(filePath, "train", "X_train.txt"),header = FALSE)
yTrain <- read.table(file.path(filePath, "train", "Y_train.txt"),header = FALSE)
subjectTrain <- read.table(file.path(filePath, "train", "subject_train.txt"),header = FALSE)


# Merge the Test and Train data and update the column names ( Requirement 1, 3&4 )
xBind <- rbind( xTest, xTrain )
colnames( xBind ) <- features$feature

yBind <- rbind( yTest, yTrain ) 
colnames(yBind)  <- "Activity"
yBind[, 1] = activityLabels[yBind[, 1], 2]

subjectBind <- rbind( subjectTest, subjectTrain )
colnames(subjectBind)  <- "Subject"

# Merge the data tables Subjects, Activities, Values
mergedData<-cbind(subjectBind, yBind, xBind) 

# Select only the required columns ( Requirement 2 )
meanStdCols <- features$feature[grep("mean\\(\\)|std\\(\\)", features$feature)]
selectedCols <- c("Subject", "Activity", as.character(meanStdCols))
selectedData <-subset(mergedData,select=selectedCols)                      # Select the required data
selectedData <- arrange( selectedData, Subject, Activity )                 # Sort the data 

write.table( selectedData, file="./data/C3P1/TidyData.csv", sep=",", row.names = FALSE)


# Summarize the data by subject and activity type.
# Approach 1
dtData <- data.table(selectedData)
summarisedData <-dtData[,lapply(.SD,mean),by="Subject,Activity"]

# save the summarised data
write.table( summarisedData, file="./data/C3P1/SummarisedDataApproach1.csv", sep=",", row.names = FALSE)


## Approach 2
meltData = melt( selectedData, id = c("Subject", "Activity"))
dataCast = dcast( meltData, Subject + Activity ~ variable, fun.aggregate=mean)

# save the summarised data
write.table( dataCast, file="./data/C3P1/SummarisedDataApproach2.csv", sep=",", row.names = FALSE)


cat("run_analysis.R Finished\n") 
  