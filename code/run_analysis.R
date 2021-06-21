library(tidyverse)
library(here)

#MANUAL PLAN ----
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipURL,here("data"))

testx <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/test/X_test.txt"))
testy <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/test/y_test.txt"))
tests <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/test/subject_test.txt"))
trainx <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/train/X_train.txt"))
trainy <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/train/y_train.txt"))
trains <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/features.txt"))
activitylabels <- read.table(unz("data/fullsets.zip", "UCI HAR Dataset/activity_labels.txt"))

#ID the two groups
tests <- mutate(tests,
                group = "test")
trains <- mutate(trains,
                group = "trains")

# merge the datasets
Xfull <- bind_rows(testx, trainx)
Yfull <- bind_rows(testy, trainy)
Sfull <- bind_rows(tests, trains)

# column names

colnames(Xfull) <- features$V2
colnames(Yfull) <- c("activity")
colnames(Sfull) <- c("subject", "group")

#merge into single dataset
Full <- bind_cols(Xfull, Yfull, Sfull)
FullT <- tibble::as_tibble(Full)
rm(Full)

#confirm column names are unique


valid_column_names <- make.names(names=names(FullT), unique=TRUE, allow_ = TRUE)
names(FullT) <- valid_column_names

#extract only "mean" or "standard deviation" variables

FullTextract <- FullT %>%
        select(group, subject, activity, contains(".mean."), contains(".std.")) %>% #I added the periods in contains() to eliminate the averages of the signals which are not means of measurements
        mutate(activity = factor(activity, labels = activitylabels$V2)) %>%
        gather(Measurement, Meas_val, -(group:activity)) %>%
        separate(Measurement, c("Feature_Variable", "Stat_Type", "Axis"))
tidy <- FullTextract %>% 
        group_by(activity, subject, Feature_Variable, Stat_Type, Axis) %>% 
        summarize(Avg_val = mean(Meas_val)) %>% 
        spread(Stat_Type, Avg_val) %>% 
        rename("Mean" = mean, "Std" = std, "Activity" = activity, "Subject" = subject)
tidy %>% 
write.table("outputs/summary_dataset.txt", row.names = F)




