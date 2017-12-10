---
title: "Getting and Cleaning Data Project"
author: "Spence Varadi"
date: "Friday, March 20, 2015"
output:
  html_document:
    toc: true
    theme: united
---
##Introduction

The `run_analysis.R` script in this repo combines, recodes, subsets, cleans, and aggregates data found in the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI Human Activity Recognition Using Smartphones</a> dataset.

A `codebook.mb` is provided to describe variables

This analysis was conducted as a course project for <a href="https://class.coursera.org/getdata-012">Getting and Cleaning Data"</a> offered by Johns Hopkins Bloomsberg School of Public Health via Coursera.org

Data is provided courtesy of:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


##Overview
`run_analysis.R` completes the following data cleaning steps to create a tidy dataset:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Question 1
###Merges the training and the test sets to create one data set.
The first step creates more descriptive testing and training sets by merging the subject identifier column and activity identifier columns into both the test and train sets.
Then, the train and test sets are combined with rbind to create one data set names from the features.txt file provided descriptive column names which will be used for subsetting later.
This can be shown by running the following (ommiting excess)

```
View(Q1)
```

##Question 2
###Extracts only the measurements on the mean and standard deviation for each measurement. 

`grepl()` was used to select columns containing either "mean()" or "std()":

```
targetCols <- (grepl("mean()", names(bigSet)) | grepl("std()", names(bigSet)))
```

The "subject" and "activity" columns were required as well, hence:

```
targetCols[c(1,2)] <- TRUE
```

Finally, `smallSet <- bigSet[,targetCols]` generates the data set required for question 2 as shown by running

```
View(Q2)
```


##Question 3
###Uses descriptive activity names to name the activities in the data set
Already done

##Question 4
###Appropriately labels the data set with descriptive variable names. 
Already Done

```
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
index <- (grepl("mean()", features[,2]) | grepl("std()", features[,2]))
newNames <- as.character(features[,2][index])
##Better include subject and activity
newNames <- c("subject","activity",newNames)
colnames(smallSet) <- newNames
rm(features,index,newNames)
Q4 <- names(smallSet)
```

They are quite ugly names, but also descriptive

##Question 5
###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This step is accomplished with an `aggregate()` function that returns the means of all other variables by `subject` and `activity`. A dataframe called `Q5` is tidy because it contains one observation per row, each variable is an independent column, no variable is repeated, and it contains one type of data (aggregated sensor data per activity and subject).

```
tidy <- aggregate(. ~ subject + activity, data=smallSet, mean)
Q5 <- tidy
View(Q5)
```
