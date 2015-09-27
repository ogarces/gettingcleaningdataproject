---
title: "Code Book"
author: "Olga Garcés"
date: "26 de septiembre de 2015"
output: html_document
---

# Code Book

This file describes the steps taken in run_analysis.R in order to obtain "tidy.txt"

*The data for the project is obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*

## The data consists of

* Test data folder
* Train data folder
* Activity_labels
* Features


## The run_analysis.R scrip 

* Checks if the data is already in the working directory
* If absent - downloads and unzips data
* if present - unzips data

#### Loads, reads as character 
* The second column of activity_labels, containing the labels
* The second column of features, containing the features

#### To obtain the observations on mean and standard deviation only
* Gets all the observation containing "mean" and all the observations containing std
* Substracts the characters that are not relevant

#### For the Train and Test folders
* Reads subject_train/test, X_train/test, Y_train/test
* Obtains train, test - For each folder merges subject, X, Y using cbind

#### mergedTrainTest - merges train and test
* For mergedTrainTest sets the column "activity" and "subject" as factor
* For activity factor with 6 levels and activity_labels as labels
* meltedMergedTT - melts mergedTrainTest with ids "subject" and "activity"
* meanMergedTT - Obtains the mean of each variable for each activity and each subject

#### Writes a new table called "tidy.txt"


## Activity labels
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING


## Tidy.txt is obtained from data where std and mean are applied to the following
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag