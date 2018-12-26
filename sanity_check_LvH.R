library(ggplot2);library(readr)
# setwd('/afs/pdc.kth.se/home/d/dmorgan/NestBoot/NN45/')
# temp = list.files(pattern="*.tsv")
# for (i in 1:length(temp)) assign(temp[i], read_delim(temp[i],"\t", escape_double = FALSE, trim_ws = TRUE))
# 
# N45NB<-rbind(`N45_sanity_check_Bolasso_NESTBOOT_test_23-Mar-2018.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_24-Mar-2018 18:45:09.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_24-Mar-2018 18:45:15.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_24-Mar-2018 18:45:22.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_24-Mar-2018 18:45:28.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_24-Mar-2018.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_25-Mar-2018.tsv`,`N45_sanity_check_Bolasso_NESTBOOT_test_26-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_23-Mar-2018 15:42:30.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_23-Mar-2018 15:42:57.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_23-Mar-2018 15:43:08.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_23-Mar-2018 15:43:15.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_23-Mar-2018.tsv`,`N45_sanity_check_BoRNI_NESTBOOT_test_21-Mar-2018.tsv`,`N45_sanity_check_BoRNI_NESTBOOT_test_22-Mar-2018.tsv`,`N45_sanity_check_BoRNI_NESTBOOT_test_23-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_19-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_20-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_21-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_22-Mar-2018.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_27-Mar-2018 13:33:39.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_27-Mar-2018 13:34:01.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_27-Mar-2018 13:34:18.tsv`,`N45_sanity_check_Bolsco_NESTBOOT_test_27-Mar-2018 13:34:33.tsv`,`N45_sanity_check_tt_NATIVE_test_28-Mar-2018.tsv`)
N45NB<-N45_sanity_check_tt_NATIVE_test_16_Apr_2018
Y = split(N45NB, rep(1:ceiling(nrow(N45NB)/30), each=30, length.out=nrow(N45NB)))
N45NB = do.call(rbind,lapply(Y,function(y) cbind(y,median(abs(y$MCC)))))
N45NB$`median MCC`<-N45NB$`median(na.omit(y$MCC))`
# Y = split(N45NB, rep(1:ceiling(nrow(N45NB)/30), each=30, length.out=nrow(N45NB)))

N45NB = do.call(rbind,lapply(Y,function(y) cbind(y,max(na.omit(y$MCC)))))
N45NB$`max MCC`<-N45NB$`max(na.omit(y$MCC))`
N45NB=na.omit(N45NB)
N45NB$method<- replace(N45NB$method, N45NB$method=="Bolasso", "LASSO")
N45NB$method<- replace(N45NB$method, N45NB$method=="Bolsco", "LSCO")
N45NB$method<- replace(N45NB$method, N45NB$method=="BoRNI", "RNICO")
N45NB$meth<-paste('NestBoot',N45NB$method)
N45NB$boot<-paste('NestBoot')
N45NB$bootstrap<-paste('bootstrap')
N45NB$meth<- replace(N45NB$meth, N45NB$meth=="NestBoot native Genie3", "Genie3")
N45NB$`med ian MCC`[N45NB$meth=='Genie3']<-(N45NB$`median MCC`[N45NB$meth=='Genie3'])+.6

write.csv(N45NB,'~/Dropbox/SciLifeLab/git/python/Genie3_N45NB.csv')



setwd('/afs/pdc.kth.se/home/d/dmorgan/NestBoot/N45/')
temp = list.files(pattern="*.tsv")
for (i in 1:length(temp)) assign(temp[i], read_delim(temp[i],"\t", escape_double = FALSE, trim_ws = TRUE))

