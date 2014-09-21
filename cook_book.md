## Cook Book

Explaination of data gathering and description of tidy data results.For project background refer to project assignment:

https://class.coursera.org/getdata-007/human_grading/view/courses/972585/assessments/3/submissions

## Data collection

David's diagram from the discussion forum best summarize how the files are combined. And, the idea of consider each feature as a variable.

![alt text](https://github.com/ntdatascience/cleaningdata/blob/master/diagram.png)

## "X" File

The "X_train.txt" and "X_test.txt" file required some preprocessing as it the separator were not uniform. File file contained spacing at the begining and ending of each line and some fields were separated by more than one space.

## Units

Since "features are normalized and bounded within [-1,1]" the resulting mean will also be normalized and bounded within [-1,1].

##Which Variables/Calculations?

Which columns are mean or standard deviation: selected variable were determined from the original feature data set what matched this reqular expression "(mean..|std..)(-[XYZ]){0,1}$"

## Attributes of Tidy Results

* Subject Number: id number assigned to the participant
* Activity: physical activity being performed (WALKING,WALKING UPSTAIRS, WALKING DOWNSTAIRS, LYING)
* Variable (Metric/Calculation): the specific type of measurement that was calculated and recorded
* Mean: the mean value for that subject, activity and variable 