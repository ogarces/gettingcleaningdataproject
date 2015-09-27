#Load package reshape2
library(reshape2)

#Set working directory
setwd("c://Users/lette/Desktop/Data science specialization/Getting and cleaning data")

#Set file name
workfile <- "getdata-projectfiles-UCI HAR Dataset.zip"

#Checking if file exists, downloading and unzipping file
if(!file.exists(workfile)){
  fileHere <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileHere, workfile)
}

if (!file.exists("UCI HAR Dataset")){
  unzip(workfile)
}

#Load activity_labels and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

activity_labels[,2]<- as.character(activity_labels[,2])
features[,2]<- as.character(features[,2])

#Subset with data including mean or standard deviation, substract words mean and std
stmeanData <- grep(".*mean.*|.*std.*", features[,2])
stmeanData_names <- features[stmeanData,2]
stmeanData_names <- gsub("-mean", "Mean", stmeanData_names)
stmeanData_names <- gsub("-std", "Std", stmeanData_names)
stmeanData_names <- gsub("[-()]", "", stmeanData_names)



#Read datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[stmeanData]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)
head(train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[stmeanData]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)
head(test)

#Merging train and test datasets, adding labels
if(ncol(train)==ncol(test)){
  mergedTrainTest <- rbind(train, test)
  colnames(mergedTrainTest) <- c("subject", "activity", stmeanData_names)
}

#Transform activities and subjects into factors
mergedTrainTest$activity <- factor(mergedTrainTest$activity, levels = activity_labels[,1], labels = activity_labels[,2])
mergedTrainTest$subject <- as.factor(mergedTrainTest$subject)

meltedMergedTT <- melt(mergedTrainTest, id=c("subject", "activity"))
meanMergedTT <- dcast(meltedMergedTT, subject+activity ~ variable, mean)

write.table(meanMergedTT, "tidy.txt", row.names = FALSE, quote = FALSE)
