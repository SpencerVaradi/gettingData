#For printing tables in markdown file
#library(pander)

# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
activityLabels <- read.table("activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

##I'll need this
features <- read.table("features.txt",header=FALSE)
colnames(features) <- c("index","feature")

##testset creation (easier to figure out first because of smaller size)
subject_test <- read.table("test/subject_test.txt",header=FALSE)
x_test <- read.table("test/X_test.txt",header=FALSE)
y_test <- read.table("test/y_test.txt",header=FALSE)

test <- cbind(subject_test, y_test, x_test)
colnames(test) <- c("subject","activity",paste(features[,2]))
rm(subject_test,x_test,y_test)




##Create training set
subject_train <- read.table("train/subject_train.txt",header=FALSE)
x_train <- read.table("train/X_train.txt",header=FALSE)
y_train <- read.table("train/y_train.txt",header=FALSE)

train <- cbind(subject_train, y_train, x_train)
colnames(train) <- c("subject","activity",paste(features[,2]))
#rm(features,subject_train,x_train,y_train)

##Combine training and testing set (suppose training would come first)
bigSet <- rbind(train,test)
bigSet$activity <- factor(bigSet$activity, levels = activityLabels[,1], labels = activityLabels[,2])
bigSet$subject <- factor(bigSet$subject)

rm(train,test)

Q1 <- bigSet


####################################################################

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

##Because I am lazy, find me means and stds for me
targetCols <- (grepl("*.mean.* | *.std.*", names(bigSet)))
##Better include subject and activity
targetCols[c(1,2)] <- TRUE
smallSet <- bigSet[,targetCols]
rm(targetCols)
##Each observation contains only variables of interest now
Q2 <- smallSet



####################################################################

# 3. Uses descriptive activity names to name the activities in the data set

## Already done


####################################################################

# 4. Appropriately labels the data set with descriptive variable names.
## Already done


####################################################################

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(. ~ activity + subject, data= smallSet, mean)
tidy <- tidy[,c(2,1,3:ncol(tidy))]
Q5 <- tidy

write.table(tidy,"tidy.txt", row.names=FALSE)

