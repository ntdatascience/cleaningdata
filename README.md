cleaningdata
============



event_id: a unique identifier for the recored event
study_category: Train/Test to denote the participant's group
subject_number: a unique number identifying each participant
activity: type of physical activity being performed by the participant during the record event

Design
Event Id  Study Category  Subject Number Activity Calculation
234234    Train           1               WALK    freq_body_acc_jerk_std_y



Decision on tidy data: since what is considered a complete event requires the recording of all the metrics it seems appropriate to keep each metric as it's own column. If we were to translate the data into a narrow data design and build a metrics/calculation column along the similar to the following it becomes difficult to determine which metric/calculation was not calculated and recorded.

Alternative Narror Design:
Event Id  Study Category  Subject Number Activity Calculation
234234    Train           1               WALK    freq_body_acc_jerk_std_y
.
.
.