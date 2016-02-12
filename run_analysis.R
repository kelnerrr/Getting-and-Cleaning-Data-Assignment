# Data descritpion: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Load packages
library(plyr)

#####
# 1. Merges the training and the test sets to create one data set.
pathDir <- file.path(getwd(), "..", "UCI HAR Dataset")

x_train <- read.table(file.path(pathDir, "train", "X_train.txt"))
y_train <- read.table(file.path(pathDir, "train", "y_train.txt"))
subject_train <- read.table(file.path(pathDir, "train", "subject_train.txt"))

x_test <- read.table(file.path(pathDir, "test", "X_test.txt"))
y_test <- read.table(file.path(pathDir, "test", "y_test.txt"))
subject_test <- read.table(file.path(pathDir, "test", "subject_test.txt"))

# create datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

#####
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table(file.path(pathDir, "features.txt"))

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

#####
# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table(file.path(pathDir, "activity_labels.txt"))

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

#####
# 4. Appropriately labels the data set with descriptive variable names.

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

#####
# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.

# averages data (without activity & subject columns)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)