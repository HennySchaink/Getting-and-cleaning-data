run_analysis<-function() {
  
##################################################################################################
##  A R-code function that restores a dataset. The URL of the data to be handled:
##  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##################################################################################################  

############################################################################## 
##  STEP 1   reading the data and combining the test and train data
############################################################################## 

## >>>>  reading the data from UCI HAR Dataset/test <<<<

fileName<-"UCI HAR Dataset/test/X_test.txt"
X_test=read.table(fileName)   
dimension<-dim(X_test)
print(dimension)

## >>>>  reading the data from UCI HAR Dataset/train <<<<

fileName<-"UCI HAR Dataset/train/X_train.txt"
X_train=read.table(fileName)   
dimension<-dim(X_train)
print(dimension)

## >>>> combining X_test and X_train

allData <-rbind(X_train,X_test)
dimension<-dim(allData)
print(dimension)

## ----------------------------------------------------------------------------
## ************  reading the information about the measured features
## ----------------------------------------------------------------------------

## >>>>  reading the data from UCI HAR Dataset/features.txt <<<<

fileName<-"UCI HAR Dataset/features.txt"
features=read.table(fileName)   
feature_names<-as.character(features[[2]])
dimension<-dim(feature_names)

## ----------------------------------------------------------------------------
## ************  reading the information about the different activities
## ----------------------------------------------------------------------------

## >>>>  reading the data from UCI HAR Dataset/activity_labels.txt <<<<

fileName<-"UCI HAR Dataset/activity_labels.txt"
activity_labels=read.table(fileName)   

## >>>>  reading the activity identifiers     <<<<
## >>>>  from UCI HAR Dataset/test/y_test.txt <<<<

fileName<-"UCI HAR Dataset/test/y_test.txt"
activity_identifiers=read.table(fileName)   

## >>>>  reading the activity identifiers       <<<<
## >>>>  from UCI HAR Dataset/train/y_train.txt <<<<

fileName<-"UCI HAR Dataset/train/y_train.txt"
activity_identifiers_train=read.table(fileName)   

## >>>>  merge the activity labels of the test data and the train data

activity_identifiers<-rbind(activity_identifiers_train,activity_identifiers)

activity_number<-activity_labels[1]
activity_names<-activity_labels[2]

##-------------------------------------------------------------------------
## >>>>  a function that translates activity labels into activity names <<<
##-------------------------------------------------------------------------

activity_name<-function(alabel,activity_names){
  activity<-activity_names[[1]][alabel]
  activity
}

activity<-(sapply(activity_identifiers,activity_names,FUN=activity_name) ) 
activity<-array(activity)


## ----------------------------------------------------------------------------
## ************  reading the information about the different subjects in the test
## ----------------------------------------------------------------------------

## >>>>  reading the data from UCI HAR Dataset/train/subject_train.txt <<<<

fileName<-"UCI HAR Dataset/train/subject_train.txt"
subject_train=read.table(fileName)    

## >>>>  reading the data from UCI HAR Dataset/test/subject_test.txt <<<<

fileName<-"UCI HAR Dataset/test/subject_test.txt"
subject_test=read.table(fileName)   

## >>>>  merging the train and test set

subject<-rbind(subject_train,subject_test)

## >>>> merging the activity list with the subject list

subject_activity <- cbind(subject,activity)

  
############################################################################
##     STEP 2 :    selection of the mean- and st.dev. data
############################################################################


print(">>>> step 2")

##-------------------------------------------------------------------
## --- Function that locates a chosen text fragment in feature_names.
## --- The vector true contains information in which elements of
## --- feature_names this chosen fragment can be found
##-------------------------------------------------------------------


find_fragment<-function (f_names,fragment) {
  
  features<-regexpr(fragment,f_names)
  true<-features>0
  true
  
}

## >>>>  selection of the features 'mean' and 'std'

mean_true <- find_fragment(feature_names,"mean")

std_true <- find_fragment(feature_names,"std")

data_selection <- mean_true | std_true

feature_selection <-array(feature_names[data_selection==TRUE])

## >>>> selection of the mean- and std-data

mean_std_Data <- allData[data_selection==TRUE]


############################################################################
##    STEP 3  :appropriate descriptive names for the activities +
##            subject information are linked to the database with 
##            the experimental data
############################################################################

print(">>>> step 3")

mean_std_Data_descr<-cbind(subject_activity,mean_std_Data)

############################################################################
##    STEP 4  :appropriate descriptive labels for the variables 
##             (i.e.) features are linked to the database
############################################################################
print(">>>> step 4")

sub_act_text<-array(c("Subject","Activity"))

column_labels<- array(c(sub_act_text,feature_selection))

names(mean_std_Data_descr) <-column_labels

## write.table(mean_std_Data_descr,file="mean_std_Data_descr.txt")


############################################################################
##    STEP 5  : construction of a data set with the 
##              average of each variable for each activity and each subject            
############################################################################

print(">>>> step 5")

library(data.table)

dataTable=data.table(mean_std_Data_descr)

## >>>> calculation of the number of subjects in the test

number_subjects<-max(as.integer(mean_std_Data_descr[[1]]),na.rm=TRUE)

## >>>> calculation of the number of activities

dim_act<-dim(activity_names)
num_act<-dim_act[[1]]

##--------------------------------------
## >>>> loop over the subjects     <<<<<
##--------------------------------------
## number_subjects<-2

start=TRUE

for (isubject in 1:number_subjects) { 
  
  data_Subject<-dataTable[dataTable$Subject==isubject]

##--------------------------------------
##  >>>> loop over the activities   <<<<
##--------------------------------------
##  num_act<-2

  for (iact in 1:num_act) {

      a_n<-activity_names[iact,1]

      data_subj_act<-data_Subject[data_Subject$Activity==a_n ]

##  >>>> construction of a matrix which contains 
##  >>>> only the experimental feature values tabulated in data_subj_act
##  >>>> and the calculation of the mean values of each column of this matrix

      ssdata_subj_act<-subset(data_subj_act,select=feature_selection)
      mean_subj_act<-colMeans(ssdata_subj_act)

##  >>>> construction of a matrix which contains 
##  >>>> for each subject and each activity 
##  >>>> the mean values of the features

      Subject<-isubject
      Activity<-a_n

     if(start==TRUE) {
       
        meanValues<-mean_subj_act
        table_subj_act<-data.frame(Subject,Activity)
        start=FALSE
        
         }   else {
           
        meanValues<-rbind(meanValues,mean_subj_act )   
        table_subj_act<-rbind(table_subj_act,data.frame(Subject,Activity) )
     }

##------------------------------------------
##  >>>> END loop over the activities   <<<<
##------------------------------------------

  }

##----------------------------------------
## >>>> END loop over the subjects     <<<<<
##----------------------------------------

}


## >>>> contruction of the final dataset

newDataSet<-data.frame(table_subj_act,meanValues)
print(dim(newDataSet))

write.table(newDataSet,file="newDataSet.txt",row.name=FALSE)



##------------------------------------
## >>>>   end of program   <<<<<
##------------------------------------

}