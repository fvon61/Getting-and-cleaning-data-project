#run_analysis.R

#This code provides guidance to the course project for Getting and Cleaning Data

#Set working directory to dataset location
setwd("~/R/UCI HAR Dataset")

#clear data environment
rm(list=ls())

#load data.table
library(data.table)

#load test data
X_test <- read.table("~/R/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_test[,562] <- read.table("~/R/UCI HAR Dataset/test/Y_test.txt", quote="\"")
X_test[,563] <- read.table("~/R/UCI HAR Dataset/test/subject_test.txt", quote="\"")
View(X_test)

#load Train Data
X_train <- read.table("~/R/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_train[,562] <- read.table("~/R/UCI HAR Dataset/train/Y_train.txt", quote="\"")
X_train[,563]<- read.table("~/R/UCI HAR Dataset/train/subject_train.txt", quote="\"")
View(X_train)

#load features
features <- read.table("~/R/UCI HAR Dataset/features.txt", quote="\"")
  View(features)

#identify col with  mean and std dev and re-lable
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

#load activity labels
activity_labels <- read.table("~/R/UCI HAR Dataset/activity_labels.txt", quote="\"")
  View(activity_labels)

#join test and train databases
AllData <- rbind(X_test, X_train)

# Get only the data on mean and std. dev.
colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce to values which only have mean and st dev
features <- features[colsWeWant,]
# Now add subject and activity to the last two columns
colsWeWant <- c(colsWeWant, 562, 563)
# Remove the unneeded columns from AllData
AllData <- AllData[,colsWeWant]
# Add the column names (features) to AllData
colnames(AllData) <- c(features$V2, "Activity", "Subject")
colnames(AllData) <- tolower(colnames(AllData))

currentActivity = 1
for (currentActivityLabel in activity_labels$V2) {
  AllData$activity <- gsub(currentActivity, currentActivityLabel, AllData$activity)
  currentActivity <- currentActivity + 1
}

AllData$activity <- as.factor(AllData$activity)
AllData$subject <- as.factor(AllData$subject)

#create tidy tasble
tidy = aggregate(AllData, by=list(activity = AllData$activity, subject=AllData$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy[,88] = NULL
tidy[,87] = NULL

#Print tidy table to tidy.txt
write.table(tidy, "tidy.txt", sep="\t", row.name=FALSE)

#look at tidy table
View(tidy)
