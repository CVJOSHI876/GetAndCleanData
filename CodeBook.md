					CodeBook
### Purpose:
The document describes the variables, the data, and the transformations or work that is performed to clean up the data and create new tidy data set for further analysis.

### Original Data Source:
The original data source that was used to create new tidy data set is from below site:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### The Data:
The input data set include following files
features.txt -		List all features  
activity_labels - 	Links the class labels with their activity name  
X_train.txt-		Training data set  
Y_train.txt - 		Training labels  		 
X_test,txt - 		Test data set  
Y_test.txt - 		Test labels  

### Transformation Details:
The R script called run_analysis.R is written which perfrom following steps

Merges the training and the test sets to create one data set.  
Extracts only the measurements on the mean and standard deviation for each measurement.  
Uses descriptive activity names to name the activities in the data set  
Appropriately labels the data set with descriptive variable names.  
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### How run_analysis.R implements above steps:

Use plyr, dplyr,and stringr packages  
Read and combine training data sets  
Read and combine test data sets  
Merge training and test data sets created in setps 2 and 3 above to create final data set  
Extract mean and deviation columns from final data set  
Set names for final data set  
Create new, independent tidy data set  
Write tidy data set to a file called tidyData.txt  
Clean up temporary objects/data frames to improve performance  

### The Variables:
The R script - run_analysis uses following variables to carry out above steps

workingDir - working directory
features - List of all features withing the time window measurement  
activities - stores activity the use perform  
subTraining - Who perform the activity ( training) for each window  
xTraining - Training data set  
yTraining- Training labels  
subTest - Who perform the activity ( test ) for each window  
xTest - Test data set  
yTest - Test labels  
combinedTrainData - combined training data sets ( x, y and subject)  
combinedTestData - combined test data sets  
labels - activity code  
descLabels- activity labels/description  
finalData - Megerd data set  
tidyData - new, independent and cleaned data set  

### Running run_analysis.R
Please refer to README.md file for detailed instruction to run R script.

