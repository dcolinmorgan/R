library(ggplot2);library(readr);library(reshape2);library(grid)
NB<-read.table("~/Dropbox/SciLifeLab/git/python/Bolasso_bootstrap_N10_5FDR_sanity_check_results_25-Jan-2018.tsv",header=TRUE, sep="\t")
long <- melt(NB, id.vars = c("zetavec","SNR","dataset","MCC","bootstrap"))
# NBd<-unique(NB$dataset)#[1:16]
# # NBi<-unique(NB$zetavec)
# data2<-long[long$SNR==0.01,]
# data3<-long[long$SNR==0.1,]
# data4<-long[long$SNR==1,]
# data5<-long[long$SNR==10,]
# unique(data1$bootstrap)
data1<-long[long$SNR==0.1,]
d1NB<-data1[data1$bootstrap=='NestBoot',]
d1noNB<-data1[data1$bootstrap=='without NestBoot',]
p1<-hist(unique(d1NB$MCC)-unique(d1noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=0.1",xlim=c(-1,1))
abline(v=0,col="red")

# d1NB<-data1[data1$bootstrap=='NestBoot',]
# d1noNB<-data1[data1$bootstrap=='without NestBoot',]
# d2NB<-data1[data2$bootstrap=='NestBoot',]
# d2noNB<-data1[data2$bootstrap=='without NestBoot',]
# d3NB<-data1[data3$bootstrap=='NestBoot',]
# d3noNB<-data1[data3$bootstrap=='without NestBoot',]
# d4NB<-data1[data4$bootstrap=='NestBoot',]
# d4noNB<-data1[data4$bootstrap=='without NestBoot',]
# d5NB<-data1[data5$bootstrap=='NestBoot',]
# d5noNB<-data1[data5$bootstrap=='without NestBoot',]



# p1<-hist(unique(d1NB$MCC)-unique(d1noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=0.001")
# p2<-hist(unique(d2NB$MCC)-unique(d2noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=0.01")
# p3<-hist(unique(d3NB$MCC)-unique(d3noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=0.1")
# p4<-hist(unique(d4NB$MCC)-unique(d4noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=1")
# p5<-hist(unique(d5NB$MCC)-unique(d5noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC Glmnet SNR=10")
# 
# # p1<-ggplot(data=data1,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("Glmnet SNR==0.001" ) #+
# #   # xlab("Dose (mg)") + ylab("Teeth length")
# # p2<-ggplot(data=data2,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("Glmnet SNR==0.01" ) #+
# # p3<-ggplot(data=data3,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("Glmnet SNR==0.1" ) #+
# # p4<-ggplot(data=data4,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("Glmnet SNR==1" ) #+
# # p5<-ggplot(data=data5,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("Glmnet SNR==10" ) #+
# 
# multiplot(p1, p2, p3, p4, p5, cols=2)




NB2<-read.table("~/Dropbox (Personal)/SciLifeLab/git/python/BoRNI_bootstrap_N10_5FDR_sanity_check_results_25-Jan-2018.tsv",header=TRUE, sep="\t")
long2 <- melt(NB2, id.vars = c("zetavec","SNR","network","MCC","bootstrap"))
# NBn<-unique(NB2$network)

data2<-long2[long2$SNR==10,]
d2NB<-data2[data2$bootstrap=='NestBoot',]
d2noNB<-data2[data2$bootstrap=='without NestBoot',]
p2<-hist(unique(d2NB$MCC)-unique(d2noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC RNICO SNR=10",xlim=c(-1,1))
abline(v=0,col="red")

# data2<-long[long$dataset==NBn[15]&long$SNR==0.001,]
# unique(data1$bootstrap)
# data1<-long2[long2$network==NBn[4]&long2$SNR==0.001,]
# data2<-long2[long2$network==NBn[4]&long2$SNR==0.01,]
# data3<-long2[long2$network==NBn[4]&long2$SNR==0.1,]
# data4<-long2[long2$network==NBn[4]&long2$SNR==1,]
# data5<-long2[long2$network==NBn[4]&long2$SNR==10,]
# # unique(data1$bootstrap)
# p1<-ggplot(data=data1,aes(x=log(zetavec), y=(MCC),color=bootstrap))+geom_line()+ ggtitle("RNI SNR==0.001" ) #+
# # xlab("Dose (mg)") + ylab("Teeth length")
# p2<-ggplot(data=data2,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("RNI SNR==0.01" ) #+
# p3<-ggplot(data=data3,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("RNI SNR==0.1" ) #+
# p4<-ggplot(data=data4,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("RNI SNR==1" ) #+
# p5<-ggplot(data=data5,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("RNI SNR==10" ) #+
# 
# multiplot(p1, p2, p3, p4, p5, cols=2)




NB3<-read.table("~/Dropbox/SciLifeLab/git/python/Bolsco_bootstrap_N10_5FDR_sanity_check_results_24-Jan-2018.tsv",header=TRUE, sep="\t")
long3 <- melt(NB3, id.vars = c("zetavec","SNR","dataset","MCC","bootstrap"))
# NBd<-unique(NB$dataset)#[1:16]
# NBi<-unique(NB$zetavec)

data3<-long3[long3$SNR==10 ,]
d3NB<-data3[data3$bootstrap=='With NestBoot',]
d3noNB<-data3[data3$bootstrap=='without NestBoot',]
p3<-hist(unique(d3NB$MCC)-unique(d3noNB$MCC),xlab="MCC_boot - MCC_noboot",main="Delta MCC LSCO SNR=10",xlim=c(-1,1))
abline(v=0,col="red")

# data1<-long[long$dataset==NBd[5]&long$SNR==0.001,]
# data2<-long[long$dataset==NBd[5]&long$SNR==0.01,]
# data3<-long[long$dataset==NBd[5]&long$SNR==0.1,]
# data4<-long[long$dataset==NBd[5]&long$SNR==1,]
# data5<-long[long$dataset==NBd[5]&long$SNR==10,]
# # unique(data1$bootstrap)
# p1<-ggplot(data=data1,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("LSCO SNR==0.001" ) #+
# # xlab("Dose (mg)") + ylab("Teeth length")
# p2<-ggplot(data=data2,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("LSCO SNR==0.01" ) #+
# p3<-ggplot(data=data3,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("LSCO SNR==0.1" ) #+
# p4<-ggplot(data=data4,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("LSCO SNR==1" ) #+
# p5<-ggplot(data=data5,aes(x=log(zetavec), y=MCC,color=bootstrap))+geom_line()+ ggtitle("LSCO SNR==10" ) #+

multiplot(p1, p2, p3, cols=1)


# cc<-data.frame()
# for (i in 1:length(long$dataset))
# unique(long$bootstrap[long$dataset==NBd[i]]){
#   length(unique(long$bootstrap[long$dataset==NBd[i]]))==2
#   cc$index[i]<- i
# }
