library(ALPACA)
# library(stringr)
library(readr)
# library(dostats)
# library(plyr)

# parent.folder<-'/afs/pdc.kth.se/home/d/dmorgan/Volume1/NB_L1000'
# parent.folder<-'~/Desktop/compare/L1000_comparison/'
ww<-1
simp.alp<-list()
simp.alp2<-list()
zz<-list()
data <- read.table("~/Dropbox/Sonnhammer_group/Data/L1000_GRN_alpaca.csv",header=T,sep=",")
for(i in 3:dim(data)[2]){
  for(j in 4:dim(data)[2]){
    cc<-data[c(1:2,i,j)]
    cc[cc[3]==0&cc[4]==0,]<-NA
    cc<-na.omit(cc[,1:4])
    try(
    simp.alp <- alpaca(cc,NULL,verbose=F) )#tryCatch(
    if(length(simp.alp)!=0){
    simp.alp2 <- simp.alp[[1]] #)tryCatch(
    simp.memb <- as.vector(simp.alp[[1]]) #)tryCatch(
    names(simp.memb) <- names(simp.alp[[1]]) #)tryCatch(
    zz[[ww]]<-simp.memb
    # simp.memb[ww]

    ww<-ww+1}else{}



}}
output <- do.call(rbind,lapply(zz,matrix,ncol=89,byrow=TRUE))
J<-unique(zz)










