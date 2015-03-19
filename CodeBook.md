---
title: "CodeBook.md"
output: html_document
---

Coursera Getting and Cleaning Data  
Course Project  
Cleaning Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
---
Erin Gordon-Wong  
March 2015  
---

###Project Description
The script run-analysis.R takes raw data from Human Activity Recognition Using Smartphones Dataset and returns a tidy data set. 

### Study Design
The raw data is collected from UCI's Human Activity Recognition Using Smartphone Dataset.  
More information about the collection of the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

---
This code book contains:

- DATASET: Describes the data set, tidy_data
- VARIABLES: Descriptions of the variables in tidy_data set
- DATA DESCRIPTION: A description of the data in tidy_data
- RECIPE: The step-by-step transformations performed to clean up the data found in Human Activity Recognition Using Smartphones Data Set to generate the tidy_data

---
### DATASET:
The dataset tidy_data.txt has 180 rows and 68 columns.  Each row is uniquely identified by the volunteer identifier (SubjectID) and the activity the volunteer performs (Activity).  The tidy_data provides the mean of the feature measurements for the volunteer during a particular activity (columns 3-68, for example: "tBodyAcc-mean()-X")

### VARIABLES:

- SubjectID: Identifies the volunteer subject
    * Class: Int
    * Unique Values: 30
    * Unit: NA
- Activity: Gives a short description of the activity the volunteer performed.  
    * Class: Factor
    * Levels: 6, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
    * Unit: NA
- Remaining features (columns 3-68): The remaining columns are the AVERAGE measurement collected for each volunteer performing each activity. 
    * Class: Num
    * Unit: NA
    * Note: For this tidy set, we are only interested in measurements for mean and standard deviation.  Measurements describing features of the mean, such as meanFreq, are NOT included.  

### RECIPE:
**To properly run run_analysis.R, the data must be found in the working directory.** More information can be found in README

1.  Merges the training and the test sets to create one data set.
    * The following files are read into R using read.table:
		1. features.txt , This file is then converted to character with as.character and subsetted to only keep the second column (the feature names)
		2. activity_labels.txt
		3. subject_train.txt
		4. y_train.txt 
		5. X_train.txt
		6. subject_test.txt
		7. y_test.txt
		8. X_test
    * The training data is combined into one data set using cbind.
    * Similarly, The test data is combined into one data set using cbind.
	* The training data and test data are combined into one data set using rbind. 
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
	* Assigned descriptive labels to columns of combined data set using colnames from Features list.  
	* Subsets the combined raw data to keep only columns with strings "SubjectID", "Activity", or any Features with "mean" or "std" in label using grep.
	* Note: Only measurements ending in "-mean()" or "-std()" were considered.  For instance, "-meanFreq" was excluded.
	3. Uses descriptive activity names to name the activities in the data set
	* Converted Activity column to character, then assigned descriptive activity label.  Activity column converted back to factor.
4. Appropriately labels the data set with descriptive variable names. 
	* Completed in Step 2.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	* Used dplyer package to group by individual subject, then by activity.  Used summarise_each (funs(mean)) to find the summary of each column by each group_by row (SubjectID by Activity).
	* This provides the tidy data set. 
	* Used write.table to create text file, tidy_data.txt.

---
### SOURCES
1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
2. Coursera 'Getting and Cleaning Data' Discussion Forums: Tidy data and the Assignment
3. Coursera 'Getting and Cleaning Data' Discussion Forums: David's personal course project FAQ
4. Coursera 'Getting and Cleaning Data' Discussion Forums: What makes a good codebook?
5. swirl "Getting and Cleaning Data"
