# Getting and Cleaning Data - Course Project CodeBook

## Raw data

Raw data came from UCI Machine Learning Repository. 
The data can be found here. The full description of the experiment can be found here.  

The data set was built from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, were captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded within [-1,1].

## Data modifications

The raw data sets are processed with run_analisys.R script to create a tidy data
set.

### Preparation of train and test data 

Test and training data (X_train.txt, X_test.txt) are merged to create one data set. 
From the merged data set is extracted and intermediate data set with only the values of estimated mean (label contains "mean") and standard deviation (label contains "std"). Variables are labelled appropriately with descriptive variables names.

### Preparation of activity data

Test and training data of activities (Y_train.txt, Y_test.txt) are merged to create one data set. 
Activity names was used to name the activities in the data set.

### Preparation of subject data

Test and training data of subject (subject_train.txt, subject_test.txt) are merged to create one data set.

### Merge three data sets

Three data sets are merged to ctreate single data set.

### Create a tidy data set

A tidy data set created from merged data sets with the average of each variable for each activity and each subject.

The tidy data set contains 10299 observations with 81 variables:

*  Activity  - an activity label: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING (factor).
*  Subject   - an identifier of the subject who carried out the experiment (integer).
*  79 signal variables (numeric):
        
        * TimeDomainBodyAcceleration   -X/Y/Z - M/SD 
        * TimeDomainGravityAcceleration  -X/Y/Z - M/SD       
        * TimeDomainBodyAccelerationJerk   -X/Y/Z - M/SD 
        * TimeDomainBodyGyroscope   -X/Y/Z - M/SD  
        * TimeDomainBodyGyroscopeJerk   -X/Y/Z - M/SD  
        * TimeDomainBodyAccelerationMagnitude   - M/SD          
        * TimeDomainGravityAccelerationMagnitude   - M/SD      
        * TimeDomainBodyAccelerationJerkMagnitude   - M/SD          
        * TimeDomainBodyGyroscopeMagnitude   - M/SD    
        * TimeDomainBodyGyroskopeJerkMagnitude   - M/SD 
        * FrequencyDomainBodyAcceleration   -X/Y/Z - M/SD/MF 
        * FrequencyDomainBodyAccelerationJerk   -X/Y/Z - M/SD/MF 
        * FrequencyDomainBodyGyroskope   -X/Y/Z - M/SD/MF 
        * FrequencyDomainBodyAccelerationMagnitude - M/SD/MF 
        * FrequencyDomainBodyAccelerationJerkMagnitude - M/SD/MF 
        * FrequencyDomainBodyGyroskopeMagnitude - M/SD/MF 
        * FrequencyDomainBodyGyroskopeJerkMagnitude - M/SD/MF
        ___________________________________________________________        
        * X/Y/Z   - three variables, one for each axis X,Y,Z
        * M/SD    - two variables, mean and standard deviation    
        * M/SD/MF - three variables, mean, standard deviation, mean frequency

The data set is written to the file TidyData.txt.
