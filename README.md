
## Background

For background on this project refer to the assignment:

https://class.coursera.org/getdata-007/human_grading/view/courses/972585/assessments/3/submissions

## Cook Book

https://github.com/ntdatascience/cleaningdata/blob/master/cook_book.md

## Output File

* Subject Number: id number assigned to the participant
* Activity: physical activity being performed (WALKING,WALKING UPSTAIRS, WALKING DOWNSTAIRS, LYING)
* Variable (Metric/Calculation): the specific type of measurement that was calculated and recorded
* Mean: the mean value for that subject, activity and variable

## Functions

buildHarDataFrame(data.dir, subject.category)

* data.dir is a string providing the base location of the Human Activity Reconition (HAR) data set
* subject.category is the string stating which data set (train or test) that is to be loaded

This function provide a consolidate way to generate the HAR data frome binding it appropriately with subject numbers, activity names, features. It only provides feature columns matching our standard devition and mean matching criteria. A wide data frame is returned where each feature is stored as a column.

getFeaturesColumnNames(features.col.names)

* features.col.names is a vector of the feature names from the features.txt file

This function takes the features and returns heading that cleaned up. An example is that the prefixing "f" is translated into "freq_" and "t" into "time_" to be describe the domain of the variables

## Final Note

Cleanup could be made based upon week 4 instruction which would add some readability 