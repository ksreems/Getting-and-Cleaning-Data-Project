The R script, run_analysis.R, does the following:
1. Load the subject, activity and features data
2. Combine the training and test rows for subject, activity and features respectively
3. Set names for the subject, activity and features variables
4. Merge subject, activity and features columns to create one data set
5. Get only columns with mean or std in their names so as to get the measurements on the mean and standard deviation for each measurement
6. Load the activity labels data and match the activity value with the activity labels
7. Label the features data with descriptive variable names
8. Create a tidy dataset that consists of the average value of each variable for each subject and each activity.
9. The end result is shown in the file tidy.txt.
