setwd("~/Volume1/Nov_L2k/mergeL1000/")
# setwd("~/Desktop/mergeL1000/")
FC2<-list.files(pattern = "*_P.csv") #TSV
FC2 <- lapply(FC2, read.csv, header=TRUE,sep=',')


D<-merge(FC2[[1]],FC2[[2]],all=TRUE)
D<-merge(D,FC2[[3]],all=TRUE)d
# D<-merge(D,FC2[[4]],all=TRUE)
D<-merge(D,FC2[[5]],all=TRUE)
D<-merge(D,FC2[[6]],all=TRUE)
D<-merge(D,FC2[[7]],all=TRUE)
D<-merge(D,FC2[[8]],all=TRUE)
D<-merge(D,FC2[[9]],all=TRUE)

# DD<-t(D)
# colnames(DD)<-DD[1,]
# DD<-DD[-1,]
# # EE<-DD[,!duplicated((DD[1,]))]
# rm(D)

JJ<-t(C)
colnames(JJ)<-JJ[1,]
JJ<-JJ[-1,]
FF<-JJ[,!duplicated((DD[1,]))]

# 
# A<-t(FC2[[1]])
# colnames(A)<-A[1,]
# A<-A[-1,]
# AA<-A[,unique(colnames(A))]
# AAA<-data.frame(AA)
# 
# B<-t(FC2[[2]])
# colnames(B)<-B[1,]
# B<-B[-1,]
# BB<-B[,unique(colnames(B))]
# BBB<-data.frame(BB)
# 
# C<-merge(AA,BB,all.y=TRUE,suffixes=c('a','b'))
# 
# for(i in 2:length(FC2)){
#   B<-t(FC2[[i]])
#   colnames(B)<-B[1,]
#   B<-B[-1,]
#   B<-B[,unique(colnames(B))]
#   B<-data.frame(B)
# C<-merge(A,B,by=rownames,suffixes = c("1","2"))#this will keep everything, inserting NA where necessary
# }

# completeFun <- function(data, desiredCols) {
#   completeVec <- complete.cases(data[, desiredCols])
#   return(data[completeVec, ])
# }

# DF<-EE[complete.cases(EE), ]#remove all row/column with NA
DF<-FF[complete.cases(FF), ]
# write.csv(DF,"8cancerL1000_P.csv")
write.csv(DF,"8cancerL1000_Y.csv")