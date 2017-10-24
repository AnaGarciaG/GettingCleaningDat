run_analysis <- function(sourceDir = "./UCI HAR Dataset", destinationDir = "./UCI HAR Dataset/merge"){
  
  # Verify that the source directory exist.  If the destination directory is created if does not exist
  if (!file.exists(sourceDir)) stop ("Folder 'UCI HAR Dataset' not found")
  if (!file.exists(destinationDir)) {
    dir.create(destinationDir)
    print(paste("folder", destinationDir, "has been created" ))
  }  
  
  # 1. Merges the training and the test sets to create one data set.
  print("1. Merges the training and the test sets to create one data set.")
  # Read the files X_test.txt and X_train.txt into xtest and xtrain table
  print("    reading X_test table...")
  xtest <- read.table(paste(sourceDir,"/test/X_test.txt", sep = ""))
  print("    reading X_train table...")
  xtrain <- read.table(paste(sourceDir,"/train/X_train.txt", sep = ""))
  # Join two tables (xtest and xtrain) into xmerge using the function bind_rows
  # First, we verify that the number of columns are the same in both tables
  if (!(ncol(xtest) == ncol(xtrain))) stop ("Number of columns are not the same")
  library(dplyr)
  print("    merge...")
  xmerge <- bind_rows(xtest, xtrain)
  # Verify the number of columns and rows on the xmerge table
  if (!(ncol(xtest) == ncol(xmerge))) stop ("Error during the merge operation, incorrect number of columns")
  if (!((nrow(xtest) + nrow(xtrain)) == nrow(xmerge))) stop ("Error during the merge operation, incorrect number of columns")
   
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  print("2. Extracts only the measurements on the mean and standard deviation for each measurement.")
  # Read the features.txt file and save it on the features variable
  features <- read.table(paste(sourceDir,"/features.txt", sep = ""))
  # create a table (called col) with the mean and std values.  To do this, first we found all the elements with "mean" and "std", stored it in a vector called col and order it
  meancol <- grep("mean", features$V2)
  stdcol <-grep("std", features$V2)
  col <- sort(c(meancol, stdcol))
  # extract only the mean and std column for the xmerge table
  xmergemeanstd <- xmerge[, col]
  
  # 3. Uses descriptive activity names to name the activities in the data set
  print("3. Uses descriptive activity names to name the activities in the data set")
  # Read the files Y_test.txt and Y_train.txt into ytest and ytrain table
  print("   reading Y_test table...")
  ytest <-  read.table(paste(sourceDir,"/test/y_test.txt", sep = ""))
  print("   reading Y_train table...")
  ytrain <- read.table(paste(sourceDir,"/train/y_train.txt", sep = ""))
  # Join two tables (ytest and ytrain) into ymerge using the function bind_rows
  # First, we verify that the number of columns are the same in both tables
  if (!(ncol(ytest) == ncol(ytrain))) stop ("Number of columns are not the same")
  print("   merge...")
  ymerge <- bind_rows(ytest, ytrain)
  # Verify the number of columns and rows on the ymerge table
  if (!(ncol(ytest) == ncol(ymerge))) stop ("Error during the merge operation, incorrect number of columns")
  if (!((nrow(ytest) + nrow(ytrain)) == nrow(ymerge))) stop ("Error during the merge operation, incorrect number of columns")

  # read the activity_labels.txt file into activitylabels
  activitylabels <- read.table(paste(sourceDir,"/activity_labels.txt", sep = ""))
  # change the id with the descriptiion
  ymerge[["V1"]] <- activitylabels[ match(ymerge[['V1']], activitylabels[['V1']] ) , 'V2']
  #add a new column with the activity description to the xmergemeanstd table and saved in a new table xmergemeanstdact
  # verify number of rows
  if (!(nrow(ymerge) == nrow(xmergemeanstd))) stop("Incorrect number of rows between activity description and dataset")
  xmergemeanstdact <- cbind(xmergemeanstd,ymerge)
  
  # 4. Appropriately labels the data set with descriptive variable names.
  print("4. Appropriately labels the data set with descriptive variable names.")
  mycolnames <- features[col,]
  mycolnames <- mycolnames$V2
  mycolnames.clean <- tolower(mycolnames)
  mycolnames.clean <- sub("\\(", "", mycolnames.clean)
  mycolnames.clean <- sub("\\)", "", mycolnames.clean)
  mycolnames.clean <- gsub("-", "", mycolnames.clean)
  mycolnames.clean <- c(mycolnames.clean,"activity")
  colnames(xmergemeanstdact) <- mycolnames.clean

  
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  print("5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.")
  # Read the files subject_test.txt and subject_train.txt into subjecttest and subjecttrain table
  print("    reading subject_test table...")
  subjecttest <- read.table(paste(sourceDir,"/test/subject_test.txt", sep = ""))
  print("    reading subject_train table...")
  subjecttrain <- read.table(paste(sourceDir,"/train/subject_train.txt", sep = ""))
  # Join two tables (subjecttest and subjettrain) into subjectmerge using the function bind_rows
  # First, we verify that the number of columns are the same in both tables
  if (!(ncol(subjecttest) == ncol(subjecttrain))) stop ("Number of columns are not the same")
  print("    merge...")
  subjectmerge <- bind_rows(subjecttest, subjecttrain)
  # Verify the number of columns and rows on the subjectmerge table
  if (!(ncol(subjecttest) == ncol(subjectmerge))) stop ("Error during the merge operation, incorrect number of columns")
  if (!((nrow(subjecttest) + nrow(subjecttrain)) == nrow(subjectmerge))) stop ("Error during the merge operation, incorrect number of columns")

  # Add column name
  colnames(subjectmerge) <- "subject"
  # Add a new column with the subject to the data set xmergemeanstdact and store it on a new data set xmergemeanstdactsub
  xmergemeanstdactsub <- cbind(xmergemeanstdact,subjectmerge)
  tidy_data <- aggregate(. ~subject + activity, xmergemeanstdactsub, mean)
  # Write the tida_data table on the destination folder
  print(paste("    Write file tidy_data.txt on the destination folder", destinationDir))
  write.table(tidy_data, paste(destinationDir,"/","tidy_data.txt", sep = ""))
}       