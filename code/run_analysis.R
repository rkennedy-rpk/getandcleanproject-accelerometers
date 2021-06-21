library(tidyverse)
library(here)

#MANUAL PLAN ----
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipURL,here("data"))
testPATHx <- here("data", "UCI HAR Dataset", "test", "X_test.txt")
testPATHy <- here("data", "UCI HAR Dataset", "test", "y_test.txt")
testPATHs <- here("data", "UCI HAR Dataset", "test", "subject_test.txt")
trainPATHx <- here("data", "UCI HAR Dataset", "train", "X_train.txt")
trainPATHy <- here("data", "UCI HAR Dataset", "train", "y_train.txt")
trainPATHs <- here("data", "UCI HAR Dataset", "train", "subject_train.txt")
featuresPATH <- here("data", "UCI HAR Dataset", "features.txt")
activitylabelsPATH <- here("data", "UCI HAR Dataset", "activity_labels.txt")


testx <- read.table(testPATHx)
testy <- read.table(testPATHy)
tests <- read.table(testPATHs)
trainx <- read.table(trainPATHx)
trainy <- read.table(trainPATHy)
trains <- read.table(trainPATHs)
features <- read.table(featuresPATH)
activitylabels <- read.table(activitylabelsPATH)

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

nameslist <- list()
features$V2 <- as.character(features$V2)
nameslist <- features$V2
colnames(Xfull) <- c(nameslist)
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
        select(group, subject, activity, contains(".mean."), contains(".std.")) %>% 
        mutate(activity = factor(activity, labels = activitylabels$V2)) %>% 
        gather(Measurement, Meas_val, -(group:activity)) %>%
        separate(Measurement, c("Feature_Variable", "Stat_Type", "Axis"))
tidy <- FullTextract %>% 
        group_by(activity, subject) %>% 
        summarize(Avg_val = mean(Meas_val))
