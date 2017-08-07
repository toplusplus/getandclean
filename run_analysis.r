## Merges the training and the test sets to create one data set.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "hardataset.zip")
unzip("hardataset.zip")
featlabels <- read.table("./UCI HAR Dataset/features.txt")  
str(featlabels)
featlabels <- as.vector(featlabels[[2]])
str(featlabels)

traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
str(traindata[,1:10])
colnames(traindata) <- featlabels
str(traindata[,1:10])

subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
str(subject)
subject <- as.vector(subject[[1]])
str(subject)

activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
str(activity)
activity <- factor(activity[[1]])
str(activity)

traindata <- cbind(subject, activity, traindata)
dim(traindata)
str(traindata[,1:10])

testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(testdata) <- featlabels

subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject <- as.vector(subject[[1]])

activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
activity <- factor(activity[[1]])

testdata <- cbind(subject, activity, testdata)
dim(testdata)
str(testdata[,1:10])

hardata <- rbind(traindata, testdata)
dim(hardata)
str(hardata[,1:10])

rm(traindata, testdata, activity, featlabels, subject)

## Extracts only the measurements on the mean and standard deviation
## for each measurement.

hardata <- hardata[,c(1,2,grep("mean\\(\\)|std\\(\\)", names(hardata)))]
dim(hardata)
str(hardata[,1:10])

## Uses descriptive activity names to name the activities in the data set.

actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
str(actlabels)
actlabels <- tolower(as.vector(actlabels[[2]]))
str(actlabels)

levels(hardata$activity) <- actlabels 
levels(hardata$activity)

rm(actlabels)

## Appropriately labels the data set with descriptive variable names.

names <- gsub("()", "", names(hardata), fixed = TRUE)
names <- gsub("-", "_", names)
names(hardata) <- names
str(hardata[,1:10])

rm(names)

## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

library(dplyr)
avgdata <- group_by(hardata, activity, subject)  %>% 
           summarise_all(funs(mean))

head(avgdata[,1:10])
write.table(avgdata, "avgdata.txt", row.names = FALSE)