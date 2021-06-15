library(here)
library(tidyverse)

zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
list <- list()
download.file(zipURL, temp)
zipfilelist <- unzip(temp, list = T)
zipilepaths <- fs::dir_ls(unzip(temp)) #ongoing experiment
filenames <- filter(zipfilelist, Length > 0)
list <- filenames$Name


list_of_file <- list %>% 
        map(function (path){
                read_table(temp, path)
        })
names(list_of_file) <- list
master <- 
        list_of_file %>% 
        map(as_tibble) %>%                  #I returned this to tibble as I found that that wasn't the issue
        #bind_rows(.id = "id")
        list2env(test2, envir = .GlobalEnv) #adds contents of list to global environment
                                            #currently not workings as names(list_of_file) = NULL                
unlink(temp)        

file_contents <- list()
for (i in seq_along(list)) {
        file_contents[[i]] <- read_table(
                file = list[[i]]
        )
}        
        
test <- read_table(temp)
str(test)
read_table(temp, "features.txt")

#MANUAL PLAN ----
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipURL,here("data"))
testPATH <- here("data", "UCI HAR Dataset", "test", "X_test.txt")
testPATHlabels <- here("data", "UCI HAR Dataset", "test", "y_test.txt")
trainPATH <- here("data", "UCI HAR Dataset", "train", "X_train.txt")
trainPATHlabels <- here("data", "UCI HAR Dataset", "train", "y_train.txt")
featuresPATH <- here("data", "UCI HAR Dataset", "features.txt")


testdata <- read.table(testPATH)
testlabels <- read.table(testPATHlabels)
traindata <- read.table(trainPATH)
trainlabels <- read.table(trainPATHlabels)
features <- read.table(featuresPATH)
nameslist <- list()
features$V2 <- as.character(features$V2)
nameslist <- features$V2

colnames(testdata) <- c(nameslist)
mergedata <- bind_rows(traindata, testdata, .id = "setnumber")


names(testdata)
head(testdata)
