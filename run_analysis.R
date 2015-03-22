library(dplyr)

# get the features in a vector
features <- read.table("UCI\ HAR\ Dataset/features.txt", header = FALSE)
feature_names <- as.character(features$V2)

# pull and merge the actual data with existing named features
xtrain <- read.table("UCI\ HAR\ Dataset/train/X_train.txt", header = FALSE, col.names = feature_names)
xtest <- read.table("UCI\ HAR\ Dataset/test/X_test.txt", header = FALSE, col.names = feature_names)
xfull <- rbind(xtrain, xtest)

# pull and merge the activities
ytrain <- read.table("UCI\ HAR\ Dataset/train/Y_train.txt", header = FALSE)
ytest <- read.table("UCI\ HAR\ Dataset/test/Y_test.txt", header = FALSE)
yfull <- rbind(ytrain, ytest)

# pull and merge the subject ID
subjecttrain <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt", header = FALSE)
subjecttest <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt", header = FALSE)
subjectfull <- rbind(subjecttrain, subjecttest)

# combine in the other cols
xfull$subject.id <- subjectfull$V1
xfull$activity.id <- yfull$V1

# change to a well-labeled factor 
activities <- read.table("UCI\ HAR\ Dataset/activity_labels.txt", col.names = c("id", "activity"))
xfull <- merge(xfull, activities, by.x="activity.id", by.y="id")
# drop off the activity.id, it is of no use anymore
xfull <- subset(xfull, select = -c(activity.id))

# get only the columns we want
full <- tbl_df(xfull)
tidy_data <- select(full, contains("subject.id"), contains("activity"), contains("std", ignore.case = FALSE), contains("mean", ignore.case = FALSE))

# get averages of target variables for each person/activity
tidy_data_avgs <- tidy_data %>% group_by(subject.id, activity) %>% summarise_each(funs(mean), c(contains("std"), contains("mean")))



