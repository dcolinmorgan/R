library(ggplot2);library(readr)

N1<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/Bolsco_sanity_check_tt_NESTBOOT_test_02-Mar-2018.tsv",header=TRUE, sep="\t")
N1$bootstrap<-'NestBoot'
N1$method<-'LSCO'
N11<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/LSCO_sanity_check_tt_NATIVE_test_02-Mar-2018.tsv",header=TRUE, sep="\t")
N11$bootstrap<-'Without NestBoot'
N11$method<-'LSCO'
# N111<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Bolsco_bootstrap_25_5FDR_sanity_check_results_13-Dec-2017.tsv",header=TRUE, sep="\t")
# N111$bootstrap<-'NestBoot'
# N111$method<-'LSCO'
# N1111<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Bolsco_bootstrap_25_5FDR_firstHalf_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N1111$bootstrap<-'NestBoot'
# N1111$method<-'LSCO'
# N11111<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Bolsco_bootstrap_10_5FDR_sanity_check_results_13-Dec-2017.tsv",header=TRUE, sep="\t")
# N11111$bootstrap<-'NestBoot'
# N11111$method<-'LSCO'
# N111111<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Bolsco_bootstrap_10_5FDR_sanity_check_results_14-Dec-2017.tsv",header=TRUE, sep="\t")
# N111111$bootstrap<-'NestBoot'
# N111111$method<-'LSCO'

# N2<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Botlsco_bootstrap_25_5FDR_sanity_check_results_11-Dec-2017.tsv",header=TRUE, sep="\t")
# N2$bootstrap<-'NestBoot'
# N2$method<-'TLSCO'
# N22<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Botlsco_bootstrap_25_5FDR_sanity_check_results_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N22$bootstrap<-'NestBoot'
# N22$method<-'TLSCO'
# N222<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Botlsco_bootstrap_25_5FDR_sanity_check_results_13-Dec-2017.tsv",header=TRUE, sep="\t")
# N222$bootstrap<-'NestBoot'
# N222$method<-'TLSCO'
# N2222<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five_redux/Botlsco_bootstrap_25_5FDR_firstBit_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N2222$bootstrap<-'NestBoot'
# N2222$method<-'TLSCO'

N3<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/Bolasso_sanity_check_tt_NESTBOOT_test_02-Mar-2018.tsv",header=TRUE, sep="\t")
N3$bootstrap<-'NestBoot'
N3$method<-'Lasso'
N3333<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/Bolasso_sanity_check_tt_NESTBOOT_test_03-Mar-2018.tsv",header=TRUE, sep="\t")
N3333$bootstrap<-'NestBoot'
N3333$method<-'Lasso'
N33<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/LASSO_sanity_check_tt_NATIVE_test_02-Mar-2018.tsv",header=TRUE, sep="\t")
N33$bootstrap<-'Without NestBoot'
N33$method<-'Lasso'
N333<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/LASSO_sanity_check_tt_NATIVE_test_03-Mar-2018.tsv",header=TRUE, sep="\t")
N333$bootstrap<-'Without NestBoot'
N333$method<-'Lasso'
# N3333<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five/Bolasso_bootstrap_25_5FDR_sanity_check_results_10-Dec-2017.tsv",header=TRUE, sep="\t")
# N3333$bootstrap<-'NestBoot'
# N3333$method<-'Lasso'
# N33333<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five/Bolasso_bootstrap_25_5FDR_sanity_check_results_11-Dec-2017.tsv",header=TRUE, sep="\t")
# N33333$bootstrap<-'NestBoot'
# N33333$method<-'Lasso'

N4<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/BoRNI_sanity_check_tt_NESTBOOT_test_03-Mar-2018.tsv",header=TRUE, sep="\t")
N4$bootstrap<-'NestBoot'
N4$method<-'RNICO'
N44<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/BoRNI_sanity_check_tt_NESTBOOT_test_04-Mar-2018.tsv",header=TRUE, sep="\t")
N44$bootstrap<-'NestBoot'
N44$method<-'RNICO'
N444<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/BoRNI_sanity_check_tt_NESTBOOT_test_05-Mar-2018.tsv",header=TRUE, sep="\t")
N444$bootstrap<-'NestBoot'
N444$method<-'RNICO'
N4444<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/RNICO_sanity_check_tt_NATIVE_test_03-Mar-2018.tsv",header=TRUE, sep="\t")
N4444$bootstrap<-'Without NestBoot'
N4444$method<-'RNICO'
N44444<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/RNICO_sanity_check_tt_NATIVE_test_04-Mar-2018.tsv",header=TRUE, sep="\t")
N44444$bootstrap<-'Without NestBoot'
N44444$method<-'RNICO'
N444444<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/N45/RNICO_sanity_check_tt_NATIVE_test_05-Mar-2018.tsv",header=TRUE, sep="\t")
N444444$bootstrap<-'Without NestBoot'
N444444$method<-'RNICO'

