library(FC1000)
library(heatmaply)
require(stringr)
library(ggplot2)
library(plyr)
library(ggfortify)
####ACTUAL running of FC1000####
# setwd('/cfs/klemming/scratch/d/dmorgan/FC1000_data_prep')
# args <- commandArgs(trailingOnly = TRUE)
# norm_FC1000(run = args, folder ='shRNA', doRaw = TRUE, doCombat = TRUE, doCombatC = TRUE, doPlateMedian = TRUE,methods ='ReplicateRUV',NCGs ='All978')
# for (i in 1:182){
#   try(evalNormEndpoints_FC1000(run = i, folder = "shRNA",limitRunsByCut=TRUE,cutOK=0.2,cutSimilar=0.03))
# }
# myRmd = system.file("rmd/Rmarkdown_template_02.Rmd", package="FC1000")
# 
# for (i in 1:182){
#   try(evalNormPlots_FC1000(run = i, folder = "shRNA", rmdscript = myRmd))
# }
####this will reassemble the best performing subsets####
####based on final endpoint since replicateRUV steadies out by ks=15####
load("~/R/x86_64-pc-linux-gnu-library/3.4/FC1000/data/NPC_2_shRNA.rda")
parent.folder <- '/scratch/dmorgan/L1000data/shRNA'
cells<- list.dirs(parent.folder, recursive=FALSE)

for(iii in 1:(length(cells)-1)){ ## for cell line specific datasets
  # i<-14
  parent.folder <- cells[iii]
  sub.folders <- list.dirs(parent.folder, recursive=TRUE)
  sub.folders<- sub.folders[ grepl("Subset_", sub.folders) ]
  
  bb<-strsplit(cells[iii],"/")
  line<-sapply(bb,"[[",5)
  # line<-"ALL"
  for(i in 3:length(sub.folders)){
    # i<-4
    subset<-sub.folders[i]#14 for HT29, else 3
    myFiles<-list.files(pattern="^RUV_",subset)
    # design<-list.files(pattern="design_",subset)
    # j<-split(myFiles,"_")
    # compare(j,myFiles)
    l=myFiles[order(as.numeric(do.call(c,lapply(myFiles,function(item) strsplit(item,'_')[[1]][2]))))][-1]
    m=l[4]#[length(l)]
    
    datum<-readRDS(file.path(subset,m))
    load(file.path(subset,list.files(pattern="design_",subset)))
    colname<-which(design[1,]!=0)
    for(w in 1:dim(design)[1]){
      colname[w]<-which(design[w,]!=0)
    }
    rownames(datum)<-colnames(design)[colname]
    datum<-datum[rownames(datum)!="CONTROL",] #remove controls
    
    j<-strsplit(plateT,"_")
    plate<-sapply(j,"[[",4)
    rownames(datum)<-paste(rownames(datum),plate,sep="_")
    
    colnames(datum)<-NPC_2_shRNA$Rgenes
    if(length(sub.folders)>2){
      for(z in 3:length(sub.folders)){ #after information and first subset above
        # ldf <- lapply(filenames, readRDS)
        # data<-data.frame(ldf,check.names = FALSE)
        data<-readRDS(file.path(sub.folders[z],m))
        load(file.path(sub.folders[z],list.files(pattern="design_",sub.folders[z])))
        colname<-which(design[1,]!=0)
        for(j in 1:dim(design)[1]){
          colname[j]<-which(design[j,]!=0)
        }
        rownames(data)<-colnames(design)[colname]
        data<-data[rownames(data)!="CONTROL",] #remove controls
        
        j<-strsplit(plateT,"_")
        plate<-sapply(j,"[[",4)
        rownames(data)<-paste(rownames(data),plate,sep="_")
        datum<-rbind(data,datum)
      }}
    
    jj<-strsplit(plateT,"_")
    jjj<-sapply(jj,"[[",3)
    bbb<-unique(sapply(jj,"[[",2))
    if(grepl("VCAP|JURKAT",bbb)){
      datum<-datum[jjj=="120H",] #select for 1 timepoint
    }else{
      datum<-datum[jjj=="96H",]} #select for 1 timepoint
    
    cc<-strsplit(rownames(datum),"_")
    cc<-sapply(cc,"[[",1)
    c<-which(cc %in% colnames(datum))
    d<-which(colnames(datum) %in% cc)
    
    datum<-datum[c,d]
    datum<-datum[sort(rownames(datum)),]
    datum<-datum[,sort(colnames(datum))]
    datum<-unique(datum)
    dd<-strsplit(rownames(datum),"_")
    dd<-sapply(dd,"[[",1)
    x<-matrix(0,dim(datum)[1],dim(datum)[2])
    colnames(x)<-colnames(datum)
    rownames(x)<-dd
    for(ii in 1:dim(datum)[1]){
      for(j in 1:dim(datum)[2]){
        x[ii,j] <- ifelse (dd[ii]==colnames(datum)[j], 1,0)
      }}
    
    # write.csv((datum),file.path(parent.folder,paste("RUV40",bbb,"Y.csv",sep='_')))
    # write.csv((x),file.path(parent.folder,paste("RUV40",bbb,"P.csv",sep='_')))
    # 
    # bbb<-"PC3"
    # datum <- read.table("~/shRNA/RUV40_PC3_Y.csv",row.names=1,sep=",",header=TRUE)
    # parent.folder <- cells[1]
    # plate<-strsplit(rownames(datum),"_")
    # plate<-sapply(plate, "[[", 2)
    # data<-data.frame(datum)
    # m<-prcomp((data),scale=TRUE)
    # # data<-data.frame((data[,2:length(datum)]))
    # # 
    # data$plate<-plate
    # jpeg(file.path(parent.folder,paste("RUV40",bbb,"PCA.jpg",sep='_')))
    # autoplot(m, data = data,size=0.3,colour='plate',main=paste("PCA for ",bbb))
    # dev.off()
    # 
    bbb<-"MCF7"
    datum <- read.table(paste("~/shRNA/9_MCF7/FC2000_9",bbb,"Y.csv",sep="_"),row.names=NULL,sep=",",header=TRUE)
    datum$X<-NULL
    jpeg(file.path("~/shRNA",paste("fc2000",bbb,"heatmap.jpg",sep='_')))
    heatmap3(datum,Colv=NA,Rowv=NA)
    dev.off()
    
    #cat together
    if(i==3){
      YY<-datum
      PP<-x
    }else{
      YY<-rbind(datum,YY)
      PP<-rbind(x,PP)
    }
  }
  # rm(list=setdiff(ls(), "x"))
  # load("~/R/x86_64-pc-linux-gnu-library/3.4/FC1000/data/NPC_2_shRNA.rda")
  # parent.folder <- '/scratch/dmorgan/L1000data/shRNA'
  # cells<- list.dirs(parent.folder, recursive=FALSE)
  
}

# }
if(iii==11){
  write.csv((YY),file.path(parent.folder,"RUV40_ALL_Y.csv"))
  write.csv((PP),file.path(parent.folder,"RUV40_ALL_P.csv"))
}
# g <- ggbiplot( prcomp(datum),obs.scale = 1, var.scale = 1, groups = rownames(datum), ellipse = TRUE, circle = TRUE)
