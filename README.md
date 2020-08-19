# Getting and Cleaning Data Final Course Project

## Explaining the Script Step by Step

1. The first step in this assignment is to check if the relevant zip and data folders are downloaded. If not, the script will download and unzip the data set.

2. The next step is to read in all relevant text files into R. These text files are features.txt, activity_labels.txt, test/subject_test.txt, test/X_test.txt, test/y_test.txt, train/subject_train.txt, train/X_train.txt, and train/y_train.txt.

3. Once all text files have been read in, the next step is to merge training and test tables together using rbind() and cbind(). The tables that will be put together are based on the dimensions of the table, so checking the dimensions of each table through the dim() command will prove useful for this step. Before merging the newly merged subject_data and y_data, variable names should be provided for subject_data, y_data, and x_data. This will allow the data to be much easier to subset in the next step.

4. The next step is to extract only the measurements on the mean and standard deviation for each measurement. This is done using the grep function to filter out the relevant mean() and std() variables in the features table. Once that is done, the filtered column names along with subject and activity are moved into a subset of the completeData file, and the subset replaces the previously untidy data set.

5. The next step in this script is to read in the activity labels from the activity_labels.txt file in the dataset folder and put them in the completeData file. These activity labels are used to label each activity in the data set with its appropriate descriptive activity name. 

6. After moving the descriptive activity names into the data set, the variable names should be renamed with more descriptive words to make the data clearer. Using features_info.txt as a reference, variable names should be renamed appropriately. For example, the t at the start of numerous variables should be renamed to time to make it less ambiguous. Other parts of variables that should be renamed are f (frequency), Acc (accelerometer), Gyro (Gyroscope), and Mag (Magnitude). 

7. The final step in this script is to create an independent tidy data set with the average of each variable for each activity and each subject. The mean of each variable can be calculated using the aggregate function for the appropriate variables. Once that is done, the write.table function is used to create the txt file for the tidy data set.
