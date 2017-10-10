#----------------------1: Combine Data
setwd("~/Desktop/Coursera/Data Science/Assignment/3.Clean/UCI HAR Dataset")
train_subject <- read.table('train/subject_train.txt', header = F)
train_X<-read.table('train/X_train.txt', header = F)
train_y<-read.table('train/y_train.txt', header = F)
test_subject<-read.table('test/subject_test.txt', header = F)
test_X<-read.table('test/X_test.txt', header = F)
test_y<-read.table('test/y_test.txt', header = F)
train_dt<-cbind(train_subject, train_y,train_X)
test_dt<-cbind(test_subject, test_y,test_X)
com_data<-rbind(train_dt, test_dt)
colnames(com_data)<-c('subject', 'activities', 'info')
#----------------------2: Extract mean and std
features<-read.table('features.txt')
com_data2<-com_data[,c(1,2,features[grep('-(mean|std)\\(\\)', features[,2]),2])]

#----------------------3: Name activities
activities<-read.table('activity_labels.txt')
com_data2[,2]<-activities[com_data2[,2],2]

#----------------------4: Labels data
colnames(com_data2) <- c('subject','activity', gsub('-(mean|std)\\(\\)', '',
                                                    msfeature))
#----------------------5: create data
aggmean = aggregate(com_data2[,c(-1,-2)], by = list(com_data2$subject, com_data2$activity),mean)

write.table(aggmean, file = 'FinalData.txt', row.names = F)








