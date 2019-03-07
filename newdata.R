library(gtools)
setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Bolasso/signMYCBolasso524-Feb-2017/signed_cytoscape_net/")
lassonameMYCsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
lassodataMYCsign <- lapply(lassonameMYCsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
file<-paste("~/Dropbox/SciLifeLab/git/R/cancerGRN/lassodataMYCsign",Sys.Date(),".rdata",sep="")
save(lassodataMYCsign,lassonameMYCsign,file=file)

setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Bolsco/signMYCBolsco524-Feb-2017/signed_cytoscape_net/")
lsconameMYCsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
lscodataMYCsign <- lapply(lsconameMYCsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscodataMYCsign",Sys.Date(),".rdata",sep="")
save(lscodataMYCsign,lsconameMYCsign,file=file)

setwd("../../afs/pdc.kth.se/home/d/dmorgan/L978_Bolsco_30-Mar-2018_FDR5.00/sign_cytoscape_net/")
lsconameL978sign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
lscodataL978sign <- lapply(lsconameL978sign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscodataL978sign",Sys.Date(),".rdata",sep="")
save(lscodataL978sign,lsconameL978sign,file=file)

setwd("../../afs/pdc.kth.se/home/d/dmorgan/L978_Bolsco_30-Mar-2018_FDR5.00/cytoscape_net/")
lsconameL978<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
lscodataL978 <- lapply(lsconameL978, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscodataL978",Sys.Date(),".rdata",sep="")
save(lscodataL978,lsconameL978,file=file)

setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/Botlsco/signMYCBotlsco524-Feb-2017/signed_cytoscape_net/")
tlsconameMYCsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
tlscodataMYCsign <- lapply(tlsconameMYCsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
file<-paste("~/Dropbox/SciLifeLab/git/R/cancerGRN/tlscodataMYCsign",Sys.Date(),".rdata",sep="")
save(tlscodataMYCsign,tlsconameMYCsign,file=file)

# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBolasso5_05-Sep-2017_FDR0.95/cytoscape_net/")
# lassonameBSUBsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
# lassodataBSUBsign <- lapply(lassonameBSUBsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lassodataBSUBsign",Sys.Date(),".rdata",sep="")
# save(lassodataBSUBsign,lassonameBSUBsign,file=file)
# 
# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBolsco5_22-Jun-2017_FDR0.95/cytoscape_net/")
# lsconameBSUBsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
# lscodataBSUBsign <- lapply(lsconameBSUBsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/lscodataBSUBsign",Sys.Date(),".rdata",sep="")
# save(lscodataBSUBsign,lsconameBSUBsign,file=file)

# setwd("~/Dropbox/SciLifeLab/PROJECTS/B.subtilis/BSUBBotlsco5_22-Jun-2017_FDR0.95/cytoscape_net/")
# tlsconameBSUBsign<-rev(mixedsort(list.files(pattern = "*.tsv"))) #TSV
# tlscodataBSUBsign <- lapply(tlsconameBSUBsign, read.csv, header=FALSE,sep='\t') #TSV push edited cytoscape csv output
# file<-paste("~/Dropbox/SciLifeLab/git/R/GSnetApp/tlscodataBSUBsign",Sys.Date(),".rdata",sep="")
# save(tlscodataBSUBsign,tlsconameBSUBsign,file=file)
