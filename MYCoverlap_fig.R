#### Load necessary packages and data ####

library(reshape2)

require(visNetwork, quietly = TRUE)
#### LOAD ####
setwd("~/Dropbox/SciLifeLab/git/R/GSnetApp/")
load("lassodataBSUB2017-09-08.rdata")
load("lassodataMYC2017-02-06.rdata")

# ### LOAD PLOT DATA ###
load("lassoMYCsignlinkplotdata2017-02-08.rdata")
load("lassoMYClinkplotdata2017-02-08.rdata")

eee<-list(lassoMYCsignlinkplotdata=lassoMYCsignlinkplotdata)
wee<-"lassoMYCsignlinkplotdata"
datum<-(eee[[wee]])
data<-data.frame(datum[[12]])
data[1:1001,11]<-(as.numeric(as.character(data[1:1001,9]))+(max(as.numeric(as.character(data[1:1001,6])))-max(as.numeric(as.character(data[1:1001,9])))))
colnames(data)[colnames(data)=="V11"] <- "Overlap"
data<-data.frame(data[1:1001,c(2,7,8,6,11)])
ggg<-list(lassoMYCsignlinkcutdata=lassoMYCsignlinkcutdata)
zee<-"lassoMYCsignlinkcutdata"
cutoffs<-(ggg[[zee]])
cutoff<-(cutoffs[[19]])
cutoff<-data.frame(cutoff)
cutoff$CUT<-cutoff$support.at.cross
library(ggplot2)
library(reshape2)
library(plyr)
data<-rename(data,c("SIGN_MYC"="Measured","SIGNshuffle"="Shuffled","Overlap"="Overlap, Measured","overlap_shuffle"="Overlap, Shuffled"))
# library(fisheyeR)
# addNoise(matrix(rep(1,100), ncol = 2))

long <- melt(data, id.vars = c("bins"))
long$bins<-as.numeric(long$bins)
long$value<-as.numeric(long$value)
intercept1=cutoff$support.at.cross2[2]
ccc=max(long[c(10:1001,1010:2002),]$value)
qee<-paste("lassonameMYCsign",sep="")
aa<-fff[[qee]][[19]]
bb<-strsplit(aa,"_")
cc<-sapply(bb,"[[",5)
dd<-substr(cc,8,nchar(cc))
gg<-ggplot(data=long[c(10:1001,1010:2002),],aes(bins/1000,value/max(value),colour=variable))+geom_line(values = c("Measured"="solid", "Shuffled"="dashed"))+theme_bw() +
  geom_area(data=(long[2003:4004,]),aes(bins/1000,value,fill=(variable)),alpha=.1, position='identity')+ xlab("Support")+ylab("Overlap")+ theme(legend.position="none",panel.grid.major.y = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank())+
  scale_y_continuous(sec.axis = sec_axis(~.*ccc,name="Frequency"))+
  geom_line(aes(.98),colour='black',size=1)+#scale_linetype_manual(values = c("Measured"="solid", "Shuffled"="dashed"))+
  # geom_line(aes(cutoff$CUT[1]),colour='grey',size=1) + #guides(colour=FALSE)+
  scale_color_manual(breaks=c("Measured","Shuffled"),name="combined legend",values=c("Overlap, Measured"=NA, "Overlap, Shuffled"=NA,"Measured"="blue2", "Shuffled"="red2"))+
  scale_fill_manual(breaks=c("Overlap, Measured","Overlap, Shuffled"),name="combined legend",values=c("Overlap, Measured"="blue4", "Overlap, Shuffled"="red4","Sign"="blue2", "Shuffle"="red2"))+
  geom_ribbon(data=long[980:1000,],aes(ymin=0,ymax=value*58,x=bins/1000),colour="grey30",linetype=2,fill="blue2",alpha=".4") +
  geom_ribbon(data=long[1981:2000,],aes(ymin=0,ymax=value*58,x=bins/1000),colour="grey30",linetype=2,fill="red",alpha=".4")

sub <- gg + geom_rect(data=long[c(10:1001,1010:2002),],xmin=.8, ymin=0, xmax=1, ymax=1, fill="grey", alpha=0.5)
sub$layers <- rev(sub$layers) # draw rect below

gg+ annotation_custom(ggplotGrob(sub), xmin=.81, xmax=.9, ymin=.35, ymax=.75) +
  scale_x_continuous(limits=c(0.8, 1)) + scale_y_continuous(limits=c(0,1)) + labs(title="Bootstrap Support by Overlap and Frequency")+scale_y_continuous(sec.axis = sec_axis(~.*ccc,name="Frequency"))+theme(legend.position=c(.6,.55),legend.title=element_blank())
# ay <- list(
#   tickfont = list(color = "red"),
#   overlaying = "y",
#   side = "right",
#   title = "Frequency"
# )

#  plot_ly() %>%
#   add_lines(x = long$bins[c(10:1001)]/1000, y = (long$value[c(10:1001)]/max(long$value[c(10:1001)]))*ccc, name = "SIGNfrequency") %>%
#   add_lines(x = long$bins[c(1010:2002)]/1000, y = (long$value[c(1010:2002)]/max(long$value[c(10:1001)]))*ccc, name = "SHUFFLEfrequency") %>%
#   add_lines(x = long$bins[2003:3003]/1000, y = long$value[2003:3003]/max(long$value[2003:3003]), name = "SIGNoverlap", yaxis = "y2",fill = 'tozeroy') %>%
#   add_lines(x = long$bins[3004:4004]/1000, y = long$value[3004:4004]/max(long$value[3004:4004]), name = "shuffleoverlap", yaxis = "y2",fill = 'tozeroy') %>%
#   # add_trace(x = (cutoff$CUT[1])-.02, y = c(0,1),line = list(dash = "dash",color = "orange"),type='scatter',mode='lines',name="support at cutoff") %>%
# 
#  add_trace(x = as.numeric(dd)/100, y = c(0,1),line = list(dash = "dash",color = "orange"),type='scatter',mode='lines',name="support at cutoff") %>%
#   layout(
#     yaxis=list(title="Overlap"), yaxis2 = ay,
#     xaxis = list(title="Support")
#   )

J <- read_csv("~/Downloads/MYC_rss&spearman_inferred - leaveOut3_D&S(1).csv")
J$X81<-as.factor(J$X81)
geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=TRUE)
p<-ggplot(J[1:293,],aes(x=(X81),y=log10(`Bolasso R2 ratio`)))+ geom_boxplot() + theme_classic()+geom_hline(yintercept=0,colour="grey")+ xlab("final links")+ylab("R2 ratio")+ labs(title="Bolasso R2 ratio Shuffled Vs Measured")
q<-ggplot(J[295:683,],aes(x=(X81),y=log10(`Bolsco R2 ratio`)))+ geom_boxplot() + theme_classic()+geom_hline(yintercept=0,colour="grey")+ xlab("final links")+ylab("R2 ratio")+ labs(title="Bolsco R2 ratio Shuffled Vs Measured")
