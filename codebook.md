*************************************
***** CODEBOOK for Run_Analysis *****
*************************************
  
* run_analysis is programmed in R
* In step 5 the library data.table is used
* The variables and FUNCTIONS are tabulated in order of appearance,   
  and  grouped in the successive steps of the program   
  
-------------------------
 Variables used in STEP 1
-------------------------
  
fileName :    

     Name of the input-file to be read 
  
X-train :     

     X-train data obtained from UCI HAR Dataset/train/X_train.txt 
  
X-test :     

     X-test data obtained from UCI HAR Dataset/test/X_test.txt 
  
allData :    

     The combined data from X-test and X-train
  
features :    

     Feature data obtained from UCI HAR Dataset/features.txt 
  
feature_names :    

     List of the feature names; extracted from 'features' 
  
activity_labels :    

     List of the activity_labels obtained from UCI HAR Dataset/activity_labels.txt
  
activity_identifiers :    

     List of numerical acitivity identifiers extracted from UCI HAR Dataset/test/y_test.txt  
  
activity_identifiers_train :     

     List of numerical acitivity identifiers extracted from UCI HAR Dataset/train/y_train.txt  
  
activity_number:    

     Numerical value of an activity; extracted from activity_labels  
  
activity_names :    

     Names of the activities; extracted from activity_labels   
  
activity_name :     

     FUNCTION that replaces an number that characterizes an activity by the corresponding name of that activity
  
activity :    

     Replaces the numerical value of activity_identifiers by the corresponding activity name
  
subject_train :    

     The subjects in the train data  
  
subject_test :     

     The subjects in the test data   
  
subject :    

     All subjects = subject_train + subject_test
  
subject_activity :     

     All subjects and their activities
  
-------------------------
 Variables used in STEP 2
-------------------------
  
find_fragment :     

     FUNCTION which locates a given character sequence in a character variable. 
                                        Here it is used to identify features which have a name that contains either 
                                        the sequence 'mean' or 'std' in their name. The function 'regexpr' return a 
                                        value <0 when the sought character sequence is present in the variable.
  
mean_true :     

     Boolean which states which elements in feature_names contain the character set 'mean'
  
std_true :     

     Boolean which states which elements in feature_names contain the character set 'std'
  
data_selection :     

     Boolean which states which elements in feature_names contain the character set 'mean' or the character set 'std
  
feature_selection :     

     All elements of feature_names which refer to mean-data and std-data
  
mean_std_Data :     

     Numerical data assiociated to feature_selection
  
-------------------------
 Variables used in STEP 3
-------------------------
  
mean_std_Data_descr :     

     mean_std_Data + labels for activities and labels for the subjects 
  
-------------------------
 Variables used in STEP 4
-------------------------
  
sub_act_text :     

     An array containing the words 'subject' and 'activity'
  
column_labels :     

     An array combining sub_act_text and feature_selection; to be used as column names 
  
-------------------------
 Variables used in STEP 5
-------------------------
  
dataTable :     

     mean_std_Data_descr as datatable 
  
number_subjects :     

     The number of subjects that contributed to the test
  
dim_act :     

     The dimension of the datatable 'activity_names'  
  
num_act :     

     The number of different activities   
  
start :     

     Boolean to identify the first step in a for loop  
  
isubject :     

     Subject identifier in the loop over the subjects; runs from 1 to number_subjects 
  
data_Subject :     

     That part of the total data set that is associated to subject 'isubject'   
  
iact :     

     Numerical activity identifier; runs from 1 to num_act
  
a_n :     

     Name of the activity associated to iact   
  
data_subj_act :     

     That part of the total data set that is associated to subject 'isubject' and activity 'iact'  
  
ssdata_subj_act :     

     Subset of data_subj_act that contains only the numerical values of the experiments   
  
mean_subj_act :     

     The mean values calculated from ssdata_subj_act  
  
meanValues :     

     Matrix containing the data mean_subj_act for all subjects and all activities  
  
table_subj_act :     

     Table containing all subject & activity combinations  
  
newDataSet :     

     Datatable that combines the meanvalues with the table_subj_act. 
                      It is the final output of this program  
  
