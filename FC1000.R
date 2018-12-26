
load("/home/radonn/R/x86_64-pc-linux-gnu-library/3.4/FC1000/data/NPC_2_shRNA.rda")

setwd('~/shRNA/11_HEPG2/')
filenames <- list.files(pattern=paste('RUV_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HEPG2A<-data
HEPG2P<-diag(dim(data)[1])
rownames(HEPG2P)<-rownames(HEPG2A)
colnames(HEPG2P)<-colnames(HEPG2A)

setwd('~/shRNA/12_A549/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
A549A<-data
A549P<-diag(dim(data)[1])
rownames(A549P)<-rownames(A549A)
colnames(A549P)<-colnames(A549A)

setwd('~/shRNA/12_HA1E/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HA1EA<-data
HA1EP<-diag(dim(data)[1])
rownames(HA1EP)<-rownames(HA1EA)
colnames(HA1EP)<-colnames(HA1EA)

setwd('~/shRNA/13_PC3/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
PC3A<-data
PC3P<-diag(dim(data)[1])
rownames(PC3P)<-rownames(PC3A)
colnames(PC3P)<-colnames(PC3A)

setwd('~/shRNA/14_A375/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
A375A<-data
A375P<-diag(dim(data)[1])
rownames(A375P)<-rownames(A375A)
colnames(A375P)<-colnames(A375A)

setwd('~/shRNA/15_HT29/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HT29A<-data
HT29P<-diag(dim(data)[1])
rownames(HT29P)<-rownames(HT29A)
colnames(HT29P)<-colnames(HT29A)

setwd('~/shRNA/16_VCAP/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
VCAPA<-data
VCAPP<-diag(dim(data)[1])
rownames(VCAPP)<-rownames(VCAPA)
colnames(VCAPP)<-colnames(VCAPA)

setwd('~/shRNA/1_HEK293T/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HEK293TA<-data
HEK293TP<-diag(dim(data)[1])
rownames(HEK293TP)<-rownames(HEK293TA)
colnames(HEK293TP)<-colnames(HEK293TA)

setwd('~/shRNA/2_SHSY5Y/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
SHSY5TA<-data
SHSY5TP<-diag(dim(data)[1])
rownames(SHSY5TP)<-rownames(SHSY5TA)
colnames(SHSY5TP)<-colnames(SHSY5TA)

setwd('~/shRNA/3_SW480/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
SW480A<-data
SW480P<-diag(dim(data)[1])
rownames(SW480P)<-rownames(SW480A)
colnames(SW480P)<-colnames(SW480A)

setwd('~/shRNA/4_HEKTE/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HEKTEA<-data
HEKTEP<-diag(dim(data)[1])
rownames(HEKTEP)<-rownames(HEKTEA)
colnames(HEKTEP)<-colnames(HEKTEA)

setwd('~/shRNA/5_SKL/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
SKLA<-data
SKLP<-diag(dim(data)[1])
rownames(SKLP)<-rownames(SKLA)
colnames(SKLP)<-colnames(SKLA)

setwd('~/shRNA/6_ASC/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
ASCA<-data
ASCP<-diag(dim(data)[1])
rownames(ASCP)<-rownames(ASCA)
colnames(ASCP)<-colnames(ASCA)

setwd('~/shRNA/7_NPC/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
NPCA<-data
NPCP<-diag(dim(data)[1])
rownames(NPCP)<-rownames(NPCA)
colnames(NPCP)<-colnames(NPCA)

setwd('~/shRNA/8_MCF7/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
MCF7A<-data
MCF7P<-diag(dim(data)[1])
rownames(MCF7P)<-rownames(MCF7A)
colnames(MCF7P)<-colnames(MCF7A)

setwd('~/shRNA/9_HCC515/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HCC515A<-data
HCC515P<-diag(dim(data)[1])
rownames(HCC515P)<-rownames(HCC515A)
colnames(HCC515P)<-colnames(HCC515A)

FC978A<-cbind(MCF7A,HCC515A,NPCA,ASCA,SKLA,HEKTEA,SW480A,SHSY5TA,HEK293TA,VCAPA,HT29A,A375A,PC3A,HA1EA,A549A,HEPG2A)
c<-which(rownames(FC978A) %in% colnames(FC978A))
d<-which(colnames(FC978A) %in% rownames(FC978A))
FC978A<-FC978A[c,d]
FC978A<-FC978A[sort(rownames(FC978A)),]
FC978A<-FC978A[,sort(colnames(FC978A))]

# library(plyr)
# FC978P<-cbind(MCF7P,HCC515P,NPCP,ASCP,SKLP,HEKTEP,SW480P,SHSY5TP,HEK293TP,VCAPP,HT29P,A375P,PC3P,HA1EP,A549P,HEPG2P,make.row.names = TRUE)
library(reshape)
pp<-data.frame(colnames(FC978A))
pp<-transform(pp,FOO=colsplit(colnames.FC978A.,"[.]",names=c('a','b')))
pp$colnames.FC978A.<-NULL
pp$FOO.b<-NULL
# colnames(FC978A)<-pp[2]
library(plyr)
p<-ddply(pp,.(FOO.a),nrow)
P_new <- matrix(0,dim(FC978A)[1],dim(FC978A)[2])
colnames(P_new)<-pp[2]
j <- 1
p_cum <- as.matrix(cumsum(p[,2]))
for (i in 1:dim(p_cum)[1]){
  P_new[i,j:p_cum[i,1]] <- 1
  j <- p_cum[i,1]+1
}

colnames(P_new)<-colnames(FC978A)
rownames(P_new)<-rownames(FC978A)
# write.csv(FC978A,"FC_ALL_A.csv",dec = ".")
# write.csv(P_new,"FC_ALL_P.csv",dec = ".")
