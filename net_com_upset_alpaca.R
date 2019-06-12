# library(ALPACA)
library(stringr)
library(sjmisc)
library(readr)
library(plyr)
library(ggplot2)
# parent.folder<-'/afs/pdc.kth.se/home/d/dmorgan/Volume1/NB_L1000/compare'
# parent.folder<-'~/all_L1000+NB/A375'
# parent.folder<-'~/Desktop/cells/'
parent.folder<-'~/Dropbox/Sonnhammer_group/plots/L1000/intersection/net'
# parent.folder<-'scratch/dmorgan/L1000data/all_L1000+NB/A375/'

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
cellline<-paste(sapply(jj,"[[",1))#,sapply(jj,"[[",2),sapply(jj,"[[",3),sep="_")

# sub.folders <- list.dirs(cellline, recursive=TRUE)
# sub.folders<- sub.folders[ grepl("_NB", sub.folders) ]

JAKS<-matrix(0,length(cellline),length(cellline))
# JAKD<-matrix(0,length(cellline),length(cellline))
colnames(JAKS)<-cellline
rownames(JAKS)<-cellline
# rownames(JAKD)<-cellline
# colnames(JAKD)<-cellline

# i<-2
# k<-3
# data <- list()
# rr <- list()
# count<-list()
# dd<-list()
# rr<-list()
# cc<-list()
# ccc<-1
# for(i in 1:length(cells)){
myFiles<-cells#list.files(sub.folders[i])
# jj<-strsplit(myFiles,"_")
# jjj<-sapply(jj,"[[",1)
# j<-which.max(as.numeric(str_extract(jj, "\\d+\\.*\\d*")))
cells<-myFiles
j<-cells[i]
  net1 <- read_delim(file.path(parent.folder,cells[1]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net1<-net1[c(1,2)]
  net1<-data.frame(net1)
  rownames(net1)<-paste(net1$X1,net1$X2,sep='_')
  # l<-0
  # for(k in 1:length(cells)){
  # k<-3  
  net2 <- read_delim(file.path(parent.folder,cells[2]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net3 <- read_delim(file.path(parent.folder,cells[3]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net4 <- read_delim(file.path(parent.folder,cells[4]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net5 <- read_delim(file.path(parent.folder,cells[5]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net6 <- read_delim(file.path(parent.folder,cells[6]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net7 <- read_delim(file.path(parent.folder,cells[7]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net8 <- read_delim(file.path(parent.folder,cells[8]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net9 <- read_delim(file.path(parent.folder,cells[9]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  net10 <- read_delim(file.path(parent.folder,cells[10]),",", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  # net1<-net1[c(1,2)]
  # net1<-data.frame(net1)
  rownames(net2)<-paste(net2$X1,net2$X2,sep='_')
  rownames(net3)<-paste(net3$X1,net3$X2,sep='_')
  rownames(net4)<-paste(net4$X1,net4$X2,sep='_')
  rownames(net5)<-paste(net5$X1,net5$X2,sep='_')
  rownames(net6)<-paste(net6$X1,net6$X2,sep='_')
  rownames(net7)<-paste(net7$X1,net7$X2,sep='_')
  rownames(net8)<-paste(net8$X1,net8$X2,sep='_')
  rownames(net9)<-paste(net9$X1,net9$X2,sep='_')
  rownames(net10)<-paste(net10$X1,net10$X2,sep='_')
  
    
    # net2<-data.frame(net2[c(1,2)])
    # rownames(net2)<-paste(net2$X1,net2$X2,sep='_')
  net_all<-net1
  # for(i in 2:10){
    net_all<-merge(net1,net2,by="row.names",all=TRUE,suffixes = cellline)
    # }
    
    net_all<-merge(net_all,net10,by.x="Row.names",by.y="row.names",all=TRUE)
    colnames(net_all)[20]<-cellline[10]
    colnames(net_all)[21]<-cellline[10]
    # net_all[18]<-NULL
  
    write.table(net_all,'~/Dropbox/SciLifeLab/PROJECTS/L1000/logL1000_consensus.tsv',sep="\t",dec=".")
    
    
    # g<-  hbind(paste(rownames(net1)),paste(rownames(net2)),paste(rownames(net3)))
    
    
for(x in 1:dim(net_all)[1]){
  for (y in 2:dim(net_all)[2]){
    if(is_empty(net_all[x,y])){net_all[x,y]=0}else{net_all[x,y]=1}
}}
    
    
    # a<-intersect(net1,net2)
    # data[[ccc]]<-intersect(net1,net2)
    # rr[[ccc]]<-table(data[[ccc]][1])
    # count[[ccc]]<-rr[[ccc]][rr[[ccc]]>30]
    # b<-union(net1,net2)
    # dd[[ccc]]<-setdiff(net1,net2)
    # rr[[ccc]]<-table(dd[[ccc]][1])
    # cc[[ccc]]<-rr[[ccc]][rr[[ccc]]>30]
    # JSim<-dim(a)[1]/dim(b)[1]
    # l<-l+1
    # ccc<-ccc+1
    if (exists("net_all")==FALSE){
    if(dim(net1)[1]>dim(net2)[1]){
      net_all<-merge(net1,net2,by="row.names",all.x=TRUE)}else{
        net_all<-merge(net2,net1,by="row.names",all.x=TRUE)}}else{
          net_all<-merge(net_all,net2,by="row.names",all.x=TRUE)
        }
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
    # JAKS[i,k]<-JSim
    # JAKD[i,k]<-JDist
  
  }

  
  
  
  }
    # simp.alp <- alpaca(net_INalpaca,NULL,verbose=F)
    
# rr[[30]]<-NULL
# # rr[[5]]<-NULL
# full <- ldply(rr, data.frame)
# full$X..i..<-NULL
# full$Gene<-full$Var1
# g<-ggplot(full,aes(x=Gene,y=Freq))+ geom_violin(trim=TRUE)
# g + geom_boxplot(width=0.1)+ stat_summary(fun.y=median, geom="point", size=2, color="red")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"),axis.text.x=element_blank(),axis.ticks.x=element_blank())
# 
# # cc[[30]]<-NULL
# # cc[[5]]<-NULL
# df <- ldply(cc, data.frame)
# df$X..i..<-NULL
# df$Gene<-df$Var1
# df$Var1<-NULL
# plot(df)
# none <- theme_blank()
# p<-ggplot(df,aes(x=Gene,y=Freq))+ geom_violin(trim=TRUE)#+ opts(panel.grid.major = none, panel.grid.minor = none)
# p + geom_boxplot(width=0.1)+ stat_summary(fun.y=median, geom="point", size=2, color="red")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))

write.table(JAKS,'~/Dropbox/SciLifeLab/PROJECTS/L1000_consensus.tsv',sep="\t",dec=".")
# write.table(JAKD,'Dropbox/Sonnhammer_group/plots/L1000/allVallJAKD.csv',sep="\t",dec=".")

library('phangorn')
# library(WGCNA)
library(readr)
# j<- read_delim("~/Dropbox/Sonnhammer_group/plots/L1000/orig_allVallJAKD (another copy).csv","\t", escape_double = FALSE, trim_ws = TRUE)
# rownames(j)<-j$X1
# j$X1<-NULL
# a<-NJ(as.matrix(j[1:10,1:10]))
# a<-NJ(as.matrix(1-JAKS))

c<-upgma(as.matrix(1-JAKS))
plot(c)
edgelabels(round(c$edge.length, digits=2),frame="none", adj=c(.5, -.75))
plot(as.phylo(c), type = "radial",tip.color = "steelblue")
plot(as.phylo(c), type = "fan")
plot(as.phylo(c), type = "cladogram", cex = 0.6,
     edge.color = "steelblue", edge.width = 2, edge.lty = 2,
     tip.color = "steelblue")

edgelabels(round(c$edge.length, digits=2),frame="none", cex = 0.6,tip.color = "steelblue",adj=c(.5, .5))

# setwd("~/Desktop/compare")
# # lassoMYCsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# temp <- lapply(parent.folder, read.delim, header=TRUE,sep='\t')
# 
# temp <- lapply(files, fread, sep="\t")
# for (i in 1:length(temp)){
# # <-temp[[i]][,1]
# rr[[i]]<-table(temp[[i]][,1])
# count[[i]]<-rr[[i]][rr[[i]]>100]
# count[[i]]
# }



