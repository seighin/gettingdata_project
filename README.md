---
title: "Human Activity Tidy Data Project"
output: html_document
---

### Data

This projected assembled smartphone motion data of 30 subjects performing various activities into a tidy data set.

#### Codebook

- **subject** ID for the subject

- **activity_label** Activity engaged in, one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

- **var** The particular feature being measured, detailed below

- **measure** The statistic caluculated for this variable, one of mean or std (standard deviation)

- **m** Mean of the measures for each subject, activity, variable

#### Features

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

### Process

After the data zip file is unpacked, the tables containing the labels for features and activities are read. For both train and test data sets, the main tables are read using the feature list names as column names. Subject and activity tables are read and added as columns. The train and test tables are then joined (`rbind()`) and merged with activity labels.

A new table is created containg columns for subject, activity_label, var, measure and value. The feature variables are filtered to only means and standard deviations by only including columns containing "`mean..`" or "`std..`" (these represent feature names that contained "mean()" or "std()" since the perenthesises were converted to periods). The data was converted to tall form using `gather` and feature split from measure using `separate`.

The final tidy data data was created by grouping the data by subject, activity_label, var and measure and the `summarize` was used to calculate means.