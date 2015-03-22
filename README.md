This repository contains a script to tidy up the data gathered by Samsung from its Galaxy S smartphone's accelerometer.  The gathering of the data is detailed here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Running
=======
The data itself can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To properly run the run_anaylsis.R script included in this repository make sure your R working directory is set to the directory that the unzipped directory is in.  The script uses dplyr, so make sure you have installed that package.

Results
=======
Running the script creates a few data frames of tidy data, the first of which is `tidy_data`, the second of which is `tidy_data_avgs`.  `tidy_data` contains two columns which identify the data `subject.id` and `activity`, respectively, the subject performing the activity, as well as the activity being performed.  The included "features" (which are detialed further in `CodeBook.md`) are the means and avgs of the variables obtained when the original data-gatherers processed the data.  `tidy_data_avgs` contains the data from `tidy_data` grouped down to just one record per subject per activity, where the values are averages of all the variables.

The data was divided by the original data-gatherers randomly into two sets, test and train, which are combined in the results of this script.  The subject.id and acitivty columns were combined into the actual data by adding the `y_*.txt` files as well as the `subject_*.txt` files.  Activity names were pulled in from the `activity_labels.txt` file, and the feature labels were pulled in from the `features.txt` file.