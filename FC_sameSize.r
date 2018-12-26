library(readr)
setwd('~/Desktop/compare/')

myFiles<-dir(pattern="*.tsv")

dataFiles <- lapply(Sys.glob("*.tsv"), read.table)

cc<-dataFiles[[1]][2]
cc<-as.character(cc$V2) ##GS
tryCatch(
for(i in 2:length(dataFiles)){
  dd<-dataFiles[[i]][1]
  ddd<-as.character(dd$V1)
  
  aa<-setdiff(cc,ddd) ## remove these from d network links
  bb<-data.frame(dataFiles[i])
  # bb<-data.frame(bb)
  for(j in 1:length(aa)){
  bbb<-bb[!grepl(aa[j],bb$V1),]}
  # bbb<-bbb[!grepl(aa[2],bbb$V2),]
  dd<-dataFiles[[i]][2]
  ddd<-as.character(dd$V2)
  
  aa<-setdiff(cc,ddd) ## remove these from d network links
  # bb<-dataFiles[i]
  # bb<-data.frame(bb)
  for(j in 1:length(aa)){
  bbb<-bbb[!grepl(aa[j],bbb$V2),]}
  # bbb<-bbb[!grepl(aa[2],bbb$V2),]
  if(i==1){data<-bbb}else{}
  jj<-strsplit(myFiles[i],"_")
  cellline<-paste(sapply(jj,"[[",1),"_",sapply(jj,"[[",4))
  assign(cellline,bbb)
  write.table(bbb,file=paste(cellline,".tsv"),quote=FALSE,sep='\t', col.names = FALSE,row.names=FALSE)})
