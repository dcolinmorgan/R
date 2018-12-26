library(ggplot2);library(readr);library(gtools)

N1<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five/Bolsco_bootstrap_N10_5FDR_sanity_check_results_19-Jan-2018.tsv",header=TRUE, sep="\t")
N1$bootstrap<-'NestBoot'
N1$method<-'LSCO'

# N2<-read.table("~/Dropbox/SciLifeLab/git/MATLAB/sanity_check/FDR_Ten/Botlsco_bootstrap_25_10FDR_sanity_check_results_28-Nov-2017.tsv",header=TRUE, sep="\t")
# N2$bootstrap<-'NestBoot'
# N2$method<-'TLSCO'
N3<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five/Bolasso_bootstrap_N10_5FDR_sanity_check_results_19-Jan-2018.tsv",header=TRUE, sep="\t")
N3$bootstrap<-'NestBoot'
N3$method<-'Glmnet'

N4<-read.table("~/Dropbox/SciLifeLab/git/python/sanity_check/FDR_Five/BoRNI_bootstrap_N10_5FDR_sanity_check_results_19-Jan-2018.tsv",header=TRUE, sep="\t")
N4$bootstrap<-'NestBoot'
N4$method<-'RNICO'

N5<-read.table("~/Dropbox/SciLifeLab/git/python/19-Jan-2018_sanity_check2.tsv",header=TRUE, sep="\t")
N5$bootstrap<-'without NestBoot'
# N5$auroc<-NULL
# N5$method<-'LSCO'
# N6<-read.table("~/Dropbox/SciLifeLab/git/MATLAB/sanity_check/Glmnet_sanity_check2_17-Jan-2018.tsv",header=TRUE, sep="\t")
# N6$bootstrap<-'without NestBoot'
# N6$auroc<-NULL
# N6$method<-'Glmnet'
# N7<-read.table("~/Dropbox/SciLifeLab/git/MATLAB/sanity_check/RNI_sanity_check2_17-Jan-2018.tsv",header=TRUE, sep="\t")
# N7$bootstrap<-'without NestBoot'
# N7$auroc<-NULL
# N7$method<-'RNICO'

N24<-rbind(N1,N4,N3,N5)

# Y = split(N7, rep(1:ceiling(nrow(N7)/30), each=30, length.out=nrow(N7)))
# Z = do.call(rbind,lapply(Y,function(y) y[y$MCC == median(y$MCC),]))
# N22<-(Z)
# 
# 
# #take max MCC per network sparsity set
# Y = split(N24, rep(1:ceiling(nrow(N24)/30), each=30, length.out=nrow(N24)))
# Z = do.call(rbind,lapply(Y,function(y) y[y$MCC == median(y$MCC),]))
# N22<-(Z)
# 
# for (i in 1:length(N22$K)) ##take median as differentiator
#   if (N22$K[i] > 12.5){
#     N22$class[i]<- "High"
#   }else{
#     N22$class[i]<- "Low"}


# N26<-merge(N25,N24,all=TRUE)
# N24$Cond.No._Method<- paste(N24$class,N24$method)


write.csv(N24,'~/Dropbox/SciLifeLab/git/python/N190118.csv')

