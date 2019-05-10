library(readr)
library(ggplot2)
# data <- read_csv("~/Dropbox/Sonnhammer_group/plots/nestBoot_MYC/MYC_rss&spearman_inferred - Sheet7(1).csv")
# data <- read_csv("~/Dropbox/Sonnhammer_group/plots/nestBoot_MYC/MYC_rss&spearman_inferred - leaveOut3_D&S.csv") ##this dataset has both singles and doubles data --> plot to g and h then
# data <- read_csv("~/Dropbox/Sonnhammer_group/Data/MYC_ LO3_D+S_WRSSY.csv")
# data22 <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/MYCproject/data/multi_randXrand_D&S.csv")
# data33 <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/MYCproject/data/randXrand_D&S.csv")
# data44 <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/MYCproject/data/overall.csv")

data <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/MYCproject/data/datum.csv")

library(dplyr)
# data22$type<-"Rand_Measured"
# data22$no.links<-data22$no.links
# data33$type<-"Rand_Measured"
# data33$no.links<-data33$no.links
# data44$type<-"Rand_Measured"
# data44$no.links<-data44$no.links
# data<-bind_rows(data,data22,data33,data44)

# data <- read_csv("~/Dropbox/Sonnhammer_group/plots/nestBoot_MYC/MYC_NetCom_LO1.csv")
# data$RSS95<-log10(data$sumWRSSDouble/data$chi2invD) + log10(data$sumWRSSSingle/data$chi2invS)
# data$R2<-log10(-data$RR2_D)+log10(-data$RR2_S)

# c<-strsplit(data$`# sNET`,"_")
# data$type<-sapply(c,"[[",1)
# data$Method<-sapply(c,"[[",3)
# c<-data$type=="FIT"
# data$type[c]<-"Measured"
# c<-data$type=="complimentRandomFit"
# data$type[c]<-"Random"
# c<-data$type=="indegreeRandomFit"
# data$type[c]<-"Random"
# data<-data[!is.na(data$sumWRSSSingle),]
# data<-data[!is.na(data$sumWRSSDouble),]
# write.csv(data,'~/Dropbox/Sonnhammer_group/plots/nestBoot_MYC/MYC_Net_Com_LO3.csv')

# data<-data[(data$Method)!="Botlsco",]
data<-data[(data$no.links)<170,]
data1<-data[(data$type)=="Shuffled",]
data2<-data[(data$type)=="Measured",]
data3<-data[(data$type)=="Rand_Measured",]



e=ggplot() + #singles
  # geom_boxplot(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`SS WRSS(Yobs-Ypred) LOO`+data1$`SS WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  # geom_split_violin(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`SS WRSS(Yobs-Ypred) LOO`+data1$`SS WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75),fill=data$type)+
  #geom_hline(yintercept = log10(9925.3),color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  geom_point(data=data2,aes(x=factor(data2$no.links),y=(log10((data2$`SS WRSS(Yobs-Ypred) LOO`+data2$`SS WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 1, colour = "black", fill = "white", size = 1, stroke = 1)+
  # geom_point(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`SS WRSS(Yobs-Ypred) LOO`+data3$`SS WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 7, colour = "black", fill = "white", size = 1, stroke = 1)+
  theme_classic()+ labs(y = "log wRSS", x = "Nr of inferred links",color = "method")+ ylim(2, 11)


