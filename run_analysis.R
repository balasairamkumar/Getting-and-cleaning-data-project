
#Load the Training and testing dataset and merge them

Xtrain<-read.delim('train/X_train.txt',header=FALSE,sep="")
Ytrain<-read.delim('train/y_train.txt',header=FALSE,sep="")
Xtest<-read.delim('test/X_test.txt',header=FALSE,sep="")
Ytest<-read.delim('test/Y_test.txt',header=FALSE,sep="")
Ytest<-read.delim('test/y_test.txt',header=FALSE,sep="")
traindata<-cbind(Xtrain,Ytrain)
testdata<-cbind(Xtest,Ytest)
mergeddata<-rbind(traindata,testdata)

#load subjects and merge it to mergeddata
subjectTrain<-read.delim('train/subject_train.txt',header=F)
subjectTest<-read.delim('test/subject_test.txt',header=F)
subject<-rbind(subjectTrain,subjectTest)
mergeddata<-cbind(subject,mergeddata)


#load feature lables and assign it to columns of merged dataset
lables<-read.delim('features.txt',header=F,sep="")
colnames(mergeddata)[2:562]<-lables[,2]
colnames(mergeddata)[563]<-"activity"
colnames(mergeddata)[1]<-"subject"

#Extracts only the measurements on the mean and standard deviation for each measurement
meanStdCols<-grep(pattern='mean()|meanFreq()|std()',colnames(mergeddata))
meanStdColsData<-mergeddata[,meanStdCols]



#load descriptive activity lables
#Assign Descriptive Activity labels to the Activity label column
activityLables<-read.delim('activity_labels.txt',header=F,sep="")
mergeddata$activity<-as.character(mergeddata$activity)
mergeddata$activity<-sub(pattern="1",replacement=activityLables[1,2],mergeddata$activity)
mergeddata$activity<-sub(pattern="2",replacement=activityLables[2,2],mergeddata$activity)
mergeddata$activity<-sub(pattern="3",replacement=activityLables[3,2],mergeddata$activity)
mergeddata$activity<-sub(pattern="4",replacement=activityLables[4,2],mergeddata$activity)
mergeddata$activity<-sub(pattern="5",replacement=activityLables[5,2],mergeddata$activity)
mergeddata$activity<-sub(pattern="6",replacement=activityLables[6,2],mergeddata$activity)

#Assign Descriptive Variable Namescolnames(mergeddata)<-sub(pattern="fbodybodygyrojerkmag",replacement="gyrojerkmag",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodybodygyromag",replacement="gyromag",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodybodyaccjerkmag",replacement="jerkmag",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodybodygyrojerkmag",replacement="gyrojerkmag",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodyaccmag",replacement="accmag",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodyacc",replacement="acc",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="fbodygyro",replacement="gyro",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="tbodyacc",replacement="bodyacc",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="tgravityacc",replacement="gravityacc",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="tbodygyro",replacement="tbodygyro",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="tbodygyro",replacement="bodygyro",x=colnames(mergeddata))
colnames(mergeddata)<-sub(pattern="tbodygyromag",replacement="bodygyromag",x=colnames(mergeddata))
colnames(mergeddata)<-gsub(pattern="-",replacement='',x=colnames(mergeddata))
colnames(mergeddata)<-gsub(pattern="\\(|\\)",replacement='_',x=colnames(mergeddata))

#creates a tidy dataset with average of each variable for each activity and each subject
aggsubject<-data.frame(1,sort(unique(mergeddata$subject)))
for(colNum in 2:562){
        temp<-aggregate(x=mergeddata[,colNum],by=list(mergeddata$subject),mean,data=mergeddata)
        aggsubject<-cbind(aggsubject,temp[,2])
        temp
        
}

aggsubject<-aggsubject[,c(-1,-2)]
colnames(aggsubject)<-colnames(mergeddata)[2:562]

aggactivity<-data.frame(1,length(unique(mergeddata$activity)))
for(colNum in 2:562){
        temp<-aggregate(x=mergeddata[,colNum],by=list(mergeddata$activity),mean,data=mergeddata)
        aggactivity<-cbind(aggactivity,temp[,2])
        temp
        
}

aggactivity<-aggactivity[,c(-1,-2)]
colnames(aggactivity)<-colnames(test)[2:562]

aggactivity<-cbind(activityLables[,2],aggactivity)
aggsubject<-cbind(sort(unique(mergeddata[,1])),aggsubject)
colnames(aggsubject)[1]<-'subject'