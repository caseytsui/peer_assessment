# run_analysis.R
# Getting and Cleaning Data Peer Assessment
# By Casey Tsui
# Format: R
# Last updated: 4/18/14

# NOTE: This code reads in, cleans, and analyzes data from accelerometers from
# the Samsung Galaxy S smartphone. It is created for the Coursera "Getting and Cleaning Data" course.


library(plyr)


# FUNCTIONS ###################################################################
ReadFiles <- function(group) {
        # group is a character vector of length 1, either "train" or "test"

        # Assign all file directories
        activity_labels_dir <- "./data/activity_labels.txt"
        features_dir <- "./data/features.txt" 
        root <- paste("./data/", group, "/", sep="")
        sub_train_dir <- paste(root, "subject_", group, ".txt", sep="")
        x_train_dir <- paste(root, "X_", group, ".txt", sep="")
        y_train_dir <- paste(root, "Y_", group, ".txt", sep="")

        # Read in subjects
        sub_train <- read.table(sub_train_dir,
                header=FALSE, sep="", col.names="subject_id") 

        # Read in features as a vector object
        features <- read.table(features_dir, header=FALSE, sep="")[[2]]
        features <- as.character(features)

        # Read in x_train and assign features as its column names
        x_train <- read.table(x_train_dir, header=FALSE, sep="",
                col.names=features, colClasses="numeric")

        # Read in activity labels and name their columns
        activity_labels <- read.table(activity_labels_dir, header=FALSE,
                sep="", col.names=c("activity_id", "activity_name"))

        # Read in y_train
        y_train <- read.table(y_train_dir, header=FALSE, sep=" ",
                col.names="activity_id")

        # Merge the y_train and activity labels
        y <- merge(y_train, activity_labels, by=("activity_id"))
        sub_y <- cbind(sub_train, y)

        # Append the x_train variables onto the merged y_train and act. levels
        merged <- cbind(sub_y, x_train)
        return(merged)
}


# SET WORKING DIRECTORY #######################################################
wd1 <- "/Users/caseytsui/Documents/personal/coursera/"
wd2 <- "03_getting_and_cleaning_data/peer_assessment/"
dir <- paste(wd1, wd2, sep="")
setwd(dir)


# CREATE DATA FOLDER IF NONE EXISTS ###########################################
if (!file.exists("data")) {
        dir.create("data")
}


# MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
train <- ReadFiles("train")
test <- ReadFiles("test")
merged_file <- rbind(train, test)


# EXTRACT ONLY MEASUREMENTS ON THE MEAN AND STD DEVIATION FOR EACH MEASUREMENT
# Use grep to subset columns with means and standard deviations
means <- grep("^[a-zA-Z0-9.]*[Mm]ean[^Freq][a-zA-Z0-9.]*$",
        names(merged_file))
stds <- grep("std", names(merged_file))

# Put the column indices with mean and std variables into the same vector and
# sort it in ascending order
indices <- sort(c(means, stds))

# Create new data frame with mean and std variables
means_stds <- merged_file[, c(1:3, indices)]


# USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
# This is done within the ReadFiles function


# APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE ACTIVITY NAMES. 
# This is done within the ReadFiles function


# CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
means_only <- merged_file[, c(1:3, means)]

x <- ddply(means_only,
      .(subject_id, activity_name),
      numcolwise(mean))

x <- cbind(x[, 1:2], rowMeans(x[, 4:length(x)]))
names(x)[3] <- "mean"



###### DRAFTY ##########


ddply(means_only,
      .(subject_id, activity_name),
      summarize,
     c(mean = mean(means_only$fBodyAccMag.sma.., na.rm=TRUE)))
     # function(df)
         c(mean = mean(df$fBodyAccMag.sma.., na.rm=TRUE)))

means_only[, list(height = colMeans(height)
+            , weight = mean(weight)
+            , age = mean(age)
+            ), by = sample]

lst <- list()
for (i in 1:30) {
        for (j in 1:6) {
                lst[i][j] <- rowMeans(means_only[which(means_only$subject_id == i & means_only$activity_id == j), ])
        }

}