N45nonNB<-(`N45_sanity_check_NATIVE_test_08-Mar-2018.tsv`)
Y = split(N45nonNB, rep(1:ceiling(nrow(N45nonNB)/30), each=30, length.out=nrow(N45nonNB)))
# N45NB = do.call(rbind,lapply(Y,function(y) y[y$MCC == max(y$MCC),]))
N45nonNB = do.call(rbind,lapply(Y,function(y) cbind(y,median(na.omit(y$MCC)))))
N45nonNB$`median MCC`<-N45nonNB$`median(na.omit(y$MCC))`
Y = split(N45nonNB, rep(1:ceiling(nrow(N45nonNB)/30), each=30, length.out=nrow(N45nonNB)))
N45nonNB = do.call(rbind,lapply(Y,function(y) cbind(y,max(na.omit(y$MCC)))))
N45nonNB$`max MCC`<-N45nonNB$`max(na.omit(y$MCC))`
N45nonNB$meth<-paste('native',N45nonNB$method)
N45nonNB$boot<-paste('native')
N45nonNB$bootstrap<-paste('native')
write.csv(N45nonNB,'~/Dropbox/SciLifeLab/git/python/N45nonNB.csv')


N45overall<-rbind(N45NB,N45nonNB)
write.csv(N45overall,'~/Dropbox/SciLifeLab/git/python/N45overall.csv')

##
# N45Boot<-rbind(N45NB,N45nonNB[N45nonNB$method=='Genie3',])
# N45Boot<-na.omit(N45Boot)
# write.csv(N45Boot,'~/Dropbox/SciLifeLab/git/python/N45_bootstrap.csv')

# data <- read.table("N45_sanity_check_tt_NATIVE_test_15-Mar-2018.tsv",sep=",")
# N45_FDRs_sanityBOLASSO_090617_test.tsv$auroc<-c("0")
# N45_FDRs_sanityBOLSCO_090617_test.tsv$auroc<-c("0")
# N45_FDRs_sanityBOTLSCO_090617_test.tsv$auroc<-c("0")
# N45_FDRs_sanityBOLASSO_200617_test.tsv$auroc<-c("0")
# N45_FDRs_sanityBOLSCO_200617_test.tsv$auroc<-c("0")
# N45_FDRs_sanityBOTLSCO_200617_test.tsv$auroc<-c("0")

# N23<-rbind(N45_FDRs_sanityBOLASSO_200617_test.tsv,N45_FDRs_sanityBOLSCO_200617_test.tsv,
           # N45_FDRs_sanityBOTLSCO_200617_test.tsv,N45_FDRs_sanityBOLASSO_090617_test.tsv,N45_FDRs_sanityBOLSCO_090617_test.tsv,
           # N45_FDRs_sanityBOTLSCO_090617_test.tsv)#,N45_FDRs_sanityBOLASSO_080617_test.tsv,N45_FDRs_sanityBOLSCO_080617_test.tsv)

# jj<-NA
# for (i in seq(1,dim(data)[1],by=30)){
#   jj[i]<-which.median(data$MCC[1+i:30+i])
#   jj<-which(!is.na(jj))}
# N24<-data[jj,]
# 
# gg<- which(N24$MCC!=0)
# N24<-N24[gg,]
# N24$MCC<-N24$MCC
# N23<-rbind(N45_limit_sanity_check_results_23_03_17.tsv,N24)
# 
# for (i in 1:length(N23$K))
#   # if (N23$SNR ==0.01){
#   if (N23$TK[i] > 28){
#     N23$HHLL[i]<- "High"
#   }else{
#     N23$HHLL[i]<- "Low"}#}
# N23$method_f = factor(N23$method, levels=c('Glmnet','Bolasso','lsco','Bolsco','tlsco','Botlsco','RNI'))
# gg<-ggplot(data=N23,aes(x=HHLL,y=((MCC)),color=factor(SNR)))+facet_grid(.~method_f)+theme_bw()+ geom_boxplot()+scale_x_discrete(limits=c("High","Low"))
# 
# gg + labs(title = "Synthetic N45 Data Performance with FDR 5% Bootstrap", y = "MCC", x = "K", color = "SNR(source)")