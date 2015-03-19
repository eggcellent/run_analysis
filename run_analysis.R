##  The script run-analysis.R takes raw data on activity trackers and returns a tidy data set.  Details:
    #   1.  Merges the training and the test sets to create one data set.
    #   2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
    #   3. Uses descriptive activity names to name the activities in the data set
    #   4. Appropriately labels the data set with descriptive variable names. 
    #   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function() {
#   1.  Merges the training and the test sets to create one data set.
    ## Find files in data folder and read.
    #   Reads and returns feature label names (column 2)
    library(dplyr)
    feat_names <- read.table("./data/UCI HAR Dataset/features.txt")
    features <- as.character(feat_names[,2])
    activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
    ## Train
    #   Reads subject_train (Subject ID used for training data)
    raw_subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    #   Reads y_train (Activity ID for each row)
    raw_y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
    #   Reads X_train  (Features data used for training data)
    raw_X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    #   Combines all train columns
    raw_train_data <- cbind(raw_subject_train, raw_y_train, raw_X_train)
    ##Test
    #   Reads subject_test (Subject ID used for testing data)
    raw_subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    #   Reads y_test (Activity ID for each row)
    raw_y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
    #   Reads X_test (Features data used for testing data)
    raw_X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    #   Combines all test columns
    raw_test_data <- cbind(raw_subject_test, raw_y_test, raw_X_test)
    ## Combine train and test data
    raw_data <- rbind(raw_train_data, raw_test_data)
    print(paste0(("Step 1 Complete: Train and Test data combined to one data set, with dimensions "), dim(raw_data)[1]," x ",dim(raw_data)[2]))
#   2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
   ## Subset the data matching strings "mean" or "std" in column names
    colnames(raw_data) <- c("SubjectID", "Activity", features)  ##See also Step 4
    data_sub <- raw_data[,grepl(("SubjectID|Activity|(mean\\())|std"),colnames(raw_data))]
print(paste0(("Step 2 Complete: Extracted only 'mean' and 'std' measurements; dimensions "), dim(data_sub)[1]," x ",dim(data_sub)[2]))
    #data_sub <- select(raw_data, matches("(SubjectID)|(Activity)|(mean)+|(std)+", ignore.case=T))
#   3. Uses descriptive activity names to name the activities in the data set
    data_sub$Activity <- as.character(data_sub$Activity)
    data_sub$Activity[data_sub$Activity==1] <- as.character(activity_labels[1,2])
    data_sub$Activity[data_sub$Activity==2] <- as.character(activity_labels[2,2])
    data_sub$Activity[data_sub$Activity==3] <- as.character(activity_labels[3,2])
    data_sub$Activity[data_sub$Activity==4] <- as.character(activity_labels[4,2])
    data_sub$Activity[data_sub$Activity==5] <- as.character(activity_labels[5,2])
    data_sub$Activity[data_sub$Activity==6] <- as.character(activity_labels[6,2])
    data_sub$Activity <- as.factor(data_sub$Activity)
    data_sub$SubjectID <- as.factor(data_sub$SubjectID)
print(paste0(("Step 3 Complete: Added descriptive activity names; dimensions "), dim(data_sub)[1]," x ",dim(data_sub)[2]))
#   4. Appropriately labels the data set with descriptive variable names. 
    ## Completed in Step 2
print(paste0(("Step 4 Complete: Appropriately labeled columns with descriptive variable names; dimensions "), dim(data_sub)[1]," x ",dim(data_sub)[2]))
#   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    ##INTERPRETATION OF STEP 5:  For this step, the data will first be grouped by SubjectID, then Activity, and each variable will be averaged off of this subset.  This will provide an average (of mean or std) for each subject based on the activity performed.  
    ddata <- tbl_df(data_sub)
    ddata_ord <- ddata %>% group_by(SubjectID, Activity)
    tidy_data_set <- summarise_each(ddata_ord, funs(mean))   
    write.table(tidy_data_set, file = "tidy_data.txt", row.names=F)
    print(paste0(("Step 5 Complete: Created, tidy_data.txt, independent tidy data set with the average of each variable for each activity and each subject; dimensions "), dim(tidy_data_set)[1]," x ",dim(tidy_data_set)[2]))
}