Getting-and-cleaning-data-project
=================================

F.M. v. Recklinghausen

December 20, 2014

getting and cleaning data course project

The following describes how the code works:

Set working directory to dataset location

clear data environment

load data.table module

load test data from the main directory, append the Y files, the subject files, and view result

load Train Data from the main directory, append the Y files, the subject files, and view result

load features file and view
identify col that contain mean and std dev and re-lable them

load activity labels walking etc.

combine the test and train datasets

Get only the data on mean and std. dev.

First reduce to values which only have mean and st dev

Join the subject and activity to the last two columns of the dataset called AllData

Remove the unneeded columns from AllData keeping only the columns of interest

Add the column names from features to AllData

Remove the subject and activity column, since a mean of those has no use

Write tidy table and view
