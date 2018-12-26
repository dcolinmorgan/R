
load("~/R/x86_64-pc-linux-gnu-library/3.4/FC1000/data/NPC_2_shRNA.rda")

setwd('~/drug/1_THP1/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
THP1A<-data
THP1P<-diag(dim(data)[1])
rownames(THP1P)<-rownames(THP1A)
colnames(THP1P)<-colnames(THP1A)

setwd('~/drug/2_NOMO1/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
NOMO1A<-data
NOMO1P<-diag(dim(data)[1])
rownames(NOMO1P)<-rownames(NOMO1A)
colnames(NOMO1P)<-colnames(NOMO1A)

setwd('~/drug/3_HUH7/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HUH7A<-data
HUH7P<-diag(dim(data)[1])
rownames(HUH7P)<-rownames(HUH7A)
colnames(HUH7P)<-colnames(HUH7A)

setwd('~/drug/4_HEPG2/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
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

setwd('~/drug/5_FIBRNPC/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
FIBRNPCA<-data
FIBRNPCP<-diag(dim(data)[1])
rownames(FIBRNPCP)<-rownames(FIBRNPCA)
colnames(FIBRNPCP)<-colnames(FIBRNPCA)

setwd('~/drug/6_MCF10A/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
MCF10AA<-data
MCF10AP<-diag(dim(data)[1])
rownames(MCF10AP)<-rownames(MCF10AA)
colnames(MCF10AP)<-colnames(MCF10AA)

setwd('~/drug/7_HS578T/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
HS578TA<-data
HS578TP<-diag(dim(data)[1])
rownames(HS578TP)<-rownames(HS578TA)
colnames(HS578TP)<-colnames(HS578TA)

setwd('~/drug/8_BT20/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
BT20A<-data
BT20P<-diag(dim(data)[1])
rownames(BT20P)<-rownames(BT20A)
colnames(BT20P)<-colnames(BT20A)

setwd('~/drug/9_MDAMB231/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
MDAMB231A<-data
MDAMB231P<-diag(dim(data)[1])
rownames(MDAMB231P)<-rownames(MDAMB231A)
colnames(MDAMB231P)<-colnames(MDAMB231A)

setwd('~/drug/10_SKBR3/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
SKBR3A<-data
SKBR3P<-diag(dim(data)[1])
rownames(SKBR3P)<-rownames(SKBR3A)
colnames(SKBR3P)<-colnames(SKBR3A)

setwd('~/drug/11_NKDBA/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
NKDBAA<-data
NKDBAP<-diag(dim(data)[1])
rownames(NKDBAP)<-rownames(NKDBAA)
colnames(NKDBAP)<-colnames(NKDBAA)

setwd('~/drug/12_NEU/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
NEUA<-data
NEUP<-diag(dim(data)[1])
rownames(NEUP)<-rownames(NEUA)
colnames(NEUP)<-colnames(NEUA)

setwd('~/drug/13_PHH/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
PHHA<-data
PHHP<-diag(dim(data)[1])
rownames(PHHP)<-rownames(PHHA)
colnames(PHHP)<-colnames(PHHA)

setwd('~/drug/14_HCC515/')
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

setwd('~/drug/15_SKB/')
filenames <- list.files(pattern=paste('A_'), full.names=TRUE,recursive = T,ignore.case = FALSE)
ldf <- lapply(filenames, readRDS)
data<-data.frame(ldf,check.names = FALSE)
data<-data[,sort(colnames(data))]
rownames(data)<-make.names(NPC_2_shRNA$Rgenes,unique=TRUE)
data<-data[sort(rownames(data)),]
# c<-which(rownames(data) %in% colnames(data))
# d<-which(colnames(data) %in% rownames(data))
# data<-data[,d]
SKBA<-data
SKBP<-diag(dim(data)[1])
rownames(SKBP)<-rownames(SKBA)
colnames(SKBP)<-colnames(SKBA)

setwd('~/drug/16_ASC/')
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

setwd('~/drug/17_HA1E/')
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

setwd('~/drug/18_NPC/')
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

setwd('~/drug/19_HT29/')
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

setwd('~/drug/20_A375/')
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

setwd('~/drug/21_A549/')
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

setwd('~/drug/22_PC3/')
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

setwd('~/drug/23_MCF7/')
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

setwd('~/drug/24_VCAP/')
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


FC978D<-cbind(THP1A,NOMO1A,HUH7A,HEPG2A,FIBRNPCA,MCF10AA,HS578TA,BT20A,MDAMB231A,SKBR3A,NKDBAA,NEUA,PHHA,HCC515A,SKBA,ASCA,HA1EA,NPCA,HT29A,A375A,A549A,PC3A,MCF7A,VCAPA)
# c<-which(rownames(FC978D) %in% colnames(FC978D))
# d<-which(colnames(FC978D) %in% rownames(FC978D))
# FC978D<-FC978D[c,d]
FC978D<-FC978D[sort(rownames(FC978D)),]
FC978D<-FC978D[,sort(colnames(FC978D))]

# library(plyr)
# FC978P<-cbind(SKBP,HCC515P,NPCP,PHHP,NEUP,NKDBAP,SKBR3P,MDAMB231P,BT20P,VCAPP,HT29P,A375P,PC3P,HA1EP,A549P,HEPG2P,make.row.names = TRUE)
# library(reshape)
# pp<-data.frame(colnames(FC978D))
# pp<-transform(pp,FOO=colsplit(colnames.FC978D.,"[.]",names=c('a','b')))
# pp$colnames.FC978D.<-NULL
# pp$FOO.b<-NULL
# # colnames(FC978D)<-pp[2]
# library(plyr)
# p<-ddply(pp,.(FOO.a),nrow)
# P_new <- matrix(0,dim(FC978D)[1],dim(FC978D)[2])
# colnames(P_new)<-pp[2]
# j <- 1
# p_cum <- as.matrix(cumsum(p[,2]))
# for (i in 1:dim(p_cum)[1]){
#   P_new[i,j:p_cum[i,1]] <- 1
#   j <- p_cum[i,1]+1
# }

# colnames(P_new)<-colnames(FC978D)
# rownames(P_new)<-rownames(FC978D)
write.csv(FC978D,"FC_ALL_A.csv",dec = ".")
# write.csv(P_new,"FC_ALL_P.csv",dec = ".")
