run_analysis<-function(){
    ##install and lib package
    install.packages("dplyr")
    install.packages("tidyr")
    install.packages("reshape2")
    
    
    library("dplyr")
    library("tidyr")
    library("reshape2")
######################################################
    ##read test files
    X_test<-read.table("./test/X_test.txt")
    ##View(X_test)
    y_test<-read.table("./test/y_test.txt")
    subject_test<-read.table("./test/subject_test.txt")
    
    ##read train files
    X_train<-read.table("./train/X_train.txt")
    y_train<-read.table("./train/y_train.txt")
    subject_train<-read.table("./train/subject_train.txt")
    ##read featrue and activity_lables files
    features<-read.table("./features.txt")
    activity_lables<-read.table("./activity_labels.txt")
    ##change to tb_df
    features<-tbl_df(features)
    activity_lables<-tbl_df(activity_lables)  
    X_test<-tbl_df(X_test)
    X_train<-tbl_df(X_train)
    y_train<-tbl_df(y_train)
    y_test<-tbl_df(y_test)
    subject_test<-tbl_df(subject_test)
    subject_train<-tbl_df(subject_train)
#######################################################
##1.  整合培训和测试集，创建一个数据集。
##cbind
name_test<-cbind(y_test,subject_test) 
name_train<-cbind(y_train,subject_train) 
## change names
colnames(name_train)[1]<-"activity"
colnames(name_train)[2]<-"subject"

colnames(name_test)[1]<-"activity"
colnames(name_test)[2]<-"subject"


##rbing test and train !
all_y<-rbind(name_test,name_train)
all_x<-rbind(X_test,X_train)

##rename full data col names!
colnames(all_x)<-features$V2
View(all_x)

##########################################################

##2.  仅提取测量的平均值以及每次测量的标准差。
col_name<-features$V2
##提取含有mean()和std()的列
m_index<-grep("mean()",col_name,fixed = TRUE)
s_index<-grep("std()",col_name,fixed = TRUE) 


## bind mean and std !
m_s_index<-c(m_index,s_index)    
all_m_s<-all_x[,m_s_index]    
all_m_s_y<-cbind(all_m_s,all_y)  
all_m_s_y_name<-all_m_s_y[,-67]

View(all_m_s_y)
######################################################## 

##3.  使用描述性活动名称命名数据集中的活动
##4.  使用描述性变量名称恰当标记数据集。   
##改变activity的名字
activity<-activity_lables[all_m_s_y$activity,2]
all_m_s_y_name<-cbind(all_m_s_y_name,activity)
colnames(all_m_s_y_name)[68]<-"activity"
View(all_m_s_y_name)
#########################################################
##5.  从第4步的数据集中，针对每个活动和每个主题使用每个表里的平均值建立第2个独立的整洁数据集。   
##提取
all_m_s_y_tb<-tbl_df(all_m_s_y)
all_tidy_mean <- melt(all_m_s_y_tb,id.vars=c("subject","activity"))
##求mean
all_tidy_mean<-dcast(all_tidy_mean,subject+activity~variable,mean)
View(all_tidy_mean)

########################################################
##write to files
##1.Merges the training and the test sets to create one data set.
##write.table(all_x,"all_x.txt",row.name=FALSE)
##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##write.table(all_m_s_y,"all_m_s_y.txt",row.name=FALSE)
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names. 
##write.table(all_m_s_y_name,"all_m_s_y_name.txt",row.name=FALSE)
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(all_tidy_mean,"all_tidy_mean.txt",row.name=FALSE)

}















  







