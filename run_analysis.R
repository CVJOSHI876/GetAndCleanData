humanActivityRecognition <- function()
{
  # install following packages if not already installed.
  install.packages("plyr")
  install.packages("dplyr")
  #load packages
  library(stringr)
  library(plyr)
  library(dplyr)
  
  # set working directory
  workingDir <- setwd("c:/MyWork/Coursera/DS/R_Programming")
  
  #Read features and activities
  features <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
  activities <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
  
  
  ## Read and combine training data
  subTraining <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
  xTraining <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
  yTraining <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
  combinedTrainData <- cbind(subTraining,xTraining,yTraining)

  # Read and combine test data
  subTest <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
  xTest <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
  yTest <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
  combinedTestData <- cbind(subTest,xTest,yTest)

  # Merge training and test data sets
  finalData <-rbind(combinedTrainData,combinedTestData)
  
  listofFeatures <- as.character(features[,2])
  listofFeatures <- make.names(listofFeatures,unique=TRUE)
 
  # Set column names of merged data set
  names(finalData) <-c("subjects",listofFeatures,"activity")
  labels <- c("1","2","3","4","5","6")
  descLabels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
 
  finalData$activity <- as.factor(finalData$activity)
 
  #Uses descriptive activity names to name the activities in the data set
  finalData$activity <- mapvalues(finalData$activity,from=labels,to=descLabels,warn_missing=TRUE)
  
  #Extracts the mean and standard deviation for each measurement from merged data. 
  finalData <- select(finalData,subjects,activity,contains(".mean."),contains(".std."))

 
  #Appropriately label the data set with descriptive variable names
  for(i in 3:68)
  {
    if(str_detect(names(finalData)[i],"[.]std"))
    {
      names(finalData)[i] <- paste0("StandardDeviation", str_replace(names(finalData)[i], "[.]std", ""))
    }
   
  }
 
  for(i in 3:68)
  {
    if(str_detect(names(finalData)[i],"[.]mean"))
    {
      names(finalData)[i] <- paste0("Mean", str_replace(names(finalData)[i], "[.]mean", ""))
    }
   
  }
    #Appropriately label the data set with descriptive variable names
   names(finalData) <- str_replace_all(names(finalData),"[.][.]","")
   names(finalData) <- str_replace_all(names(finalData),"BodyBody","Body")
   names(finalData) <- str_replace_all(names(finalData),"tBody","Body")
   names(finalData) <- str_replace_all(names(finalData),"fBody","FFTBody")
   names(finalData) <- str_replace_all(names(finalData),"tGravity","Gravity")
   names(finalData) <- str_replace_all(names(finalData),"fGravity","FFTGravity")
   names(finalData) <- str_replace_all(names(finalData),"Acc","Acceleration")
   names(finalData) <- str_replace_all(names(finalData),"Gyro","AngularVelocity")
   names(finalData) <- str_replace_all(names(finalData),"Mag","Magnitude")
   names(finalData) <- str_replace_all(names(finalData),"[.]X","XAxis")
   names(finalData) <- str_replace_all(names(finalData),"[.]Y","YAxis")
   names(finalData) <- str_replace_all(names(finalData),"[.]Z","ZAxis")
  

    #Create new and independent tidy data set
   tidyData <- aggregate(finalData[,names(finalData)!= c("subjects","activity")],by=list(subjectId=finalData$subject,activityType=finalData$activity),mean)
  
    # write tidy data set to a file.
   write.table(tidyData, "./tidyData.txt",row.names=FALSE,sep='\t')
  
   #clean up temporary objects for better performance
   rm(finalData)
   rm(subTraining)
   rm(xTraining)
   rm(yTraining)
   rm(subTest)
   rm(xTest)
   rm(yTest)
   rm(features)
   rm(activities)
   rm(combinedTrainData)
   rm(combinedTestData)
   rm(listofFeatures)
  
  }