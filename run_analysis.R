#For printing tables in markdown file
#library(pander)

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.

##I'll need this
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
colnames(features) <- c("index","feature")

##testset creation (easier to figure out first because of smaller size)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

test <- cbind(subject_test, y_test, x_test)
colnames(test) <- c("subject","activity",paste(features[,2]))
rm(subject_test,x_test,y_test)



##Create training set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

train <- cbind(subject_train, y_train, x_train)
colnames(train) <- c("subject","activity",paste(features[,2]))
rm(features,subject_train,x_train,y_train)

##Combine training and testing set (suppose training would come first)
bigSet <- rbind(train,test)
rm(train,test)

##Dar she blows
View(bigSet)
str(bigSet)
##Each row is an independent observation of sensor reading over time
##Activities are still repeated, however
Q1 <- bigSet


####################################################################

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

##Because I am lazy, find me means and stds for me
targetCols <- (grepl("mean()", names(bigSet)) | grepl("std()", names(bigSet)))
##Better include subject and activity
targetCols[c(1,2)] <- TRUE
smallSet <- bigSet[,targetCols]
rm(targetCols)
##Each observation contains only variables of interest now
Q2 <- smallSet



####################################################################

# 3. Uses descriptive activity names to name the activities in the data set

##activity_labels file is really small and could just be copied and pasted into a switch function. Here ya go.

smallSet$activity<- lapply(smallSet$activity, function(x)switch(x,
                                              "1"= "WALKING",
                                              "2"= "WALKING_UPSTAIRS",
                                              "3"= "WALKING_DOWNSTAIRS",
                                              "4"= "SITTING",
                                              "5"= "STANDING",
                                              "6"= "LAYING"
))
##Convert from list into character
smallSet$activity <- as.character(smallSet$activity)
Q3 <- smallSet$activity
##A much more descriptive activity variable is in there


####################################################################

# 4. Appropriately labels the data set with descriptive variable names. 

##I...am pretty sure that I have when I merged the datasets so I could subset later
##But lets do it again
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
colnames(smallSet) <- c("subject","activity",paste(features[,2][ (grepl("mean()", 
                        names(bigSet)) | grepl("std()", names(bigSet)))]))
rm(features)
Q4 <- names(smallSet)
##They are ugly, but pretty descriptive

####################################################################

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(. ~ subject + activity, data=smallSet, mean)
Q5 <- tidy

write.table(tidy,"tidy.txt", row.names=FALSE)
