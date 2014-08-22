Getting-and-cleaning-data-project
=================================

Project repository for the coursera course Getting and Cleaning data

The Script has 7 sections. Each section will start with a comment indicating the process done in that section. Throughout the script the assuption is that the run_analysis.R script is located inside the UCI HAR Datset i.e. in the folder where test,train folders are located.

The first section "loads the training and testing dataset and merges them". 

In the second section the subjects labels are loaded from subject_train and subject_test and merged to a single dataframe named subject. Then this subject column dataframe is added to the merged data frame which we got in the end of the first section.

In the 3rd section feature names from features.txt file is loaded and assigned to a dataframe lables using which the colnames of merged dataframe is assigned. The last column of merged data is assigned activity as its label and first column is assigned subject as its label manually.

In the 4th section the measurements having mean,standard deviation in feature set are extracted and stored in a separate dataset meanStdColsData

In the 5th section Descriptive activity labels were loaded from activity_labels.txt and replaced the numeric values in the activity column of the merged dataset

In the 6th section appropriate descriptive names are assigned for variable names.

in the last section the aggregate mean for each subject is calculated and stored in aggsubject dataframe and for each activity is calculated and stored in aggsubject dataframe. The results were writen to 2 txt files in the end
