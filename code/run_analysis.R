library(tidyverse)
library(here)

#MANUAL PLAN ----
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipURL,here("data"))
testPATHx <- here("data", "UCI HAR Dataset", "test", "X_test.txt")
testPATHy <- here("data", "UCI HAR Dataset", "test", "y_test.txt")
trainPATHx <- here("data", "UCI HAR Dataset", "train", "X_train.txt")
trainPATHy <- here("data", "UCI HAR Dataset", "train", "y_train.txt")
features <- here("data", "UCI HAR Dataset", "features.txt")


testx <- read.table(testPATHx)
testy <- read.table(testPATHy)
trainx <- read.table(trainPATHx)
trainy <- read.table(trainPATHy)
features <- read.table(featuresPATH)
nameslist <- list()
features$V2 <- as.character(features$V2)
nameslist <- features$V2

colnames(testdata) <- c(nameslist)
mergedata <- bind_rows(traindata, testdata, .id = "setnumber")


names(testdata)
head(testdata)
