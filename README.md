## Getting-and-Cleaning-Data-Project

Created a R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject

Steps:

1. Set local working directory using the "setwd" command to the folder that has the UCI HAR Data set.
2. Install required packages (data.table, plyr, reshape2)
3. Use "read.table" to read the training and test data
4. Merge the files from step 3 into one data set. The columns are subject, activity (numeric code) and the associated data for each subject and activity
5. Names each of the columns of the dataset. Extracted the features data set to use as the column names for the data
6. Extracted the means and standard deviations from the data set
7. Converted the activity numbers to activity labels
8. Summarized the data by subject and activity and calculated the mean data vaules for each
9. Wrote this summary data to a text file (tidy.txt)