f=ggplot() + #doubles
  geom_boxplot(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`WRSS(Yobs-Ypred) LOO`+data1$`WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  # geom_split_violin(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`WRSS(Yobs-Ypred) LOO`+data1$`WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  #geom_hline(yintercept = log10(3389),color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  geom_point(data=data2,aes(x=factor(data2$no.links),y=(log10((data2$`WRSS(Yobs-Ypred) LOO`+data2$`WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 1, colour = "black", fill = "white", size = 1, stroke = 1)+
  # geom_point(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`WRSS(Yobs-Ypred) LOO`+data3$`WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 7, colour = "black", fill = "white", size = 1, stroke = 1)+
  theme_classic()+ labs(y = "log wRSS", x = "Nr of inferred links",color = "method")+ ylim(2, 11)



g=ggplot() + #singles
  geom_boxplot(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`SS WRSS(Yobs-Ypred) LOO`+data3$`SS WRSS(Pobs-Ppred) LOO`)/(2*3))),fill=Method),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  # geom_split_violin(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`SS WRSS(Yobs-Ypred) LOO`+data1$`SS WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75),fill=data$type)+
  #geom_hline(yintercept = log10(9925.3),color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  geom_point(data=data2,aes(x=factor(data2$no.links),y=(log10((data2$`SS WRSS(Yobs-Ypred) LOO`+data2$`SS WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 4, colour = "black", fill = "white", size = 2, stroke = 1)+
  # geom_point(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`SS WRSS(Yobs-Ypred) LOO`+data3$`SS WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 7, colour = "black", fill = "white", size = 1, stroke = 1)+
  theme_classic()+ labs(y = "log wRSS", x = "Nr of inferred links",fill = "method")+ ylim(2, 11)


h=ggplot() + #doubles
  geom_boxplot(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`WRSS(Yobs-Ypred) LOO`+data3$`WRSS(Pobs-Ppred) LOO`)/(2*3))),fill=Method),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  # geom_split_violin(data=data1,aes(x=factor(data1$no.links),y=(log10((data1$`WRSS(Yobs-Ypred) LOO`+data1$`WRSS(Pobs-Ppred) LOO`)/(2*3))),color=factor(data1$Method)),scale="width",trim=TRUE,draw_quantiles = c(0.25, 0.5, 0.75))+
  #geom_hline(yintercept = log10(3389),color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  geom_point(data=data2,aes(x=factor(data2$no.links),y=(log10((data2$`WRSS(Yobs-Ypred) LOO`+data2$`WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 4, colour = "black", fill = "white", size = 2, stroke = 1)+
  # geom_point(data=data3,aes(x=factor(data3$no.links),y=(log10((data3$`WRSS(Yobs-Ypred) LOO`+data3$`WRSS(Pobs-Ppred) LOO`)/(2*3)))),shape = 7, colour = "black", fill = "white", size = 1, stroke = 1)+
  theme_classic()+ labs(y = "log wRSS", x = "Nr of inferred links",fill = "method")+ ylim(2, 11)


# 
# 
# g=ggplot(data,aes(x=factor(data$X85),y=(log10(data$`R2 ratio`)),color=factor(data$Method)))+geom_boxplot()+theme_classic()+ labs(y = "log R2 ratio", x = "Nr of inferred links",color = "method")+geom_hline(yintercept = 0,color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))#+ scale_x_discrete(name="Link Number", breaks=factor(data$X85)[c(T, rep(F, 4))])
# 
# h=ggplot(data,aes(x=factor(data$X85),y=(log10(data$`R2 ratio ss`)),color=factor(data$Method)))+geom_boxplot()+theme_classic()+ labs(y = "log R2 ratio", x = "Nr of inferred links",color = "method")+geom_hline(yintercept = 0,color="grey")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
# 
# ##test figure example
# data<-data[(data$Method)!="Bolasso",]
# data<-data[(data$Method)!="Bolsco",]
# g=ggplot(data,aes(x=factor(data$X85),y=(log10(data$`R2 ratio`)),color=factor(data$Method)))+geom_boxplot()+theme_classic()+ labs( y = "log R2 ratio", x = "link number",color = "method")+geom_hline(yintercept = 0,color="grey")+ theme(legend.position="none")
# 
# g+ theme(axis.line=element_blank(),axis.text.x=element_blank(),
#          axis.text.y=element_blank(),axis.ticks=element_blank(),
#          axis.title.x=element_blank(),
#          axis.title.y=element_blank(),legend.position="none",
#          panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
#          panel.grid.minor=element_blank(),plot.background=element_blank())
