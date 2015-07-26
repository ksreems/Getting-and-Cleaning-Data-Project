# Read in subject, activity and features data
TrainSubject <- read.table("subject_train.txt", header = FALSE)
TestSubject <- read.table("subject_test.txt", header = FALSE)
TrainActivity <- read.table("y_train.txt", header = FALSE)
TestActivity <- read.table("y_test.txt", header = FALSE)
TrainFeatures <- read.table("X_train.txt", header = FALSE)
TestFeatures <- read.table("X_test.txt", header = FALSE)

# Read in features
features <- read.table("features.txt", header = FALSE)

# Combine data tables by rows
AllSubject <- rbind(TrainSubject, TestSubject)
AllActivity <- rbind(TrainActivity, TestActivity)
AllFeatures <- rbind(TrainFeatures, TestFeatures)

# Set names for variables
names(AllSubject) <- c("subject")
names(AllActivity) <- c("activity")
names(AllFeatures) <- features[,2]

# 1. Merge columns of subject, activity and features to create one data set
AllData <- cbind(AllSubject, AllActivity, AllFeatures)

# 2. Extract only the measurements on mean and standard deviation for each measurement

# Get only columns with mean() or std() in their names
mean_and_std_features <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# Subset the desired mean and std columns
MeanStdData <- AllData[, mean_and_std_features]

# 3. Use decriptive activity names to name the activities in the data set

# Read in activity labels
activities <- read.table("activity_labels.txt", header=FALSE)

# Update activity values with activity names
MeanStdData$activity <- activities[MeanStdData$activity, 2]

# 4. Appropriately label the data set with descriptive variable names

# Names of features will labelled using descriptive variable names
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by freq
# Mag is replaced by Magnitude
# BodyBody is replaced by Body
# std is replaced by StdDev

names(MeanStdData) <- gsub("^t", "time", names(MeanStdData))
names(MeanStdData) <- gsub("^f", "frequency", names(MeanStdData))
names(MeanStdData) <- gsub("Acc", "Accelerometer", names(MeanStdData))
names(MeanStdData) <- gsub("Gyro", "Gyroscope", names(MeanStdData))
names(MeanStdData) <- gsub("Mag", "Magnitude", names(MeanStdData))
names(MeanStdData) <- gsub("BodyBody", "Body", names(MeanStdData))
names(MeanStdData) <- gsub("std", "StdDev", names(MeanStdData))

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Melt MeanStdData 
MeanStdData.melted <- melt(MeanStdData, id = c("subject", "activity"))

# Pass mean function to the melted data to summarize the data
MeanStdData.mean <- dcast(MeanStdData.melted, subject + activity ~ variable, mean)

# Write as txt file
write.table(MeanStdData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
