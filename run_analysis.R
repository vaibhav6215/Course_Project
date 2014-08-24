X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
features<-read.table("UCI HAR Dataset/features.txt")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
X<-rbind(X_train,X_test)
Y<-rbind(y_train,y_test)
activity<-merge(Y,activity_labels,all=TRUE)
activity<-data.frame(activity$V2)
feature_name<-as.character(features[,2])
names(X)<-c(feature_name)
names(activity)<-"Activity"
Subject<-rbind(subject_train,subject_test)
names(Subject)<-"Subject"
Dat1<-data.frame()
Dat1<-cbind(X,Subject,activity)
Dat2<-cbind(Dat1[,grep("*mean",names(Dat1))],Dat1[,grep("*std()",names(Dat1))])
Dat2<-cbind(activity,Subject,Dat2)
Final_Dat<-data.frame()
Dat3<-data.frame()
for(i in 1:6)
{
        
        for(j in 1:30)
        {
                Dat3<-Dat2[which(Dat2$Activity==activity_labels[i,2] & Dat2$Subject==j),]
                Final_Dat<-rbind(Final_Dat,colMeans(Dat3[,-1]))
        }
}
a<-rep(c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"),each=30)
b<-rep(1:30,6)
Final_Dat<-cbind(a,b,Final_Dat)
Final_Dat<-Final_Dat[,-3]
names(Final_Dat)<-names(Dat2)
Final_Dat<-Final_Dat[complete.cases(Final_Dat),]
print(Dat2)
