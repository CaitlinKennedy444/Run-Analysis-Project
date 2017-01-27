names(finalData)<-gsub("Acc", "Accelerometer", names(finalData))
names(finalData)<-gsub("Gyro", "Gyroscope", names(finalData))
names(finalData)<-gsub("BodyBody", "Body", names(finalData))
names(finalData)<-gsub("Mag", "Magnitude", names(finalData))
names(finalData)<-gsub("^t", "Time", names(finalData))
names(finalData)<-gsub("^f", "Frequency", names(finalData))
names(finalData)<-gsub("tBody", "TimeBody", names(finalData))
names(finalData)<-gsub("-mean()", "Mean", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-std()", "STD", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-freq()", "Frequency", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("angle", "Angle", names(finalData))
names(finalData)<-gsub("gravity", "Gravity", names(finalData))names(finalData)
#Here is a summary of the changes that were made after we changed the column names
# Acc was replaced by Accelerometer
# Gyro was replaced by Gyroscope
# BodyBody was replaced by Body
# Mag was replaced by Magnitude
# If "t" was in the beginning of the phrase, it was replaced with "Time"
# If "f" was in the beginning of the phrase, it was replaced with "Frequency"
# tBody was replaced by TimeBody# All iterations of "-mean()" were replaced by "Mean"
# All iterations of "-std()" were replaced by "STD"# All iterations of "-freq()" were replaced by "Frequency
# angle was replaced by Angle# gravity was replaced by Gravity
