
# Getting and Cleaning Data Course Project"

## Original data set collection

The original data collection used on this proyect comes from the accelerometers study from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Tables and variable used from the original data collection
Original dataset contains a large number of files and restult table, but only a subset of then has been used on this project:

* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## New variables used 
Several new variables has been created to store the intermedial results of the study:

* xtrain <- contains the original values read from 'train/X_train.txt'
* xtest <- original values read fromm test/X_test.txt'
* xmerge <- contains the result of merge the training and test set

* features <- original values read from 'features.txt'
* meancol, stdcol <- subset of features with only the column names for mean and standard desviation variables
xmergemeanstd <- contains the result only for the measurements on the mean and standard deviation for each measurement 

* ytrain <- contains the original values read from 'train/y_train.txt'
* ytest <- original values read fromm test/y_test.txt'
* ymerge <- contains the result of merge the training and test activity data set
* activitylabels <- original vallues read from 'activity_labels.txt'
* xmergemeanstdact <- contains the result only for the measurements on the mean and standard deviation for each measurement with a new colum with the activity description

mycolnames <- contains the transformation of the vaiable names

subjecttrain <- original values read from 'train/subject_train.txt'
subjecttest <- original values read from 'test/subject_test.txt'
subjectmerge <- contains the result of merge the training and test subject data

## Final result 
tidy_date <- independent tidy data set with the average of each variable for each activity and each subject.  Contains 81 columns with the average values for the the meaurement of the meand and standard desviation group by subject and activity.  There are in total 180 rows.

## Transformations to be done
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How the transformation and verification has been done
Verify that the source directory exist.  The destination directory is created if does not exist
  
  
1. Merges the training and the test sets to create one data set.
  
Read the files X_test.txt and X_train.txt into xtest and xtrain table. 
Join two tables (xtest and xtrain) into xmerge using the function bind_rows.
First, we verify that the number of columns are the same in both tables.
Verify the number of columns and rows on the xmerge table.
  
2. Extracts only the measurements on the mean and standard deviation for each measurement.
 
Read the features.txt file and save it on the features variable.
Create a table (called col) with the mean and std values.  To do this, first we found all the elements with "mean" and "std", stored it in a vector called col and order it.
Extract only the mean and std column for the xmerge table.

  
3. Uses descriptive activity names to name the activities in the data set
  
Read the files Y_test.txt and Y_train.txt into ytest and ytrain table.
Join two tables (ytest and ytrain) into ymerge using the function bind_rows.
First, we verify that the number of columns are the same in both tables.  
Verify the number of columns and rows on the ymerge table.
Read the activity_labels.txt file into activitylabels.
Change the id with the descriptiion.  
Add a new column with the activity description to the xmergemeanstd table and saved in a new table xmergemeanstdact.
Verify number of rows.
  
  
4. Appropriately labels the data set with descriptive variable names.

Remove characters: ()-.
Use only lower case value.
    
5. From the data set in step 4, creates a second, independent tidy data set with the the average of each variable for each activity and each subject.

Read the files subject_test.txt and subject_train.txt into subjecttest and subjecttrain table.  
Join two tables (subjecttest and subjettrain) into subjectmerge using the function bind_rows.
First, we verify that the number of columns are the same in both tables.
Verify the number of columns and rows on the subjectmerge table.
Add column name.
Add a new column with the subject to the data set xmergemeanstdact and store it on a new data set xmergemeanstdactsub.
Group by activity and subject and calculate the average of each variable.
Write the tida_data table on the destination folder.
