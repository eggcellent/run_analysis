---
title: "README"
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

The script run-analysis.R takes raw data from Human Activity Recognition Using Smartphones Dataset and returns a tidy data set.  
Running the script creates a new dataset, **tidy_data.txt**, which returns the mean for feature mean and std features by subject volunteer and activity performed.  
The script will outline the steps of tidying.  Details can be found in CodeBook.md
The tidy_data.txt dataset can be read into R using read.table("tidy_data.txt", header=TRUE)  

The script includes the following files:

- README.md
- Codebook.md
- run_analysis.R

**To properly run run_analysis.R, the data must be found in the working directory.** 
The data can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script run_analysis.R reads data from the following files:

- features_info.txt
- features.txt
- activity_labels.txt
- train/X_train.txt
- train/y_train.txt
- test/X_test.txt
- test/y_test.txt

More information on the creation of the tidy data set can be found in the CodeBook
