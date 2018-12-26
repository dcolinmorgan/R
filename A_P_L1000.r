files<-list.files(recursive = TRUE)
#for (i in seq(21,58,2)){
#SHSY5Y_a<-assign(paste("SHSY5Y_a",i,sep=""), readRDS(files[i]))
#SHSY5Y_p<-assign(paste("SHSY5Y_p",i+1,sep=""), readRDS(files[i+1]))
#}
#SHSY5Y<-merge(SHSY5Y_a.*)

A = files[grep('Subset.*A_.*',files)]
P = files[grep('Subset.*P_.*',files)]

SHSY5YAmat = do.call(cbind,lapply(A,readRDS))
SHSY5YPmat = do.call(cbind,lapply(P,readRDS))
write.csv(SHSY5YAmat,file="SHSY5YA.csv")
write.csv(SHSY5YPmat,file="SHSY5YP.csv")
