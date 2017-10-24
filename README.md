# GettingCleaningDat
Peer-graded Assignment: Getting and Cleaning Data Course Project


## Funtions and parameters

Function name: run_analysis.R
Parameters:
* sourceDir <- directory with the "UCI HAR Dataset"
  Default value = "./UCI HAR Dataset"
  If the "UCI HAR Dataset" directorie does not exist, an error is raised
* destinationDir = destination directory for the tidy_data.txt file
  Default vale = "./UCI HAR Dataset/merge"
  If destinationDir does not exist is created
  
## Library
* dplyr

## How to execute
source("run_analysis.R")
run_analysis()

During the execution, several messages and feedback are displayed.  

### If everithing is correct, the execution generate on the console following messages:
source("run_analysis.R")  
run_analysis()  

1. Merges the training and the test sets to create one data set.  
    reading X_test table...  
    reading X_train table...  
    merge...  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set . 
   reading Y_test table...  
   reading Y_train table...  
   merge...  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
    reading subject_test table...  
    reading subject_train table...  
    merge...  
    Write file tidy_data.txt on the destination folder ./UCI HAR Dataset/merge . 

### In case of error the execution is broken and an error message is displayed.
run_analysis(sourceDir = "./incorrectFolder")

Error in run_analysis(sourceDir = "./incorrectFolder") :   
  Folder 'UCI HAR Dataset' not found
