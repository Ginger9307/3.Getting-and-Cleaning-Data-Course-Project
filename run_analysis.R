######################## GETTING AND CLEANING DATA COURSE PROJECT ##########################
# You should create one R script called run_analysis.R that does the following.            #
# 1.Merges the training and the test sets to create one data set.                          #
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.# 
# 3.Uses descriptive activity names to name the activities in the data set                 #
# 4.Appropriately labels the data set with descriptive variable names.                     #
# 5.From the data set in step 4, creates a second, independent tidy data set with the      # 
#   average of each variable for each activity and each subject.                           #
############################################################################################

# loading package
library(dplyr)

######################### READING DATA ######################################################
# reading test data 
X_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE)
Y_test <- read.table(file = "./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# reading train data
X_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE)
Y_train <- read.table(file = "./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# reading features as character
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, as.is = TRUE)

# reading activity labels
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

######################### PREPARATION OF FEATURES ##################################################
# binding X_train and X_test data 
X_data <- rbind(X_test, X_train)

# choosing only features with mean and standard deviation 
need_positions <-  grepl("mean|std", features$V2)

# choosing only columns according to need_positions (mean & std)
X_data <- X_data[,need_positions]

# expand names of features and remove unnecessery"()"
features$V2 <- gsub("Acc", "Acceleration", features$V2)
features$V2 <- gsub("Gyro", "Gyroscope", features$V2)
features$V2 <- gsub("Mag", "Magnitude", features$V2)
features$V2 <- gsub("Freq", "Frequency", features$V2)
features$V2 <- gsub("mean", "Mean", features$V2)
features$V2 <- gsub("std", "StandardDeviation", features$V2)
features$V2 <- gsub("^f", "FrequencyDomain", features$V2)
features$V2 <- gsub("^t", "TimeDomain", features$V2)
features$V2 <- gsub("\\()", "", features$V2)

# giving names for X_data's columns according to wanted positions (mean & std)
colnames(X_data) <- features$V2[need_positions]

########################## PREPARATION OF AVTIVITY DATA #############################################
# binding activity data
Y_data <- rbind(Y_test, Y_train)

# replace activity values in Y_data with names of act_labels
Y_data$V1 <- factor(x = Y_data$V1, levels = act_labels[,1], labels = act_labels[,2])

# giving name for Y_data's column 
colnames(Y_data) <- "Activity"

########################## PREPARATION OF SUBJECT DATA #############################################
# binding subject data
subject_data <- rbind(subject_test, subject_train)

# giving name for Subject name's column 
colnames(subject_data) <- "Subject"

########################## BINDING ALL DATA #####################################################
ready_data <- cbind(subject_data, Y_data, X_data)

########################## PREPARATION OF TIDY SET #################################################
# grouping data by subject/activity, summarise using mean  
sum_ready_data <- group_by(ready_data, Subject, Activity) %>% summarise_each(mean)

# writing summarise date to the file
write.table(sum_ready_data, "tidy_data.txt", row.names = FALSE)

########################## THE END !!! ########################################################## 






