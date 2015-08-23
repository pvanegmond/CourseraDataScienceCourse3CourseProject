# CourseraDataScienceCourse3CourseProject

This Repo is for the course project for Course 3 of the Coursera Data Science Course.

##Getting and Cleaning Data

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 

##Deliverables:
1. a tidy data set as described below, 
2. a link to a Github repository with your script for performing the analysis, and 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md (this file) in the repo with your scripts. 
This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##How to run this applicaton
1. Download the run_analysis.R from github to your working directory
2. The program will download the required data to the directory "./data/C3P1" for analysis
3. The summary files will aso be created in the directroy "./data/C3P1"

##Further details
Please see the file CodeBook.md for the full program details.

##Repository Contents
1. README.md        - This file
2. run_analysis.R   - Code to perform data cleaning and summarising
2. CodeBook.md      - Docuementation for the code 
3. TidyData.txt     - Tidy data file create by the program
4. SummarisedDataApproach1.txt - Summarised data using lapply technique  
5. SummarisedDataApproach2.txt - Summarised data using melt and dcast technique
 

