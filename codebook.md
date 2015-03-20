##Codebook

Data in `Q5` contains accelerometer data from 30 participants who executed 6 activities (LAYIING, SITTING, STANDING,WALKING, WALKING_DOWNSTAIRS, AND WALKING_UPSTAIRS). Mean sensor means and standard devations are contained in variables 3 through 81. Each row contains average sensor means and standard deviations for a single activity per subject.

###Variables
`subject`
        Subjects are identified with the numbers 1 through 30

`activity`
        Unique activity values include 
                LAYING
                SITTING
                STANDING
                WALKING
                WALKING_DOWNSTAIRS
                WALKING_UPSTAIRS

Remaining columns contain means (denoted with 'mean' in the label) and standard deviation (denoted with 'std' in the label) for 

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope.

These measures were aggregated by the origional researchers. All credit for that work goes to:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