# N5<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/Lasso_sanity_check_lsco_lasso_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N5$bootstrap<-'without NestBoot'
# N5$auroc<-NULL
# N55<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/RNICO_sanity_check_lsco_lasso_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N55$bootstrap<-'without NestBoot'
# N55$auroc<-NULL
# N555<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/RNICO_sanity_check_lsco_lasso_12-Dec-2017_two.tsv",header=TRUE, sep="\t")
# N555$bootstrap<-'without NestBoot'
# N555$auroc<-NULL
# N5555<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/sanity_check_TLSCO_RNICO_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N5555$bootstrap<-'without NestBoot'
# N5555$auroc<-NULL
# N55555<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/sanity_check_lsco_lasso_12-Dec-2017.tsv",header=TRUE, sep="\t")
# N55555$bootstrap<-'without NestBoot'
# N55555$auroc<-NULL
# N555555<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/sanity_check_TLSCO_RNICO_11-Dec-2017.tsv",header=TRUE, sep="\t")
# N555555$bootstrap<-'without NestBoot'
# N555555$auroc<-NULL
# N5555555<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/sanity_check_lsco_lasso_11-Dec-2017.tsv",header=TRUE, sep="\t")
# N5555555$bootstrap<-'without NestBoot'
# N5555555$auroc<-NULL


# NFIVE<-rbind(N5,N55,N555,N5555,N55555,N555555,N5555555)
# NFIVE$method<-gsub('tlsco','TLSCO',NFIVE$method)
# NFIVE$method<-gsub('lsco','LSCO',NFIVE$method)
# NFIVE$method<-gsub('lasso','Lasso',NFIVE$method)
# NFIVE$method<-gsub('RNI','RNICO',NFIVE$method)

NTWO<-rbind(N1,N11,N3,N33,N333,N3333,N4,N44,N444,N4444,N44444,N444444)

# NTWO$group<-rep(1:(dim(NTWO)[1]/30),each=30)
# C<-NTWO%>%group_by(group)%>%summarise(Mean=mean(NTWO$MCC), Max=max(NTWO$MCC), Min=min(NTWO$MCC), Median=median(NTWO$MCC), Std=sd(NTWO$MCC))

# N24<-rbind(N222)
# take max MCC per network sparsity set
Y = split(NTWO, rep(1:ceiling(nrow(NTWO)/30), each=30, length.out=nrow(NTWO)))
NTWO = do.call(rbind,lapply(Y,function(y) y[y$MCC == max(y$MCC),]))
# NTWO = do.call(rbind,lapply(Y,function(y) y[y$MCC == median(y$MCC),]))
NTWO=na.omit(NTWO)

# for (i in 1:length(NTWO$IAA)) ##take median as differentiator
  # if (NTWO$IAA[i] > 50){
  #   NTWO$class[i]<- "High"
  # }else {
  #   NTWO$class[i]<- "Low"}


# N26<-merge(N25,N24,all=TRUE)
NTWO$'IAA & Method'<- paste(NTWO$class,'IAA & ',NTWO$method)


write.csv(NTWO,'~/Dropbox/SciLifeLab/git/python/N45.csv')


library(dplyr)
N<-read.table("~/Dropbox/SciLifeLab/git/python/N190118_G3.csv",header=TRUE, sep=",")
M<-read.table("~/Dropbox/SciLifeLab/git/python/N10_sanity_check_tt_NATIVE_test_09-Mar-2018.tsv",header=TRUE, sep="\t")
NTWO<-bind_rows(N,M)

write.csv(NTWO,'~/Dropbox/SciLifeLab/git/python/N10G3_bootstrap.csv')
library(ggplot2);library(readr)
setwd('/afs/pdc.kth.se/home/d/dmorgan')
N7 <- read.table("N45_sanity_check_tt_NATIVE_test_15-Mar-2018.tsv",sep="\t",header=TRUE)

Y = split(N7, rep(1:ceiling(nrow(N7)/30), each=30, length.out=nrow(N7)))
Z = do.call(rbind,lapply(Y,function(y) y[y$MCC == median(y$MCC),]))
write.csv(Z,'~/Dropbox/SciLifeLab/git/python/N45native.csv')

