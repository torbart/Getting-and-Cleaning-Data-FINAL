## merge training and test sets ##

testobs <- read.table("./test/X_test.txt") #read test observations
testacts <- read.table("./test/y_test.txt") #read test activity IDs
testsubs <- read.table("./test/subject_test.txt") #read the test subject IDs
testobs <- cbind(testobs, testsubs, testacts) # merge obs and IDs

trainobs <- read.table("./train/X_train.txt") #read train observations
trainacts <- read.table("./train/y_train.txt") #read train activity IDs
trainsubs <- read.table("./train/subject_train.txt") #read the train subject IDs
trainobs <- cbind(trainobs, trainsubs, trainacts) # merge obs and IDs

allobs <- rbind(testobs, trainobs) #merge the test and train sets to be one dataset

features <- read.table("features.txt") #read variables
allobs <- `colnames<-`(allobs, features$V2) #set test obs column names to features

## extract only measurements on the mean and SD for each measurement ##

means<-allobs[, grep("*mean", names(allobs), ignore.case = T)] #select columns with mean
stds<-allobs[,grep("*std",names(allobs), ignore.case = T)] #select columns with standard deviation
activities<-allobs[,563] # select and save the activity ID column
subjects <- allobs[,562] # select and dave the subject ID column
allobs<-cbind(means, stds) # merge the mean and sd sets
allobs <- allobs %>% # remove the mean frequency and mean angle observations
        select(-matches("angle")) %>%
        select(-matches("meanFreq")) 

## use descriptive activity names to name the activities in the data set ##

activities <- gsub("1", "Walking", x = activities, ignore.case = T)
activities <- gsub("2", "Walking_Upstairs", x = activities, ignore.case = T) 
activities <- gsub("3", "Walking_Downstairs", x = activities, ignore.case = T) 
activities <- gsub("4", "Sitting", x = activities, ignore.case = T) 
activities <- gsub("5", "Standing", x = activities, ignore.case = T) 
activities <- gsub("6", "Laying", x = activities, ignore.case = T)
allobs <- cbind(allobs, activities, subjects) #merge the activities & subjects with the observations

## appropriately label the data set with descriptive variable names

variables <- as.data.frame(read.csv("variables.csv", header = F)) # extract descriptive variables names as data frame
allobs <- `colnames<-`(allobs, variables$V1) # assign descriptive variable names to variables
colnames(allobs)[68] <- "Subject" #name subject ID column
colnames(allobs)[67] <- "Activity" #name activity ID column 

## create a second, independent data set, that is tidy, with the average of each variable for each activity and each subject ##

grouped_obs <- allobs %>% group_by(Subject, Activity) # group data by subject and activity
grouped_means <- grouped_obs %>% summarize_all(mean) # summarize all variables grouped by subject and activity
grouped_means <- as.data.frame(grouped_means) # make summarized data into easily read data frame

