*********************************************************************
*****                     Readme for run_analysis               *****
*********************************************************************
  
The  function run_analysis.R  restores the data stored in
  
https:// d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
The function run_analysis.R is programmed in R and runs in Rstudio.
  
The program is written for fulfillment of the course project of the Coursera course 
'Getting and cleaning data', which is supervized by the John Hopkins University
  
The data that is analysed here, is generated for the project 
       'Human Activity Recognition Using Smartphones Dataset' 
The files stored in the https-address mentioned above, also includes
a README.txt file which describes the data more in detail.
 
The data should be downloaded from the website mentioned above and unzipped.
The working directory of run.analysis.R  should be in the same directory 
as the one in which the downloaded data are stored. 
The program is activated in Rstudio by typing 
                   run_analysis()             
 
The code of run_analysis.R subdivided in 5 steps:
  STEP 1    Merges the training and the test sets to create one data set
  STEP 2    Extracts only the measurements on the mean and standard deviation 
             for each measurement
  STEP 3    Uses descriptive activity names to name the activities in the data set
  STEP 4    Appropriately labels the data set with descriptive variable names
  STEP 5    From the data set in step 4, creates a second, independent tidy data set
            with the average of each variable for each activity and each subject
In step 5 some modules from the library data.table are used.
  
The dataset that is generated in STEP 5 by run_analysis.R is stored as:
            newDataSet.txt    
It can be imported into Excel.
  
Along with this readme file comes:
- the code of run_analysis.R
- Codebook.md which gives detailed information about the variables used in run_analysis.R
