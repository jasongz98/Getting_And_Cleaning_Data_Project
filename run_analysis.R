# downloading and unzipping data
if (!file.exists(filename)){
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UCI HAR Dataset.zip", method = "curl")
}
if (!file.exists("UCI HAR Dataset")){
	unzip("UCI HAR Dataset.zip")	
}

# reading text files into R
features = read.table("UCI HAR Dataset/features.txt", header = FALSE)
activities = read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test = read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test = read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train = read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Merging training and test tables together and providing variable names to make subsetting data easier in later steps
subjectData <- rbind(subject_test, subject_train)
x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
names(subjectData)<-c("subject")
names(y_data)<- c("activity")
names(x_data)<- features$V2
mergedData <- cbind(subjectData, y_data)
completeData <- cbind(x_data, mergedData)

# Extracting mean() and std() from the features table and create a subset of the completeData table
extractedFeatureValues <-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
subsetNames<-c(as.character(extractedFeatureValues), "subject", "activity")
completeData <- subset(completeData,select=subsetNames)

# Reading in Activity Labels and using descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activity_labels <- as.character(activity_labels[,2])
completeData$activity <- activity_labels[completeData$activity]

# Renaming variable names to make them more descriptive
names(completeData) <- gsub("^t", "time", names(completeData))
names(completeData) <- gsub("^f", "frequency", names(completeData))
names(completeData) <- gsub("Acc", "Accelerometer", names(completeData))
names(completeData) <- gsub("Gyro", "Gyroscope", names(completeData))
names(completeData)<-gsub("Mag", "Magnitude", names(completeData))

# Creating independent tidy data set with average of each variable for each activity and each subject
tidyDataSet <- aggregate(. ~activity + subject, completeData, FUN = mean)
write.table(x = tidyDataSet, file = "tidyData.txt", row.names = FALSE)