# 
# 
# 
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
# cells<- list.dirs(parent.folder, recursive=FALSE)
# sub.folders <- list.dirs(cells, recursive=TRUE)
# sub.folders<- sub.folders[ grepl("_NB", sub.folders) ]
# 
# JAKS<-matrix(0,length(sub.folders),length(sub.folders))
# JAKD<-matrix(0,length(sub.folders),length(sub.folders))
# 
# 
# gg<-strsplit(sub.folders,"/")
# ggg<-sapply(gg,"[[",9)
# gg<-strsplit(ggg,"_")
# ggg<-sapply(gg,"[[",1)
# 
# rownames(JAKS)<-ggg
# colnames(JAKS)<-ggg
# rownames(JAKD)<-ggg
# colnames(JAKD)<-ggg
# 
# i<-9
# k<-4
# # for(i in 2:length(sub.folders)){
#   myFiles<-list.files(sub.folders[i])
#   myFiles<-myFiles[order(file.size(list.files(sub.folders[i],full.names=TRUE)))]
#   
#   gg<-strsplit(sub.folders[i],"/")
#   if(sapply(gg,"[[",9)=="merged_NB"){
#     jjj=978
#   }else{
#   
#   
#   jj<-strsplit(myFiles,"_")
#   jjj<-unique(sapply(jj,"[[",3))
#   jjj<-strsplit(jjj,"L")
#   jjj<-sapply(jjj,"[[",2)
#   jjj<-as.numeric(jjj)}
#   for (p in seq_along(myFiles)) {
#     assign(paste("Df", p, sep = "."), read_delim(file.path(sub.folders[i],myFiles[p]),"\t",escape_double = FALSE, col_names = FALSE, trim_ws = TRUE))
#     cc= dim(get(paste("Df", p, sep = ".")))[1]
#       if(jjj*2 < cc & cc < jjj*10){
#         aa[p]<-p
#         net<-eval(parse(text=paste("Df", p, sep = ".")))
#         NET<-data.frame(net)
#         
#         NET$Row.names<-NULL
#         NET$X6<-NULL
#         NET$X5<-NULL
#         NET$X4<-NULL
#         NET[is.na(NET)] <- 0
#         colnames(NET)<-c('C1','C2','C3')
#         NET$C4<-paste(NET$C1,NET$C2,sep="_")
#         NET$C1<-NET$C4
#         NET$C4<-NULL
#         NET$C2<-NULL
#         NET$C3<-NULL#as.double(NET$C3)
#         # NETT<-NET$C1
#         # NETT<-data.frame(NET$C1)
#         if (exists('NETT')){
#           append(NETT,NET$C1)
#         }else{NETT=NET$C1}
#         
#         bb<-  as.data.frame(table(NETT))
#         for(kk in 1:length(bb)){
#         if(bb$Freq[kk] < (sum(is.na(aa))-1)/2){bb$NETT<-NULL}
#         
#         }
#         }
#     }
#   # jj<-strsplit(myFiles,"_")
#   jjj<-sapply(jj,"[[",5)
#   j<-which.max(as.numeric(str_extract(jjj, "\\d+\\.*\\d*")))  
#   net1 <- read_delim(file.path(sub.folders[i],myFiles[j]),"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
#   
#   for(k in 4:length(sub.folders)){
#     myFiles<-list.files(sub.folders[k])
#     jj<-strsplit(myFiles,"_")
#     jjj<-sapply(jj,"[[",5)
#     j<-which.max(as.numeric(str_extract(jjj, "\\d+\\.*\\d*")))  
#     net2 <- read_delim(file.path(sub.folders[k],myFiles[j]),"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
#   
#   net1<-net1[c(1,2,6)]
#   net1<-data.frame(net1)
#   rownames(net1)<-paste(net1$X1,net1$X2,sep='')
#   
#   net2<-data.frame(net2[c(1,2,6)])
#   rownames(net2)<-paste(net2$X1,net2$X2,sep='')
#   
#   
#   
# # if(dim(net1)[1]>dim(net2)[1]){
#   net_all<-merge(net1,net2,by="row.names",all.x=TRUE)}else{
#     net_all<-merge(net2,net1,by="row.names",all.x=TRUE)}
#   net_INalpaca<-data.frame(net_all)
# 
#   net_INalpaca$Row.names<-NULL
#   net_INalpaca$X1.y<-NULL
#   net_INalpaca$X2.y<-NULL
#   net_INalpaca[is.na(net_INalpaca)] <- 0
#   colnames(net_INalpaca)<-c('C1','C2','C3','C4')
#   net_INalpaca$C5<-net_INalpaca$C1
#   net_INalpaca$C1<-net_INalpaca$C2
#   net_INalpaca$C2<-net_INalpaca$C5
#   net_INalpaca$C5<-NULL
#   net_INalpaca$C3<-as.double(net_INalpaca$C3)
#   net_INalpaca$C4<-as.double(net_INalpaca$C4)
#   net_INalpaca$C1<-paste('A_',net_INalpaca$C1,sep='')
#   net_INalpaca$C2<-paste('B_',net_INalpaca$C2,sep='')
#   net_INalpaca$C1<-as.factor(net_INalpaca$C1)
#   net_INalpaca$C2<-as.factor(net_INalpaca$C2)
#   
#   # ret<-jaccard(net_INalpaca[3:4],1)
#   # list2env(ret,env=environment())
#   # JAKS[i,k]<-JSim
#   # JAKD[i,k]<-JDist
#   
# # }
# # }
#   # simp.alp <- alpaca(net_INalpaca,NULL,verbose=F)
#   # simp.alp2 <- simp.alp[[1]]
#   # simp.memb <- as.vector(simp.alp2)
#   # names(simp.memb) <- names(simp.alp2)
#   # simp.memb
#   
# ### INITIATE ALPACA in I,K loops to append save output in matrix
# 
# # simp.mat <- read.table('Example_2comm.txt',header=T)
#   # simp.mat$C3<-round(runif(1600),digits=1)
#   # simp.mat$C4<-round(runif(1600),digits=1)
# # simp.alp <- alpaca(simp.mat,NULL,verbose=F)
# 
# ####TEST 2
#   # net_INalpacaTEST<-data.frame(rep(simp.mat$C1,each=dim(net_INalpaca)[1]/dim(simp.mat)[1]))
#   # net_INalpacaTEST$C1<-(rep(simp.mat$C1,each=dim(net_INalpaca)[1]/dim(simp.mat)[1]))
#   # net_INalpacaTEST$rep.simp.mat.C1..each...dim.net_INalpaca..1..dim.simp.mat..1..<-NULL
#   # net_INalpacaTEST$C2<-(rep(simp.mat$C2,each=dim(net_INalpaca)[1]/dim(simp.mat)[1]))
#   # net_INalpacaTEST$C3<-net_INalpaca$C3[1:dim(net_INalpacaTEST)[1]]
#   # net_INalpacaTEST$C4<-net_INalpaca$C4[1:dim(net_INalpacaTEST)[1]]
# # simp.alp <- alpaca(net_INalpacaTEST,NULL,verbose=F)
# 
# #######TEST 1
# # Test<-rep(paste('A',1:50,sep=''),each=10)
# # Test<-data.frame(Test)
# # Test$C1<-rep(paste('A',1:50,sep=''),each=10)
# # Test$C2<-rep(paste('B',1:100,sep=''),each=5)
# # Test$C3<-round(runif(500),digits=0)
# # Test$C4<-round(runif(500),digits=0)
# # Test$C1<-as.factor(Test$C1)
# # Test$C2<-as.factor(Test$C2)
# # Test$Test<-NULL
# # simp.alp <- alpaca(Test,NULL,verbose=F)
