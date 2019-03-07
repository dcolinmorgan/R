library(gtools)
#signlink
setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Bolasso/signMYCBolasso524-Feb-2017/plot-data/")
lassoMYCsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
lassoMYCsignlinkplotdata <- lapply(lassoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
lassoMYCsignlinkcutdata <- lapply(lassoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lassoMYCsignlinkplotdata",Sys.Date(),".rdata",sep="")
save(lassoMYCsignlinkplotdata,lassoMYCsignlinkcutdata,lassoMYCsignlinkplotname,file=file)

setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Bolsco/signMYCBolsco524-Feb-2017/plot-data")
lscoMYCsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
lscoMYCsignlinkplotdata <- lapply(lscoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
lscoMYCsignlinkcutdata <- lapply(lscoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscoMYCsignlinkplotdata",Sys.Date(),".rdata",sep="")
save(lscoMYCsignlinkplotdata,lscoMYCsignlinkcutdata,lscoMYCsignlinkplotname,file=file)

setwd("../../afs/pdc.kth.se/home/d/dmorgan/L978_Bolsco_30-Mar-2018_FDR5.00/plot-data")
lscoL978linkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
lscoL978linkplotdata <- lapply(lscoL978linkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
lscoL978linkcutdata <- lapply(lscoL978linkplotname, read.delim, header=TRUE,sep='\t',skip=103)
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscoL978linkplotdata",Sys.Date(),".rdata",sep="")
save(lscoL978linkplotdata,lscoL978linkcutdata,lscoL978linkplotname,file=file)


setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Botlsco/signMYCBotlsco524-Feb-2017/plot-data/")
tlscoMYCsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
tlscoMYCsignlinkplotdata <- lapply(tlscoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1)
tlscoMYCsignlinkcutdata <- lapply(tlscoMYCsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
file<-paste("~/Dropbox/SciLifeLab/git/R/cancerGRN/tlscoMYCsignlinkplotdata",Sys.Date(),".rdata",sep="")
save(tlscoMYCsignlinkplotdata,tlscoMYCsignlinkcutdata,tlscoMYCsignlinkplotname,file=file)
# 
# #LINK
# setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/MYCBolasso506-Jan-2017/plot-data")
# lassoMYClinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# lassoMYClinkplotdata <- lapply(lassoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# lassoMYClinkcutdata <- lapply(lassoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lassoMYClinkplotdata",Sys.Date(),".rdata",sep="")
# save(lassoMYClinkplotdata,lassoMYClinkcutdata,lassoMYClinkplotname,file=file)
# 
# setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/MYCBolsco506-Jan-2017/plot-data")
# lscoMYClinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# lscoMYClinkplotdata <- lapply(lscoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# lscoMYClinkcutdata <- lapply(lscoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscoMYClinkplotdata",Sys.Date(),".rdata",sep="")
# save(lscoMYClinkplotdata,lscoMYClinkcutdata,lscoMYClinkplotname,file=file)
# 
# setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/MYCBotlsco506-Jan-2017/plot-data")
# tlscoMYClinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# tlscoMYClinkplotdata <- lapply(tlscoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# tlscoMYClinkcutdata <- lapply(tlscoMYClinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/tlscoMYClinkplotdata",Sys.Date(),".rdata",sep="")
# save(tlscoMYClinkplotdata,tlscoMYClinkcutdata,tlscoMYClinkplotname,file=file)
# 
# #BSUB
# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBolasso5_05-Sep-2017_FDR0.95/plot-data")
# lassoBSUBsignlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# lassoBSUBsignlinkplotdata <- lapply(lassoBSUBsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# lassoBSUBsignlinkcutdata <- lapply(lassoBSUBsignlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lassoBSUBsignlinkplotdata",Sys.Date(),".rdata",sep="")
# save(lassoBSUBsignlinkplotdata,lassoBSUBsignlinkcutdata,lassoBSUBsignlinkplotname,file=file)
# 
# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBolsco5_05-Sep-2017_FDR0.95/plot-data")
# lscoBSUBlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# lscoBSUBlinkplotdata <- lapply(lscoBSUBlinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# lscoBSUBlinkcutdata <- lapply(lscoBSUBlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscoBSUBlinkplotdata",Sys.Date(),".rdata",sep="")
# save(lscoBSUBlinkplotdata,lscoBSUBlinkcutdata,lscoBSUBlinkplotname,file=file)
# 
# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBotlsco5_05-Sep-2017_FDR0.95/plot-data")
# tlscoBSUBlinkplotname<-rev(mixedsort(list.files(pattern = "*.dat"))) #TSV
# tlscoBSUBlinkplotdata <- lapply(tlscoBSUBlinkplotname, read.delim, header=TRUE,sep='\t',skip=1) 
# tlscoBSUBlinkcutdata <- lapply(tlscoBSUBlinkplotname, read.delim, header=TRUE,sep='\t',skip=1003)
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/tlscoBSUBlinkplotdata",Sys.Date(),".rdata",sep="")
# save(tlscoBSUBlinkplotdata,tlscoBSUBlinkcutdata,tlscoBSUBlinkplotname,file=file)
