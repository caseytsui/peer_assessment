# CODEBOOK.md

By Casey Tsui

Last updated: 4/26/14


This is a codebook for the "Getting and Cleaning Data" course on Coursera.
This will describe the variables, the data, and any transformations or work that was performed to clean up the Samsung wearable technology data


# VARIABLES

**Features**

NOTE: This section of the codebook comes from the features.txt that was supplied by the course.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean


**Activity labels**

Measurements of features were analyzed by the activity that the wearer was doing when the measurements were taken.

The activity ID numbers and their corresponding labels are as follows:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING


# DATA #########################################################################
The data was processed in steps:

The "ReadFiles" function conducts steps 1-8 for each of the "train" and "test" data sets:
1. Read in subject data
2. Read in list of feature names
3. Read in x_train and use the feature names as its column names
4. Read in activity labels and name their columns
5. Read in y_train
6. Merge y_train and activity labels by the "activity_id" variable
7. Append the x_train object onto the y_train and activity labels

Steps 8-11 run in the global environment
8. Append the "train" and "test" data sets
9. Use regular expressions to select only those variables in the merged data set that contain the phrase "mean" in their name
10. Subset the merged data set to select for those variables that contain the phrase "std" in their name
11. Create a subset data set (means_stds) with the subject ID, activity ID, and the activity name, plus the variables that contained "mean" in their names

For specific details, please see the commented run_analysis.R script file.


# TRANSFORMATIONS ##############################################################

The instructions for this assignment were to write an R script that would do the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Details on the reading and cleaning of the data sets are covered in the previous section on DATA as well as in the commented run_analysis.R script file.

In order to produce a tidy data set with the averages of all the variables per subject per activity, the "ddply" function from the plyr package was used to split the data frame by subject ID and activity ID, and to apply the numcolwise(mean) function to every column in the data set.

For specific details, please see the commented run_analysis.R script file.