#read real Data
# N23 <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCCN10_AUROC.csv")
N24<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCCREAL.csv")
# N24$class<-'High'
N24$SNRR<-paste(N24$SNR,N24$class)


# N24[6,6]<-.29174
# N24[1,6]<-.19375
# N24[4,6]<-.260079
# N24[1:8,1]<-'BSUB 0.0037352 '
# N24[17:24,1]<-'GARDNER 0.0059089  '
# N24[9:16,1]<-'LORENZ 0.011178'

# N21<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/N10_FDRs_sanity_291017_test.csv") #RNI
# N22<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/N10_FDRs_sanity_301017_test.csv") #BoRNI





# for (i in 1:20:length(N25$K))
#   max

# for (i in 1:length(N25$K))
#   if (match(grep("Bo",N25$method[i]),1)){
#     N25$boot[i]<- "bootstraped"
#   }else{
#     N25$boot[i]<- "native"}


# N25$method_f = factor(N25$method, levels=c('Glmnet','Bolasso','lsco','Bolsco','tlsco','Botlsco','RNI','BoRNI'))
# gg<-ggplot(data=N25[19:3180,],aes(x=HHLL,y=(abs(MCC)),color=factor(SNR)))+geom_boxplot()+theme_bw()+facet_grid(.~method_f)+scale_shape_discrete(solid=F)+ scale_x_discrete(limits=c("High","Low"))+  geom_point(data=N25[1:18,],aes(x=HHLL,y=((MCC)),color=factor(SNR),shape=factor(SNR)),stroke=3)

# N25$method_f = factor(N25$method, levels=c('Glmnet','lsco','tlsco','RNI'))
# gg<-ggplot(data=N25[abs(N25$MCC)>0,],aes(x=class,y=abs(MCC),color=factor(SNR)))+geom_boxplot()+theme_bw()+facet_grid(bootstrap ~method)+scale_shape_discrete(solid=F)+ scale_x_discrete(limits=c("Low","High"))+  geom_point(data=N24,aes(x=class,y=(abs(MCC)),color=factor(SNR),shape=factor(SNR)),stroke=3)
#   
N24$method_f = factor(N24$method, levels=c('Glmnet','LSCO','RNICO'))
gg<-ggplot(data=N24[abs(N24$MCC)>0,],aes(x=NestBoot,y=(abs(MCC)),color=factor(SNRR),shape=factor(SNRR),stroke=3))+geom_point()+geom_line(data=N24[abs(N24$MCC)>0,],aes(group=interaction(SNRR),color=factor(SNRR)),linetype='dashed')+theme_bw()+scale_shape_discrete(solid=F)+ facet_grid(~method)+ scale_x_discrete(limits=c("without NestBoot","with NestBoot"))+scale_fill_continuous(guide = guide_legend()) +
  theme(legend.position="bottom",axis.title.x=element_blank(),axis.text.x = element_text(angle = 45,hjust=1),text = element_text(size=15),legend.title=element_blank(),legend.box='vertical',legend.direction='vertical',panel.grid.major.x = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.y = element_blank())+ theme(plot.title = element_text(vjust=-100))
gg + labs(title = "", y = "MCC", x = "NestBoot", color = "dataset & SNR",shape="dataset & SNR")#+ guides(shape = guide_legend(override.aes = list(size=2)))

RNICO<-c(0,0.021622,0.054054,0.1027,0.15135,0.24324,0.32432,0.41081,0.45946,0.50811,0.54595,0.56757,0.57297,0.57838,0.59459,0.6,0.60541)
LASSO<-c( 0.059459,0.075676,0.097297,0.14595,0.24865,0.30811,0.39459,0.63784,0.7027,0.83784,0.9027,0.97297,0.98378,0.98919,0.99459,1)
LSCO<-c(0,0.032432,0.064865,0.14054,0.23784,0.32432,0.41622,0.46486,0.52432,0.57297,0.6,0.61081,0.62162,0.62703)
TLSCO<-c(0,0.0054054,0.027027,0.11892,0.24324,0.35676,0.46486,0.62703,0.67027,0.71892,0.73514,0.75135,0.75676,0.76216,0.76757,0.77297,0.77838)

library(readr)
library(ggplot2)
N26 <- read_csv("~/Dropbox/SciLifeLab/git/python/N26.csv")
ggplot(data=N26[N26$method=='LSCO',],aes(x=time,y=(FP/(FP+TN)),colour=method))+geom_line()

