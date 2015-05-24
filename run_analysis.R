unzip('getdata-projectfiles-UCI HAR Dataset.zip')

# Read feature and activity names
features <- read.table('UCI HAR Dataset/features.txt')
alabels <- read.table('UCI HAR Dataset/activity_labels.txt', 
                      col.names=c("activity_id", "activity_label"))

# Read training data, activity and subject. Merge into one table
train <- read.table('UCI HAR Dataset/train/X_train.txt', col.names=features$V2)
train.act <- read.table('UCI HAR Dataset/train/y_train.txt', col.names="activity_id")
train.subject <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names="subject")
train <- cbind(train, train.act, train.subject)

# Read test data, activity and subject. Merge into one table
test <- read.table('UCI HAR Dataset/test/X_test.txt', col.names=features$V2)
test.act <- read.table('UCI HAR Dataset/test/y_test.txt', col.names="activity_id")
test.subject <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names="subject")
test <- cbind(test, test.act, test.subject)

# Combine train and test data and add activity names
full <- rbind(train, test)
full <- tbl_df(merge(full, alabels))

# Select means and standard deviations for all variables and transform variable name
#   into more readable form
full_mean_std <- select(full, activity_id, activity_label, subject, contains("mean.."), contains("std..")) %>%
    select(-starts_with("angle.")) %>%
    gather(feature_measure_dir, value, -(activity_id:subject)) %>%
    separate(feature_measure_dir, into=c("feature","measure","dir")) %>%
    mutate(var= paste(feature,dir, sep=".")) %>%
    select(subject, activity_label, var, measure, value)

# Calculate means of means and stds for each subject + activity + variable
full_tidy <- full_mean_std %>%
    group_by(subject, activity_label, var, measure) %>%
    summarize(m=mean(value))

# save tidy data
write.table(full_tidy, 'tidy_data.txt', row.name=F)