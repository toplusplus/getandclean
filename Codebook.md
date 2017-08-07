Codebook
--------

### Cleaning Up Sensor Data From Samsung Galaxy S

Over the original dataset, available here: [Human Activity Recognition
Using Smartphones
Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones),
it was created an independent tidy data set applying the following the
steps:

1.  Omit the pre-processed signal data and load only the vectors of
    features, the subjects and the activities data.
2.  Merge both training and test sets into one dataset.
3.  Extract only the measurements on the mean and standard deviation for
    each measurement.
4.  Substitute the factor names of the activities with its corresponding
    descriptive names.
5.  Label the dataset variables with descriptive and syntactically
    valid names.
6.  Summarize using the average of each variable for each activity and
    each subject.

For a detailed description of the **data wrangling process** applied
please consult: [Cleaning Up Sensor Data From Samsung Galaxy
S](https://archive.ics.uci.edu).

The dataset created it's called **avgdata**. It contains **180
observations** and **68 variables**.

The **first 2 variables** are:

**"activity"**: identify the six activities performed by the subjects
(walking, walking\_upstairs, walking\_downstairs, sitting, standing,
laying).

**"subject"**: identify the subject who performed the activity for each
window sample. Its range is from 1 to 30.

The remaining **66 variables** correspond to the the average calculated
for each activity and each subject of that particular feature. A
detailed description of each feature is in the **features\_info.txt**
file in the original dataset.

The remaining variables names are list below:

**"tBodyAcc\_mean\_X"**  
**"tBodyAcc\_mean\_X"**  
**"tBodyAcc\_mean\_Y"**  
**"tBodyAcc\_mean\_Z"**  
**"tBodyAcc\_std\_X"**  
**"tBodyAcc\_std\_Y"**  
**"tBodyAcc\_std\_Z"**  
**"tGravityAcc\_mean\_X"**  
**"tGravityAcc\_mean\_Y"**  
**"tGravityAcc\_mean\_Z"**  
**"tGravityAcc\_std\_X"**  
**"tGravityAcc\_std\_Y"**  
**"tGravityAcc\_std\_Z"**  
**"tBodyAccJerk\_mean\_X"**  
**"tBodyAccJerk\_mean\_Y"**  
**"tBodyAccJerk\_mean\_Z"**  
**"tBodyAccJerk\_std\_X"**  
**"tBodyAccJerk\_std\_Y"**  
**"tBodyAccJerk\_std\_Z"**  
**"tBodyGyro\_mean\_X"**  
**"tBodyGyro\_mean\_Y"**  
**"tBodyGyro\_mean\_Z"**  
**"tBodyGyro\_std\_X"**  
**"tBodyGyro\_std\_Y"**  
**"tBodyGyro\_std\_Z"**  
**"tBodyGyroJerk\_mean\_X"**  
**"tBodyGyroJerk\_mean\_Y"**  
**"tBodyGyroJerk\_mean\_Z"**  
**"tBodyGyroJerk\_std\_X"**  
**"tBodyGyroJerk\_std\_Y"**  
**"tBodyGyroJerk\_std\_Z"**  
**"tBodyAccMag\_mean"**  
**"tBodyAccMag\_std"**  
**"tGravityAccMag\_mean"**  
**"tGravityAccMag\_std"**  
**"tBodyAccJerkMag\_mean"**  
**"tBodyAccJerkMag\_std"**  
**"tBodyGyroMag\_mean"**  
**"tBodyGyroMag\_std"**  
**"tBodyGyroJerkMag\_mean"**  
**"tBodyGyroJerkMag\_std"**  
**"fBodyAcc\_mean\_X"**  
**"fBodyAcc\_mean\_Y"**  
**"fBodyAcc\_mean\_Z"**  
**"fBodyAcc\_std\_X"**  
**"fBodyAcc\_std\_Y"**  
**"fBodyAcc\_std\_Z"**  
**"fBodyAccJerk\_mean\_X"**  
**"fBodyAccJerk\_mean\_Y"**  
**"fBodyAccJerk\_mean\_Z"**  
**"fBodyAccJerk\_std\_X"**  
**"fBodyAccJerk\_std\_Y"**  
**"fBodyAccJerk\_std\_Z"**  
**"fBodyGyro\_mean\_X"**  
**"fBodyGyro\_mean\_Y"**  
**"fBodyGyro\_mean\_Z"**  
**"fBodyGyro\_std\_X"**  
**"fBodyGyro\_std\_Y"**  
**"fBodyGyro\_std\_Z"**  
**"fBodyAccMag\_mean"**  
**"fBodyAccMag\_std"**  
**"fBodyBodyAccJerkMag\_mean"**  
**"fBodyBodyAccJerkMag\_std"**  
**"fBodyBodyGyroMag\_mean"**  
**"fBodyBodyGyroMag\_std"**  
**"fBodyBodyGyroJerkMag\_mean"**  
**"fBodyBodyGyroJerkMag\_std"**
