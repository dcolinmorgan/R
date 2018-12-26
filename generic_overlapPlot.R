data<-read.table("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Bolasso/linkMYCBolasso524-Feb-2017/cytoscape_net/Bolasso_network_L1531_M115_support99.9_2.20e-04.tsv",header=TRUE, sep="\t")


# data[1:1001,11]<-(as.numeric(data[1:1001,9])/max(as.numeric(data[1:1001,9])))
# data[1:1001,11]<-(as.numeric(as.character(data[1:1001,9]))+(max(as.numeric(as.character(data[1:1001,6])))-max(as.numeric(as.character(data[1:1001,9])))))
# colnames(data)[colnames(data)=="V11"] <- "overlap_MYC"
data<-data.frame(data[1:1000,c(1,2,3)])
# data$SIGNSIGNoverlap_MYC<-as.numeric(data$SIGNoverlap_MYC)+(max(as.numeric(data$overlap_shuffle))-max(as.numeric(data$SIGNoverlap_MYC)))

# zee<-"lassoMYCsignlinkcutdata"
# cutoffs<-(ggg[[zee]])
# cutoff<-(cutoffs[[12]])
# cutoff<-data.frame(cutoff)
# cutoff$CUT<-.98#cutoff$support.at.cross
library(ggplot2)
library(plotly)
require(pracma)

library(reshape2)
long <- melt(data, id.vars ='bins')
# long$X0<-as.numeric(long$bins)
# long$value<-as.numeric(long$value)
intercept1=.98#cutoff$support.at.cross2[2]
# ccc=max(long[c(10:1001,1010:2002),]$value)

subdata = subset(long,bins>.98,bins<=1)
ss=data.frame(subdata$bins[1:20])
ss$bins = subdata$bins[1:20]
ss$ymin= subdata$value[21:40]
ss$ymax= subdata$value[1:20]

ggplot(data=long,aes(bins,value,colour=variable))+geom_line()+theme_bw()+
  xlab("Support")+ylab("Frequency")+ scale_x_continuous(limits = c(.75, 1))+scale_y_continuous(limits = c(0, .005))+theme(legend.position="none") +geom_vline(xintercept=.98) +geom_ribbon(data = subset(long,bins>.98,bins<=1), aes(ymin=value,ymax=value2,x=bins),fill="blue",alpha=".5")

data = subset(long,bins>.98,bins<=1)
data = long[c(980:1000,1980:2000),]

ggplot(data=data,aes(x=bins,y=MYC))+geom_line(aes(y=MYC,color="Links Inferred from Data"),)+geom_line(aes(y=shuffle,color="Links Inferred from Randomized Data"))+theme_bw()+  xlab("Support")+ylab("Frequency")+ scale_x_continuous(limits = c(.8, 1))+scale_y_continuous(limits = c(0, .005))+theme(legend.position=c(.4,.75),text = element_text(size=15),legend.title=element_blank()) +geom_vline(xintercept=.98) +geom_ribbon(data = subset(data,bins>=.98,bins<=1), aes(ymin=shuffle,ymax=MYC,x=bins),colour="grey30",linetype=2,fill="blue2",alpha=".4") +geom_ribbon(data = subset(data,bins>=.98,bins<=1), aes(ymin=0,ymax=shuffle,x=bins),colour="grey50",linetype=3,fill="red",alpha=".4") +scale_colour_manual(values=c("blue1", "red1"))




#+ geom_density(data=long[c(1980:2000),],aes(bins,value,colour=variable,fill=variable))
#+ #,legend.title=element_blank())+   geom_area(data=(long[201:400,]),aes(X0,value,fill=(variable)),alpha=.1, position='identity')


AUC = trapz(data$bins[(1000-i):1000],data$MYC[(1000-i):1000])
shAUC = trapz(data$bins[(1000-i):1000],data$shuffle[(1000-i):1000])
shAUC/(AUC+shAUC)



# geom_vline(xintercept=intercept1)+
# scale_x_continuous(sec.axis = sec_axis(~./1000))+
# scale_y_continuous(sec.axis = sec_axis(~.*ccc,name="Frequency"))+
geom_line(x=.98,colour='black',size=1)+
  geom_line(x=.98,colour='grey',size=1)  #guides(colour=FALSE)+
# scale_color_manual(breaks=c("SIGN_MYC","SIGNshuffle"),name="combined legend",values=c("overlap_MYC"=NA, "overlap_shuffle"=NA,"SIGN_MYC"="blue2", "SIGNshuffle"="red2"))+
# scale_fill_manual(breaks=c("overlap_MYC","overlap_shuffle"),name="combined legend",values=c("overlap_MYC"="blue4", "overlap_shuffle"="red4","SIGN_MYC"="blue2", "SIGNshuffle"="red2"))
# scale_fill_discrete(breaks=c("overlap_MYC","overlap_shuffle"))
# 
# 
# # p11<-ggplot(cc[1:429,],aes(log10(x), log10(y)))+ geom_point(aes(colour = factor(ss)))+ labs(x="WRSS(Yobs)",y="WRSS(Pobs)", subtitle="Inferred v Random Performance")
# 
# sub <- gg + geom_rect(data=long[c(10:1001,1010:2002),],xmin=.8, ymin=0, xmax=1, ymax=1, fill="grey", alpha=0.5)
# sub$layers <- rev(sub$layers) # draw rect below
# 
# gg #+ annotation_custom(ggplotGrob(sub), xmin=.81, xmax=.9, ymin=.35, ymax=.75) +
# +scale_x_continuous(limits=c(0.8, 1)) + scale_y_continuous(limits=c(0,1)) + labs(title="Bootstrap Support by Overlap and Frequency")+scale_y_continuous(sec.axis = sec_axis(~.*ccc,name="Frequency"))+theme(legend.position=c(.6,.55),legend.title=element_blank())



# hive1 <- edge2HPD(edge_df = long[c(10:1001,1010:2002),])
# hive2 <- mineHPD(hive1, option = "rad <- tot.edge.count")
# hive3 <- mineHPD(hive2, option = "axis <- source.man.sink")
# hive4 <- mineHPD(hive3, option = "remove zero edge")
# plotHive(hive4, method = "abs", bkgnd = "white", axLabs = c("source", "hub", "sink"), axLab.pos = 1)




# ww<-plotly_build(gg) %>% add_trace(x = cutoff$CUT[1], y = c(0,1),type='scatter',mode='lines',name="support at cutoff") %>% add_trace(x = cutoff$sparsity[1], y = c(0,1),type='scatter',mode='lines',name="sparsity")%>%
#   layout(legend = list(orientation = 'h'))
# 
# ww  %>%layout(
#   title = "Bootstrap Support",
#   xaxis = list(title="Support"),
#   yaxis = list(range=c(0,1),side = 'left',title="Overlap"),
#   yaxis2 = list(range = c(0, ccc), side = 'right', overlaying = "y",title="Frequency")
# )
# 
# Sys.setenv("plotly_username"="dcolinmorgan")
# Sys.setenv("plotly_api_key"="lqg9C8LlefC3OrL4MQME")
# api_create(ww, filename = "1531overlap")