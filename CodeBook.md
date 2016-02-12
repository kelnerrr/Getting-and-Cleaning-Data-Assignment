# Introduction

The script `run_analysis.R` performs the 5-step procedure from the Coursera's Getting and Cleaning Data project assignment.

* At the beginning the dataset is read to tables from the data files saved on hard drive.
* Data with the same columns and referring to the same entities is merged using `rbind()` function.
* Only columns with the mean and standard deviation measurements are extracted. They are given the correct names, taken from `features.txt`.
* The activity IDs are replaced by the activity names taken from `activity_labels.txt`.
* The dataset is labeled with descriptive variable names.
* A new dataset is created with all the average measurements for each subject and activity type

# Variables

* `x_train`, `y_train`, `subject_train`, `x_test`, `y_test`, and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets for further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
