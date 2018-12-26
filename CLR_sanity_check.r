library(readr)
N45_sanity_check_CLR_D_NESTBOOT <- read_delim("~/Dropbox/SciLifeLab/git/python/N45_sanity_check_CLR_D_NESTBOOT.tsv",delim = '\t')
N45_sanity_check_CLR_D_NATIVE <- read_delim("~/Dropbox/SciLifeLab/git/python/N45_sanity_check_CLR_D_NATIVE.tsv",delim = '\t')
N45NB<-N45_sanity_check_CLR_D_NATIVE
Y = split(N45NB, rep(1:ceiling(nrow(N45NB)/30), each=30, length.out=nrow(N45NB)))
N45NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
N45NB$`median MCC`<-N45NB$`median(na.omit(y$MCC))`

names(N45NB)[names(N45NB) == 'median(abs(y$MCC))'] <- 'Median MCC'

N45NB$SNR_calc<-NULL
N45NB$MCC<-NULL
N45NB$auroc<-NULL
N45_sanity_check_CLR_D_NESTBOOT$time<-NULL
j<-rbind(N45NB,N45_sanity_check_CLR_D_NESTBOOT)
j$meth<-'CLR'
write.csv(j,"~/Dropbox/SciLifeLab/git/python/N45_sanity_check_CLR.tsv")


N10_sanity_check_CLR_D_NESTBOOT <- read_delim("~/Dropbox/SciLifeLab/git/python/N30_sanity_check_BoCLR_NESTBOOT.tsv",delim = '\t')
N10_sanity_check_CLR_D_NATIVE <- read_delim("~/Dropbox/SciLifeLab/git/python/N10_sanity_check_CLR_D_NATIVE.tsv",delim = '\t')
N10NB<-N10_sanity_check_CLR_D_NATIVE
Y = split(N10NB, rep(1:ceiling(nrow(N10NB)/30), each=30, length.out=nrow(N10NB)))
N10NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
N10NB$`median MCC`<-N10NB$`median(na.omit(y$MCC))`

names(N10NB)[names(N10NB) == 'median(abs(y$MCC))'] <- 'Median MCC'

# N10NB$SNR_calc<-NULL
# N10NB$MCC<-NULL
# N10NB$auroc<-NULL
N10NB$method<-'native CLR'
N10NB$bootstrap<-'NestBoot'
N10_sanity_check_CLR_D_NESTBOOT$`Median MCC`<-N10_sanity_check_CLR_D_NESTBOOT$MCC
N10_sanity_check_CLR_D_NESTBOOT$method<-'NestBoot CLR'
N10_sanity_check_CLR_D_NESTBOOT$time<-NULL
jj<-rbind(N10NB,N10_sanity_check_CLR_D_NESTBOOT)
jj$meth<-'CLR'
write.csv(jj,"~/Dropbox/SciLifeLab/git/python/N10_sanity_check_CLR.tsv")

##FDR v FPR

