# Cleaning Up Sensor Data From Samsung Galaxy S
@toplusplus  
August 6, 2017

## Overview

*Wearable Computing* is no longer science fiction, it is part of our
lives, it's a very active topic of research and it's in plain commercial
expansion. Companies are racing to develop the most advanced algorithms
to attract new users.

Using data collected from the sensors from the Samsung Galaxy S
smartphone, this document explain **step-by-step how to prepare a tidy
data set** that can be used for later analysis.

## About the data

The dataset and its detailed description are stored in the UCI Machine
Learning Repository as [Human Activity Recognition Using Smartphones
Data
Set.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

As says the *abstract* in the link above, the dataset is essentially a:

*"**Human Activity Recognition database** built from the recordings of
30 subjects performing activities of daily living (ADL) while carrying a
waist-mounted smartphone with embedded inertial sensors".*

For each record in the dataset it is provided:

-   Triaxial acceleration from the accelerometer (total acceleration)
    and the estimated body acceleration.
-   Triaxial Angular velocity from the gyroscope.
-   A 561-feature vector with time and frequency domain variables.
-   Its activity label.
-   An identifier of the subject who carried out the experiment.

## Get and understand the data

We'll start downloading the data set.

```r
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, "hardataset.zip")
    unzip("hardataset.zip")
```

If everything went well, there must be a directory named **UCI HAR
Dataset** in our working directory. It contains the following files:

-   'README.txt': Describes the dataset.

-   **'features\_info.txt'**: Shows information about the variables used
    on the feature vector.

-   **'features.txt'**: List of all features.

-   **'activity\_labels.txt'**: Links the class labels with their
    activity name.

-   **'train/X\_train.txt'**: Training set.

-   **'train/y\_train.txt'**: Training labels.

-   **'test/X\_test.txt'**: Test set.

-   **'test/y\_test.txt'**: Test labels.

-   **'train/subject\_train.txt'**: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30.

-   **'test/subject\_train.txt'**: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30.

-   'train/Inertial Signals/'

-   'test/Inertial Signals/'

We'll work with the files marked in **bold**. The directories
*'train/Inertial Signals/'* and *'test/Inertial Signals/'* contains
files that we're not considering in this workshop. For a detailed
description of this dataset please read its **'README.txt'** file.

As we can see, the data is spread out into several files and it is
separated into **training** and **test** data.

**Our goal is** combines this files and apply some common tasks in
**data wrangling** until achieve a required tidy dataset.

Specifically we will:

1.  Merge the training and the test sets to create one dataset.
2.  Extract only the measurements on the mean and standard deviation for
    each measurement.
3.  Use descriptive activity names to name the activities in the dataset
4.  Appropriately label the data set with descriptive variable names.
5.  Create an independent tidy dataset with the average of each variable
    for each activity and each subject.

### Alright, let's do this!

<p align="center">
<img src="http://www.acheronanalytics.com/uploads/9/8/6/3/98636884/editor/51764130_1.jpg?1491762379">
</p>

## 1. Merge the training and the test sets

Our strategy here will be first create a data frame with the training
data and then another one with the test data to finally merge both.

The *features.txt* file contains the labels' names of the 561 variables
of the **feature vector**, which represents most of our dataset. Since
we'll need these labels for both, training and test data, we'll load it
first.

```r
    featlabels <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)  
    str(featlabels)
```

```
    ## 'data.frame':    561 obs. of  2 variables:
    ##  $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ V2: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...
```

It seems like the second column of the data frame returned by
*read.table* contains the variable names we are looking for.

```r
    featlabels <- as.vector(featlabels[[2]])
    str(featlabels)
```

```
    ##  chr [1:561] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" ...
```

Nice. Now we're ready to load the **training set** and take a look at
its structure.

```r
    traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
    dim(traindata)
```

```
    ## [1] 7352  561
```

```r
    str(traindata[,1:6])
```

```
    ## 'data.frame':    7352 obs. of  6 variables:
    ##  $ V1: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ V2: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ V3: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ V4: num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
    ##  $ V5: num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
    ##  $ V6: num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
```

Wow! Our training set have **7352** rows and **561** columns. For the
sake of the sexyness of this document, we'll using *str* function with a
small subset of the columns of the dataset.

Now we'll rename the columns of the training set using the vector of
feature labels' names formed above.

```r
    colnames(traindata) <- featlabels
    str(traindata[,1:6])
```

```
    ## 'data.frame':    7352 obs. of  6 variables:
    ##  $ tBodyAcc-mean()-X: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
    ##  $ tBodyAcc-std()-Y : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
    ##  $ tBodyAcc-std()-Z : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
```

It's time to load and attach the identification of the **subjects** of
the experiment and the **activities** to the training set.

```r
    subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    str(subject)
```

```
    ## 'data.frame':    7352 obs. of  1 variable:
    ##  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
```

```r
    subject <- as.vector(subject[[1]])
    str(subject)
```

```
    ##  int [1:7352] 1 1 1 1 1 1 1 1 1 1 ...
```

```r
    activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
    str(activity)
```

```
    ## 'data.frame':    7352 obs. of  1 variable:
    ##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
```

```r
    activity <- factor(activity[[1]])
    str(activity)
```

```
    ##  Factor w/ 6 levels "1","2","3","4",..: 5 5 5 5 5 5 5 5 5 5 ...
```

Once we have our **subject** and **activity** vector, we'll simply
combine/add them to the training set.

```r
    traindata <- cbind(subject, activity, traindata)
    dim(traindata)
```

```
    ## [1] 7352  563
```

```r
    str(traindata[,1:6])
```

```
    ## 'data.frame':    7352 obs. of  6 variables:
    ##  $ subject          : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ activity         : Factor w/ 6 levels "1","2","3","4",..: 5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
```

Great! All done for the training set. Let's do the same for the **test
set**, but faster!

```r
    testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
    colnames(testdata) <- featlabels

    subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    subject <- as.vector(subject[[1]])

    activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
    activity <- factor(activity[[1]])

    testdata <- cbind(subject, activity, testdata)
    dim(testdata)
```

```
    ## [1] 2947  563
```

```r
    str(testdata[,1:6])
```

```
    ## 'data.frame':    2947 obs. of  6 variables:
    ##  $ subject          : int  2 2 2 2 2 2 2 2 2 2 ...
    ##  $ activity         : Factor w/ 6 levels "1","2","3","4",..: 5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X: num  0.257 0.286 0.275 0.27 0.275 ...
    ##  $ tBodyAcc-mean()-Y: num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
    ##  $ tBodyAcc-mean()-Z: num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
    ##  $ tBodyAcc-std()-X : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
```

And forthwith we merge the training and test set into one dataset named
**hardata**.

```r
    hardata <- rbind(traindata, testdata)
    dim(hardata)
```

```
    ## [1] 10299   563
```

```r
    str(hardata[,1:6])
```

```
    ## 'data.frame':    10299 obs. of  6 variables:
    ##  $ subject          : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ activity         : Factor w/ 6 levels "1","2","3","4",..: 5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
```

Perfect! One dataset! Let's moving on.

## 2. Extract only the measurements on the mean and standard deviation for each measurement

To accomplish this, we'll search for matches to the substrings
**"mean()"** and **"std()"** within each element of the column names of
the dataset. Remember that 561 variables of this dataset correspond with
the features labels' names, the other two are *subject* and *activity*.

It seems a perfect task for the **grep** function.

```r
    hardata <- hardata[, c(1, 2, grep("mean\\(\\)|std\\(\\)", names(hardata)))]
    dim(hardata)
```

```
    ## [1] 10299    68
```

```r
    str(hardata[,1:6])
```

```
    ## 'data.frame':    10299 obs. of  6 variables:
    ##  $ subject          : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ activity         : Factor w/ 6 levels "1","2","3","4",..: 5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
```

What a trim! Our dataset columns decreased from **563** to **68**. And
we are ready for the next task.

## 3. Use descriptive activity names to name the activities in the data set

There are no names more 'descriptive' for the activities than those
listed in the **activity\_labels.txt** file. Let's use them!

```r
    actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    str(actlabels)
```

```
    ## 'data.frame':    6 obs. of  2 variables:
    ##  $ V1: int  1 2 3 4 5 6
    ##  $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1
```

```r
    actlabels <- tolower(as.vector(actlabels[[2]]))
    str(actlabels)
```

```
    ##  chr [1:6] "walking" "walking_upstairs" "walking_downstairs" "sitting" ...
```

```r
    levels(hardata$activity) <- actlabels 
    levels(hardata$activity)
```

```
    ## [1] "walking"            "walking_upstairs"   "walking_downstairs"
    ## [4] "sitting"            "standing"           "laying"
```

Done! We are on the road!

## 4. Appropriately label the dataset with descriptive variable names.

Since the names of the variables of the dataset are already quite
descriptive, we will apply some aesthetic changes to them to convert
them into syntactically valid names.

Using the function **gsub** we'll remove any parentheses and substitute
any hyphen '-' for an underscore '\_'.

```r
    names <- gsub("()", "", names(hardata), fixed = TRUE)
    names <- gsub("-", "_", names)
    names(hardata) <- names
    str(hardata[,1:6])
```

```
    ## 'data.frame':    10299 obs. of  6 variables:
    ##  $ subject        : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ activity       : Factor w/ 6 levels "walking","walking_upstairs",..: 5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc_mean_X: num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc_mean_Y: num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc_mean_Z: num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc_std_X : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
```

Nice. We are almost done!

## 5. Create an independent tidy dataset with the average of each variable for each activity and each subject.

With the help of the package **dplyr** we can do this with one line of
code!

```r
    library(dplyr)

    avgdata <- group_by(hardata, activity, subject)  %>% 
               summarise_all(funs(mean))

    head(avgdata[,1:6])
```

```
    ## # A tibble: 6 x 6
    ## # Groups:   activity [1]
    ##   activity subject tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z
    ##     <fctr>   <int>           <dbl>           <dbl>           <dbl>
    ## 1  walking       1       0.2773308     -0.01738382      -0.1111481
    ## 2  walking       2       0.2764266     -0.01859492      -0.1055004
    ## 3  walking       3       0.2755675     -0.01717678      -0.1126749
    ## 4  walking       4       0.2785820     -0.01483995      -0.1114031
    ## 5  walking       5       0.2778423     -0.01728503      -0.1077418
    ## 6  walking       6       0.2836589     -0.01689542      -0.1103032
    ## # ... with 1 more variables: tBodyAcc_std_X <dbl>
```

Finally, one tidy dataset ready for later analysis. Better we save it!

```r
    write.table(avgdata, "avgdata.txt", row.names = FALSE)
```

## Conclusions

For **subset**, **merge** and **reshape** tasks, in this particular
case, inbuilt **base R functions** works fine and keep the things
simple.

For **summarize**, the *group\_by %&gt;% summarise* approach from the
**dplyr** package results very useful.

<hr>

**PD**: The layout (suggested tasks) of this document belongs to the
*Course Project* of the [Coursera](https://www.coursera.org) course
**'Getting and Cleaning Data'** by **Johns Hopkins University**.
