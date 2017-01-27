#Peer graded assignment:Getting and Cleaning Data Course Project
#Working with data collected from the acceelerometers from the Samsung Galaxy S smartphone

#The purpose of this project is to demonstrate your ability to collect, work with, and clean a dataset. The goal is to prepare tidy
#that can be used for later analysis. You will be required to submit: 1) a tidy dataset as described below, 2) a link to the Github
#repository with your script for performing analysis, and 3) a code book that describes the variables, the data, and any transformations
#or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts.
#This repo explains how all the scripts work and how they are connected.

#You should create one R script called run_analysis.R that does the following:
#1) Merges the training and test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each measurement
#3) uses descriptive activity names to name the activities in the dataset
#4) Appropriately labels the data set with descriptive variable names.
#5) From the data set in sept 4, creates a second, independent tidy data set with the average of each variable for each activity 
#and each subject

#here is the data for the project:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Set the working directory to where the file is unzipped
getwd()


#Read in all data from all the files and subfolders 
test_subject_id <- read.table('./test/subject_test.txt' ,header=FALSE,col.names="subject_id");
testdata <- read.table('./test/X_test.txt' ,header=FALSE);
colnames(testdata) <- feature_names;
test_activity_id <- read.table('./test/y_test.txt' ,header=FALSE,col.names="activity_id");
train_subject_id <- read.table('./train/subject_train.txt' ,header=FALSE,col.names="subject_id");
traindata <- read.table('./train/X_train.txt' ,header=FALSE);
colnames(traindata) <- feature_names;
train_activity_id <- read.table('./train/y_train.txt',header=FALSE,col.names="activity_id");
activity_labels <- read.table('./activity_labels.txt',header=FALSE,col.names=c("activity_id", "activity_name"));
features <- read.table('./features.txt', header=FALSE);
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors = FALSE) #Answers_what are the features in the data? 
feature_names <-features[,2]
#All data has been read in from all files 

#Bind together the columns representing training data and separately bind together the columns representing the test data;
traindata <- cbind(train_subject_id,train_activity_id,traindata);
testdata <- cbind(test_subject_id,test_activity_id,testdata);
names(traindata)
names(testdata)

#step 1 Merge the training data and the test data (that were column bound)
if(!file.exists("./data")){dir.create("./data")}
install.packages("plyr")
library(plyr)
mergeData <- rbind(traindata,testdata)
head(mergeData)
names(mergeData)
columnNames <- colnames(mergeData)
head(columnNames)
#End of step one, training and testing datasets have been merged and a column names identifier has been created for easier processing

#Step 2- Data has been merged but there are a lot of extra variables that we do not need to consider in this analysis. We want
#to get rid of those extra variables and only keep variables pertaining to the suject ID, mean and standard deviations. Thus
#to to this, we need to tell R which variables are useful (TRUE) and which variables are unuseful (!FALSE). A better way is to use grep to pull
#all the data relevant to means and all the data relevant to standard deviations. then put those information pieces in separate folders 
#then merge them. In turn, these will need to be merged wit hthe activity levels dataset which is not included in the test and train data yet.
#grep is like keep/drop statement in sas, the "..."function will tell R to select variables with anything similar to "mean" or "std" in the title. The ! will tell it to not select those variables
#variableselection <- (grepl("activity..",columnNames) | grepl("subject..",columnNames) | grepl("-mean..",columnNames) & !grepl("-meanFreq..",columnNames) & !grepl("mean..-",columnNames) | grepl("-std..",columnNames) & !grepl("-std()...-",columnNames));
#Tell R to only keep the variables pulled from GREP that are TRUE
#selecteddata <-mergeData[variableselection==TRUE];
#selecteddata
#names(selecteddata)
#Pull/GREP all columns relevant to means (mean is in the name of the column) 
meanincolname <- grep("mean",names(mergeData),ignore.case=TRUE) 
#Put that pulled data of means information in a dataset called meanincolname 
meanincolname <- names(mergeData)[meanincolname] 
#Pull/GREP all columns relevant to std (using grep)
stdincolname <- grep("std",names(mergeData),ignore.case=TRUE) 
stdincolname <- names(mergeData)[stdincolname] 

