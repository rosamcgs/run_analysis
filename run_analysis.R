run_analysis <- function(){

    # Reading files
    file_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
    file_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
    file_activity_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
    file_activity_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
    file_subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
    file_subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
    file_activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
    file_features <- read.table(file = "./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    
    # Variable names
    aux1 <- file_features[,2]
    aux2 <- gsub(pattern = "[[:punct:]]", aux1, replacement = " ")
    
    # Variables (means)
    aux_mean <- grep(pattern = "mean ", aux2)
    
    # Variables (stds)
    aux_std <- grep(pattern = "std", aux2)
    
    # DF test means with names
    means_test <- file_test[, aux_mean]
    names(means_test) <- gsub(pattern = "BodyBody", gsub(pattern = " ", aux2[aux_mean], replacement = ""), replacement = "Body")
    
    # DF test Standar Deviations with names
    stds_test <- file_test[, aux_std]
    names(stds_test) <- gsub(pattern = "BodyBody", gsub(pattern = " ", aux2[aux_std], replacement = ""), replacement = "Body")
    
    # DF train means with names
    means_train <- file_train[, aux_mean]
    names(means_train) <- gsub(pattern = "BodyBody", gsub(pattern = " ", aux2[aux_mean], replacement = ""), replacement = "Body")
    
    # DF test Standar Deviations with names
    stds_train <- file_train[, aux_std]
    names(stds_train) <- gsub(pattern = "BodyBody", gsub(pattern = " ", aux2[aux_std], replacement = ""), replacement = "Body")
    
    # DF measures
    test_m <- cbind(means_test, stds_test)
    train_m <- cbind(means_train, stds_train)
    
    
    # DF test
    names(file_subject_test) <- "Subject"
    names(file_activity_test) <- "Activity_id"
    test <- cbind(file_subject_test, file_activity_test, test_m)
    
    # DF train
    names(file_subject_train) <- "Subject"
    names(file_activity_train) <- "Activity_id"
    train <- cbind(file_subject_train, file_activity_train, train_m)
    
    # Complete DF with activity description
    test_train <- rbind(test, train)
    names(file_activity_labels) <- c("Activity_id", "Activity_desc")
    test_train <- merge(file_activity_labels, test_train, by.x = "Activity_id", by.y = "Activity_id")

    #return(test_train)
    library(dplyr)
    
    # Tidy complete dataset
    tbl_data <- tbl_df(test_train)
    tidy_test_train <- select(tbl_data, Subject, Activity_desc:69)
    tidy_test_train <- arrange(tidy_test_train, Subject, Activity_desc)
    
    # Grouped dataset
    gtidy_test_train <- group_by(tidy_test_train, Subject, Activity_desc)
    
    # Mean on every numeric variable
    tidy_data <- summarise_each(gtidy_test_train, funs(mean))
    
    # Writting file
    write.table(as.data.frame(tidy_data), file = "./UCI HAR Dataset/Tidy_data.txt", row.names = FALSE)
    
    return(as.data.frame(tidy_data))

}