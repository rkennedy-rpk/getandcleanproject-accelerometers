# getandcleanproject-accelerometers

Peer reviewed assignment for Coursera course on Getting and Cleaning data featuring accelerometers from the Samsung Galaxy S II

Title:README
Author: Ryan Kennedy
Date: 06/23/2021

This repository contains a dataset provided via the listed Coursera assignment  sourced from UCI HAR, the script required to process and summarize the dataset, and the tidy summary dataset output by the listed script.

####Source Dataset
======================================

The experiments in question have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70 percent of the volunteers was selected for generating the training data and 30 percent the test data. From original README file.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

####About the target dataset

The code/run_analysis.R script included in the repository utilizes the tidyverse package and the here package to process the source data by the following steps:

1.  Save the source URL for the data provided by the assignment and then utilize this to download the zip folder into the working directory designated by here("data").
	"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Read the datasets into R using the names included in the original ReadME file
3.  Provide identification to the two groups of experiment data to identify the 30 percent that were in the test dataset vs the 70 percent that were in the train dataset.
4.  Bind together the three respective sets of data into three distinct datasets
5.  Provide descriptive variable names to the three respective datasets utilizing the names provided by the features.txt file and then labeling the numeric labels of activity as "activity", the numeric identifier of test subject as "subject" and then the column created in step 3 as "group"
5. Bind all three respective datasets together as a full dataset and then reassign it as a tibble using the tibble package
6.  Generate syntactically valid names using the make.names function that are unique and then reassign these as the variable names
7.  Selecting out only the named variables from step 5 as well as all measurements of mean and standard deviation from the dataset.  In the same string of code use the activitylabels dataset to assign descriptive names to the values in the "activity" column and then gather Measurement column with the Meas_val values assigned as the observations while dropping the remaining variables.  The Measurement column was a combination of three variables and so separate is used to split these at the "-" into three separate variables now labeled "Feature_Variable", "Stat_Type",  and "Axis" to create a tidy version of the complete dataset that only has measurements on mean and standard deviation.
8.  From this tidied version of the complete set, the final string of code groups the dataset and then calculates the average of all measurements on mean and standard deviation for each activity, subject, variable, and axis for those that had multiple axis.  This string output a tidy summary set of the data.
9.  Finally the tidy summary of the dataset was written into the "outputs" folder of the repository as summary_dataset.txt

#### recreating the file

In order to recreate this file simply clone the repository to your machine and run the script in it's entirety.  Everything is self contained including the download of the zip as well as the calls to the zip used to import the datasets.

#### Included in this repository



'README.md'

'code/run_analysis.R'

'data/fullsets.zip'

'data/UCI HAR Dataset'

'outputs/summary_dataset.txt'

