#Step 3- At this point only the data files relating to test and train have been merged. We called in the activity types dataset,
#but have not done anything with it yet. Here, lets merge the activity dataset with the other dataset we have been working with up 
#to this point (titled selecteddata based on the processing done in step 2)
#Also note, the activity labels in the activities dataset are: walking2, walking_upstairs3, walking_downstairs4, sitting5, standing6 and laying
#Summarize specific means and standard deviations for subject id and activity id based on the merged dataset (pulling variables of use from train and test datasets only)
summarydata <-mergeData[,c("subject_id","activity_id",meanincolname,stdincolname)] 
#merge the data with the activity labels with the summary data (which up to that point only contains the training and test datasets)
completedata <- merge(activity_labels,summarydata,by.x="activity_id",by.y="activity_id",all=TRUE)unique(completedata$activity_name) #use this to look at all subheadings of a variable (simple proc freq but just with variable titles)
labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE) #Same use as Uniue()
labels #Labels is same as Unique
#Remove the underscores from the activityTypes and create descriptive activity names to name the activities in the dataset
completedata$activity_name<-as.character(sub("_","", completedata$activity_name))
unique(completedata$activity_name)
#update the column names after the merge
columnNames <- colnames(completedata)
#Step 3 is complete, descriptive activity names have been updated in the dataset

#Step 4-Clean up column names to something more readable
names(completedata) #here is what the column names look like now
#We want to  rename the columns so that anything with "-mean" in it at all will come up as "Mean" and anything 
#with "-std" in it at all will come up as simply "standard deviation", etc. Basically we need to make all the column titles more readable.

#Rename column titles using the names and gsub commands
names(completedata)<-gsub("Acc", "Accelerometer", names(completedata))
names(completedata)<-gsub("Gyro", "Gyroscope", names(completedata))
names(completedata)<-gsub("BodyBody", "Body", names(completedata))
names(completedata)<-gsub("Mag", "Magnitude", names(completedata))
names(completedata)<-gsub("^t", "Time", names(completedata))
names(completedata)<-gsub("^f", "Frequency", names(completedata))
names(completedata)<-gsub("tBody", "TimeBody", names(completedata))
names(completedata)<-gsub("-mean()", "Mean", names(completedata), ignore.case = TRUE)
names(completedata)<-gsub("-std()", "STD", names(completedata), ignore.case = TRUE)
names(completedata)<-gsub("-freq()", "Frequency", names(completedata), ignore.case = TRUE)
names(completedata)<-gsub("angle", "Angle", names(completedata))
names(completedata)<-gsub("gravity", "Gravity", names(completedata))
names(completedata)
#Here is a summary of the changes that were made after we changed the column names
# Acc was replaced by Accelerometer
# Gyro was replaced by Gyroscope
# BodyBody was replaced by Body
# Mag was replaced by Magnitude
# If "t" was in the beginning of the phrase, it was replaced with "Time"
# If "f" was in the beginning of the phrase, it was replaced with "Frequency"
# tBody was replaced by TimeBody
# All iterations of "-mean()" were replaced by "Mean"
# All iterations of "-std()" were replaced by "STD"
# All iterations of "-freq()" were replaced by "Frequency
# angle was replaced by Angle
# gravity was replaced by Gravity
columnNames <- colnames(completedata)
#Step 4 is complete

#Step 5- From the dataset in step 4, create a second, independent tidy data set with the average of each variable for each 
#activity and each subject
# use the aggregate function for where you would use proc means with a where statement in Sas (ie find the mean weight depending on diet or aggregate on time)
#Simple examples from http://davetang.org/muse/2013/05/22/using-aggregate-and-apply-in-r/
#Or use melt and dcast to create independent datasets, rows and mean/sum/summary functions
#first install reshape2 package
install.packages("reshape2")
library(reshape2)
num5melt <- melt(completedata,id=c("activity_id","activity_name","subject_id"))
tidydata <- dcast(num5melt, activity_id + activity_name + subject_id ~ variable,mean)
tidydata
#Step 5 is done

#Write the tidydata to a file 
write.table(tidydata, row.name=FALSE, file="./tidydata.txt")