BoCLR <- read_delim("/afs/pdc.kth.se/home/d/dmorgan/BoCLR_bootstrap_10_5FDR_sanity_check_results_19-Jul-2018.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)
Y = split(BoCLR, rep(1:ceiling(nrow(BoCLR)/50), each=50, length.out=nrow(BoCLR)))
N10NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
N10NB$`median MCC`<-N10NB$`median(na.omit(y$MCC))`

BoGenie3 <- read_delim("Desktop/BoGenie3_bootstrap_10_5FDR_sanity_check_results_30-Jul-2018.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)
Y = split(BoGenie3, rep(1:ceiling(nrow(BoGenie3)/50), each=50, length.out=nrow(BoGenie3)))
N10NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
N10NB$`median MCC`<-N10NB$`median(na.omit(y$MCC))`




rest45 <- read_delim("~/Dropbox/SciLifeLab/git/python/N45_sanity_check_CLR.csv",delim=",")
rest45$time<-NULL
CLR45 <- read_delim("~/Dropbox/SciLifeLab/git/python/N45overall.csv",delim=",")
rest45$bootstrap<-'bootstrap'
rest45$boot<-'NestBoot'
rest45$X1<-NULL
# rest45$method<-'CLR'
rest45$meth<-rest45$method
CLR45$`max(na.omit(y$MCC))`<-NULL
CLR45$`median(na.omit(y$MCC))`<-NULL
CLR45$auroc<-NULL
CLR45$X1<-NULL
rest45$`max MCC`<-rest45$`Median MCC`
CLR45$SNR_calc<-NULL
rest45$MCC<-rest45$`Median MCC`
gg<-rbind(CLR45,rest45)
write.csv(gg,"~/Dropbox/SciLifeLab/git/python/N45_NB_overall.csv")



CLR10 <- read_delim("~/Dropbox/SciLifeLab/git/python/N10_sanity_check_CLR.tsv",delim = ',')
CLR10$time<-NULL
CLR10$HL<-NULL
CLR10$X1<-NULL
# CLR10$bootstrap
# CLR10$bootstrap<-'bootstrap'
# CLR10$boot<-'NestBoot'
# CLR10$method<-'NestBoot CLR'
CLR10$meth<-NULL
CLR10$auroc<-NULL
# CLR10$`max MCC`<-CLR10$`Median MCC`
CLR10$MCC<-NULL
# CLR10$`max MCC`<-NULL
# CLR10$MCC<-NULL
rest10 <- read_delim("~/Dropbox/SciLifeLab/git/python/N10_bootstrap.csv",delim=",")
rest10$time<-NULL
rest10$lambda<-NULL
rest10$X<-NULL
rest10$dataset<-NULL
rest10$network<-NULL
rest10$HL<-NULL
rest10$`max MCC`<-NULL
rest10$cond<-NULL
rest10$`max(na.omit(y$MCC))`<-NULL
rest10$`median(na.omit(y$MCC))`<-NULL
rest10$auroc<-NULL
rest10$X1<-NULL
# rest10$SNR_calc<-NULL
gg<-rbind(CLR10,rest10)
write.csv(gg,"~/Dropbox/SciLifeLab/git/python/N10_NB_overall.csv")





G10 <- read_delim('~/Dropbox/SciLifeLab/git/python/N10_NB_overall.csv',delim = ',')
G10<-G10[G10$method=='Genie3',]
G10$X1<-NULL
G10$bootstrap= 'native'
G10NB <- read_delim('~/Dropbox/SciLifeLab/git/python/N10_sanity_check_BoGenie3_NB.tsv',delim = '\t')
Y = split(G10NB, rep(1:ceiling(nrow(G10NB)/30), each=30, length.out=nrow(G10NB)))
G10NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
G10NB$`Median MCC`<-G10NB$`median(na.omit(y$MCC))`
names(G10NB)[names(G10NB) == 'median(abs(y$MCC))'] <- 'Median MCC'
G10NB$bootstrap<-'NestBoot'
G10NB$MCC<-NULL
G10NB$auroc<-NULL
gg<-rbind(G10,G10NB)
write.csv(gg,"~/Dropbox/SciLifeLab/git/python/N10_Genie3.csv")



G45 <- read_delim('~/Dropbox/SciLifeLab/git/python/N45_NB_overall.csv',delim = ',')
G45<-G45[G45$method=='native Genie3',]
G45$X1<-NULL
G45$`max MCC`<-NULL
G45$meth<-'Genie3'
G45$boot<-NULL
G45$MCC<-NULL
G45$bootstrap= 'native'
G45NB <- read_delim('~/Dropbox/SciLifeLab/git/python/N45_sanity_check_BoGenie3.tsv',delim = '\t')
Y = split(G45NB, rep(1:ceiling(nrow(G45NB)/30), each=30, length.out=nrow(G45NB)))
G45NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$`MCC`)))))
G45NB$`Median MCC`<-G45NB$`median(na.omit(y$MCC))`
names(G45NB)[names(G45NB) == 'median(abs(y$MCC))'] <- 'Median MCC'
G45NB$bootstrap<-'NestBoot'
G45NB$meth<-'Genie3'
G45NB$MCC<-NULL
G45NB$SNR_calc<-NULL
G45NB$auroc<-NULL
gg<-rbind(G45,G45NB)
write.csv(gg,"~/Dropbox/SciLifeLab/git/python/N45_Genie3.csv")


data1 = read_delim('~/Dropbox/SciLifeLab/git/python/N190118_triplot.csv',delim = ',')
data1$time<-NULL
data1$HL<-NULL
data1$nest_meth<-NULL
data1$IAAHL<-NULL
data1$condHL<-NULL
data1$cond<-NULL
data1$X1<-NULL
data1$lambda<-NULL
data1$MCC<-NULL
data1$dataset<-NULL

data1$network<-NULL
data2 = read_delim('~/Dropbox/SciLifeLab/git/python/N10_sanity_check_CLR.tsv',delim = ',')
data2$X1<-NULL
data2$bootstrap[data2$method=='native CLR']<-'native'
data2$bootstrap[data2$method=='NestBoot CLR']<-'NestBoot'
data2$method<-data2$meth
data2$meth<-NULL
data2$auroc<-NULL
data2$MCC<-NULL
data3 = read_delim('~/Dropbox/SciLifeLab/git/python/N10_Genie3.csv',delim = ',')
data3$meth<-NULL
data3$method<-'Genie3'
data3$X1<-NULL

data<-rbind(data1,data2,data3)
write.csv(data,"~/Dropbox/SciLifeLab/git/python/N10_ALL5.csv")


NB45G3 = read_delim('~/Dropbox/SciLifeLab/git/python/N45NBGenie3.csv',delim = ',')
NB45G3$bootstrap<-'NestBoot'
NB45G3$SNR_calc<-NULL
NB45G3$auroc<-NULL
N45G3 = read_delim('~/Dropbox/SciLifeLab/git/python/N45_NB_overall.csv',delim = ',')
N45G3<-N45G3[N45G3$method=='native Genie3',]
N45G3$`max MCC`<-NULL
N45G3$boot<-NULL
N45G3$MCC<-NULL
data<-rbind(NB45G3,N45G3)
write.csv(data,"~/Dropbox/SciLifeLab/git/python/N45_Genie3.csv")
