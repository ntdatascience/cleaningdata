library(dplyr)
library(plyr)
library(formatR)
library(reshape)
library(utils)


getFeaturesColumnNames <- function(features.col.names) {
    features.col.names <- sapply(features.col.names, gsub, pattern = "([A-Z])", replacement = "_\\1")
    features.col.names <- sapply(features.col.names, gsub, pattern = "-", replacement = "_")
    features.col.names <- sapply(features.col.names, gsub, pattern = "^f", replacement = "freq")
    features.col.names <- sapply(features.col.names, gsub, pattern = "^t", replacement = "time")
    features.col.names <- sapply(features.col.names, gsub, pattern = "\\(\\)", replacement = "_")
    features.col.names <- sapply(features.col.names, gsub, pattern = "_+$", replacement = "")
    features.col.names <- sapply(features.col.names, gsub, pattern = "_+", replacement = "_")
    features.col.names <- sapply(features.col.names, tolower)
    
    features.col.names
}


buildHarDataFrame <- function(data.dir, subject.category) {
    features.def.file.name <- paste0(data.dir, "/", "features.txt")
    activity.def.file.name <- paste0(data.dir, "/", "activity_labels.txt")
    subjects.file.name <- paste0(data.dir, "/", subject.category, "/", "subject_", subject.category, ".txt")
    har.file.name <- paste0(data.dir, "/", subject.category, "/", "X_", subject.category, ".txt")
    activity.file.name <- paste0(data.dir, "/", subject.category, "/", "y_", subject.category, ".txt")
    
    print(features.def.file.name)
    
    col.definition.df <- read.csv(features.def.file.name, header = FALSE, sep = " ")
    colnames(col.definition.df) <- c("position", "description")
    
    features.col.names <- col.definition.df[, "description"]
    features.col.names <- getFeaturesColumnNames(features.col.names)
    
    desired.columns <- regexpr("(mean..|std..)(-[XYZ]){0,1}$", col.definition.df[, "description"]) > 0
    desired.columns <- col.definition.df[desired.columns, ][, "position"]
    
    activity.definition.df <- read.csv(activity.def.file.name, header = FALSE, sep = " ")
    colnames(activity.definition.df) <- c("activity_number", "activity")
    
    sapply(activity.definition.df[, "activity"], gsub, pattern = "_", replacement = " ")
    sapply(activity.definition.df, tolower)
    
    raw.har.file <- file(har.file.name)
    subject.no.df <- read.csv(subjects.file.name, header = FALSE)
    training.activity.df <- read.csv(activity.file.name, header = FALSE)
    
    raw.har.data <- readLines(raw.har.file)
    
    raw.har.data <- gsub("^ +| +$", "", raw.har.data)
    raw.har.data <- gsub(" +", ",", raw.har.data)
    ## write(raw.cleaning.data, 'working/training_cleaned.txt')
    
    har.data.df <- read.csv(textConnection(raw.har.data), header = FALSE)
    
    colnames(har.data.df) <- features.col.names
    har.data.df <- har.data.df[, desired.columns]

    har.data.df <- cbind(har.data.df, subject.no.df)
    colnames(har.data.df)[ncol(har.data.df)] = "subject_number"
    har.data.df <- cbind(har.data.df, training.activity.df)
    colnames(har.data.df)[ncol(har.data.df)] = "activity_number"
    har.data.df <- cbind(har.data.df, rep("train", nrow(har.data.df)))
    colnames(har.data.df)[ncol(har.data.df)] = "study_group"
    har.data.df <- merge(har.data.df, activity.definition.df, by.x = "activity_number", by.y = "activity_number")
#   removing activity number since we have the more meaningful activity name ("activity")
    har.data.df$activity_number <- NULL
    
    har.data.df
}

#
# Main 
#

# collect out train and test data
# then combine into one file

study.train.df <- buildHarDataFrame("sampleset", "train")
study.test.df  <- buildHarDataFrame("sampleset", "test")

study.df <- rbind(study.train.df, study.test.df)

# Get required columns so that we can calculate mean across variables by subject number and activity group
# Flip table so that variables/calculations are easier to work with
# Perform average of variables across subject and activity for each variable
# Then arrange/order by subject, activity, variable/calculation
har.mean.df <- 
  melt(study.df,c("subject_number","study_group","activity")) %>%
  ddply(c("subject_number","activity","variable"),summarise,mean=mean(value)) %>%
  arrange(subject_number,activity,variable)

write.table(har.mean.df,"har_mean_results.txt")