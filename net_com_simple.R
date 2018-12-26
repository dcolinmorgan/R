# library(ALPACA)
library(stringr)
library(readr)
library(plyr)
library(ggplot2)
# parent.folder<-'/afs/pdc.kth.se/home/d/dmorgan/Volume1/NB_L1000/compare'
parent.folder<-'~/Desktop/compare/L1000_comparison/'
# 
# jaccard <- function(df, margin) {
#   if (margin == 1 | margin == 2) {
#     M_00 <- apply(df, margin, sum) == 0
#     M_11 <- apply(df, margin, sum) == 2
#     if (margin == 1) {
#       df <- df[!M_00, ]
#       JSim <- sum(M_11) / nrow(df)
#     } else {
#       df <- df[, !M_00]
#       JSim <- sum(M_11) / length(df)
#     }
#     JDist <- 1 - JSim
#     return(list(JSim = JSim, JDist = JDist))
#   } else break
# }
cells<- list.files(parent.folder, recursive=FALSE)
jj<-strsplit(cells,"_")
cellline<-sapply(jj,"[[",1)

sub.folders <- list.dirs(cellline, recursive=TRUE)
sub.folders<- sub.folders[ grepl("_NB", sub.folders) ]

JAKS<-matrix(0,length(cellline),length(cellline))
# JAKD<-matrix(0,length(cellline),length(cellline))
colnames(JAKS)<-cellline
rownames(JAKS)<-cellline
# rownames(JAKD)<-cellline
# colnames(JAKD)<-cellline

# i<-2
# k<-3
data <- list()
rr <- list()
count<-list()
dd<-list()
rr<-list()
cc<-list()
ccc<-1
for(i in 1:length(cells)){
myFiles<-list.files(sub.folders[i])
jj<-strsplit(myFiles,"_")
jjj<-sapply(jj,"[[",5)
j<-which.max(as.numeric(str_extract(jj, "\\d+\\.*\\d*")))
j<-cells[i]
  net1 <- read_delim(file.path(parent.folder,cells[i]),"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net1<-net1[c(1,2,6)]
  net1<-data.frame(net1)
  # rownames(net1)<-paste(net1$X1,net1$X2,sep='')
  l<-0
  for(k in 1:length(cells)){
    net2 <- read_delim(file.path(parent.folder,cells[k]),"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
    
    
    
    net2<-data.frame(net2[c(1,2,6)])
    # rownames(net2)<-paste(net2$X1,net2$X2,sep='')
    a<-intersect(net1,net2)
    data[[ccc]]<-intersect(net1,net2)
    rr[[ccc]]<-table(data[[ccc]][1])
    count[[ccc]]<-rr[[ccc]][rr[[ccc]]>30]
    b<-union(net1,net2)
    dd[[ccc]]<-setdiff(net1,net2)
    rr[[ccc]]<-table(dd[[ccc]][1])
    cc[[ccc]]<-rr[[ccc]][rr[[ccc]]>30]
    JSim<-dim(a)[1]/dim(b)[1]
    # l<-l+1
    ccc<-ccc+1
    # if(dim(net1)[1]>dim(net2)[1]){
    #   net_all<-merge(net1,net2,by="row.names",all.x=TRUE)}else{
    #     net_all<-merge(net2,net1,by="row.names",all.x=TRUE)}
    # net_INalpaca<-data.frame(net_all)
    
    # net_INalpaca$Row.names<-NULL
    # net_INalpaca$X1.y<-NULL
    # net_INalpaca$X2.y<-NULL
    # net_INalpaca[is.na(net_INalpaca)] <- 0
    # colnames(net_INalpaca)<-c('C1','C2','C3','C4')
    # net_INalpaca$C5<-net_INalpaca$C1
    # net_INalpaca$C1<-net_INalpaca$C2
    # net_INalpaca$C2<-net_INalpaca$C5
    # net_INalpaca$C5<-NULL
    # net_INalpaca$C3<-as.double(net_INalpaca$C3)
    # net_INalpaca$C4<-as.double(net_INalpaca$C4)
    # net_INalpaca$C1<-paste('A_',net_INalpaca$C1,sep='')
    # net_INalpaca$C2<-paste('B_',net_INalpaca$C2,sep='')
    # net_INalpaca$C1<-as.factor(net_INalpaca$C1)
    # net_INalpaca$C2<-as.factor(net_INalpaca$C2)
    # 
    # ret<-jaccard(net_INalpaca[3:4],1)
    # list2env(ret,env=environment())
    JAKS[i,k]<-JSim
    # JAKD[i,k]<-JDist
  
  }
}
    # simp.alp <- alpaca(net_INalpaca,NULL,verbose=F)
    
# rr[[30]]<-NULL
# rr[[5]]<-NULL
full <- ldply(rr, data.frame)
full$X..i..<-NULL
full$Gene<-full$Var1
g<-ggplot(full,aes(x=Gene,y=Freq))+ geom_violin(trim=TRUE)
g + geom_boxplot(width=0.1)+ stat_summary(fun.y=median, geom="point", size=2, color="red")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"),axis.text.x=element_blank(),axis.ticks.x=element_blank())

# cc[[30]]<-NULL
# cc[[5]]<-NULL
df <- ldply(cc, data.frame)
df$X..i..<-NULL
df$Gene<-df$Var1
df$Var1<-NULL
plot(df)
none <- theme_blank()
p<-ggplot(df,aes(x=Gene,y=Freq))+ geom_violin(trim=TRUE)#+ opts(panel.grid.major = none, panel.grid.minor = none)
p + geom_boxplot(width=0.1)+ stat_summary(fun.y=median, geom="point", size=2, color="red")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))

# write.table(JAKS,'Dropbox/Sonnhammer_group/plots/L1000/allVallJAKS.csv',sep="\t",dec=".")
# write.table(JAKD,'Dropbox/Sonnhammer_group/plots/L1000/allVallJAKD.csv',sep="\t",dec=".")

library('phangorn')
# library(WGCNA)
library(readr)
# j<- read_delim("~/Dropbox/Sonnhammer_group/plots/L1000/orig_allVallJAKD (another copy).csv","\t", escape_double = FALSE, trim_ws = TRUE)
# rownames(j)<-j$X1
# j$X1<-NULL
# a<-NJ(as.matrix(j[1:10,1:10]))
c<-upgma(as.matrix(1-JAKS))
plot(c)
edgelabels(round(c$edge.length, digits=2),frame="none", adj=c(.5, -.75))

setwd("~/Desktop/compare")
# lassoMYCsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# temp <- lapply(parent.folder, read.delim, header=TRUE,sep='\t')

temp <- lapply(files, fread, sep="\t")
for (i in 1:length(temp)){
# <-temp[[i]][,1]
rr[[i]]<-table(temp[[i]][,1])
count[[i]]<-rr[[i]][rr[[i]]>100]
count[[i]]
}

