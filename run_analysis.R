# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject

# set local working directory using the "setwd" command to the folder that has the UCI HAR Data set.

if (!require("data.table")) {
        install.packages("data.table")
}

if (!require("reshape2")) {
        install.packages("reshape2")
}

if (!require("plyr")) {
        install.packages("plyr")
}
require("data.table")
require("reshape2")
require("plyr")


###Load all training and test data
subject.train <- read.table('./train/subject_train.txt',header=FALSE);
data.train <- read.table('./train/x_train.txt',header=FALSE);
label.train <- read.table('./train/y_train.txt', header = FALSE)
subject.test<- read.table('./test/subject_test.txt',header=FALSE); 
data.test <- read.table('./test/x_test.txt',header=FALSE); 
label.test <- read.table('./test/y_test.txt',header=FALSE); 

#Merge into one data set

test.train.data <- rbind(cbind(subject.train, label.train, data.train), cbind(subject.test, label.test, data.test))

#Load the features
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)[,2]

#Name columns
colnames(test.train.data)[3:563] <- features
colnames(test.train.data)[1] <- "subject"
colnames(test.train.data)[2] <- "activity"
# names(test.train.data)

##Extracts only the measurements on the mean and standard deviation for each measurement. 
test.train.data <- test.train.data[ , grep("subject|activity|mean|std", names(test.train.data))]

#Uses descriptive activity names to name the activities in the data set
test.train.data$activity <- factor(test.train.data$activity, levels = c(1, 2, 3, 4, 5, 6), labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))

#Summarize the data

summary_data <- ddply(test.train.data, .(subject, activity), numcolwise(mean))

#create tidy data set
write.table(format(summary_data, scientific=T), "tidy.txt",
            row.names=F, col.names=F, quote=2)
