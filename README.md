# Run-Analysis-Project
#Peer graded assignment:Getting and Cleaning Data Course Project#Working with data collected from the acceelerometers from the
Samsung Galaxy S smartphone#The purpose of this project is to demonstrate your ability to collect, work with, and clean a dataset. 
The goal is to prepare tidy#that can be used for later analysis. You will be required to submit: 1) a tidy dataset as described below, 
2) a link to the Github#repository with your script for performing analysis, and 3) a code book that describes the variables, the data, 
and any transformations#or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in 
the repo with your scripts.#This repo explains how all the scripts work and how they are connected.#You should create one R script
called run_analysis.R that does the following:#1) Merges the training and test sets to create one data set.#2) Extracts only the
measurements on the mean and standard deviation for each measurement#3) uses descriptive activity names to name the activities in 
the dataset#4) Appropriately labels the data set with descriptive variable names.#5) From the data set in sept 4, creates a second,
independent tidy data set with the average of each variable for each activity #and each subject

#here is the data for the project:#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#Set the working directory to where the file is unzipped: "C:/Coursera/UCI HAR Dataset"
#Read in all data from all the files and subfolders 
#Make column titles more appropriate to match what they are really called
#Bind together the columns representing training data and separately bind together the columns representing the test data
#step1- Merge the training data and the test data (that were each separately column bound)
#Step2- Data has been merged by there are a lot of extra variables that we do not need to consider in this analysis. We want to get
#rid of those extra variables and only keep variables pertaining to the subject ID, mean and standard deviations. Thus to do this,
#we need to tell R which variables pertaining are useful (TRUE) and which are not useful (!FALSE)
#grep is like the keep/drop statement in sas, the "..."function will tell R to select variables with anything similar to "mean" or "standard Deviation"
# in the title. Then we tell R to grep only the TRUE logicals

#Step 3- At this point only the data files relating to test and train have been merged. We called in the activity types dataset, but have 
#not done anything with it yet. Here, lets merge the activity dataset with the other dataset we have been working with up to this point
#(titled selected data based on the processing done in step 2)

#Step 4- Clean up the column names to something more readable. CODEBOOK described here
#Here is a summary of the changes that were made after we changed the column names
# Acc was replaced by Accelerometer
# Gyro was replaced by Gyroscope
# BodyBody was replaced by Body
# Mag was replaced by Magnitude
# If "t" was in the beginning of the phrase, it was replaced with "Time"
# If "f" was in the beginning of the phrase, it was replaced with "Frequency"
# tBody was replaced by TimeBody# All iterations of "-mean()" were replaced by "Mean"
# All iterations of "-std()" were replaced by "STD"
# All iterations of "-freq()" were replaced by "Frequency
# angle was replaced by Angle
# gravity was replaced by Gravity

#Step 5- From the dataset in step 4, create a second, independent tidy dataset with the average of each variable for each activity for each subject
#Use the aggregate or melt/dcast statement commands and output the tidydataset to a file
