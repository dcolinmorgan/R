library(readr)
A <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/uniprot_2gene.tsv","\t")
A$UniProtID<-A$DrugBankID
A$DrugBankID<-NULL

B <- read_csv("~/Dropbox/SciLifeLab/git/R/proteinDB/ProteinClassDBDec5 - ProteinClassDBDec5.csv")
B$UniProtID<-B$ProteinID
B$GeneName<-B$GeneNames
B$GeneNames<-NULL
B$ProteinID<-NULL

C <- read_csv("~/Dropbox/SciLifeLab/git/R/proteinDB/uniprot links.csv")
C$UniProtID<-C$`UniProt ID`
C$`UniProt ID`<-NULL

E <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/genpert.txt","\t", escape_double = FALSE, trim_ws = TRUE)
E$GeneName<-E$`61E3.4`
E$`61E3.4`<-NULL
EE<-unique(E$GeneName)
EE<-data.frame(EE)
EE$GeneName<-EE$EE
EE$EE<-NULL


D<-merge(A,C,by="UniProtID",all=TRUE)
D<-merge(D,B,by="UniProtID",all=TRUE)

D$X1<-NULL
D$GeneName.x<-NULL
D$GeneName<-D$GeneName.y
D$GeneName.y<-NULL


F<-merge(D,EE,by="GeneName",all=FALSE)

write.table(F,"~/Dropbox/SciLifeLab/git/R/proteinDB/L1000_drug.csv",na = "",sep = ",")

n_occur <- data.frame(table(F$`DrugBank ID`))
uniqueF<-F[F$`DrugBank ID` %in% n_occur$Var1[n_occur$Freq ==1],] ##take only drugs with single gene target
write.table(uniqueF,"~/Dropbox/SciLifeLab/git/R/proteinDB/L1000_uniqueDrugP.csv",na = "",sep = ",")

Pname<-(uniqueF$GeneName)
drug_VCAP_24_Y <- read.table(file="~/drug_VCAP_24_Y.csv",row.names=1,header=TRUE,sep=",")

Z<-intersect(Pname,rownames(drug_VCAP_24_Y)) #take only genes matching L1000 list 
ZZ<-intersect(rownames(drug_VCAP_24_Y),Pname)
VCAPd<-drug_VCAP_24_Y[ZZ,]

a<-data.frame(sort(uniqueF$Name))
# a<-a[1015:dim(a)[1],]
b<-(sort(colnames(VCAPd)))
b<-gsub("\\..*","",b)
b<-gsub("\\_.*","",b)
b<-data.frame(sort(unique(b)))
# b<-(sort(colnames(VCAPd)))
a <- apply(a,2,toupper)
b <- apply(b,2,toupper)
Q<-intersect(a,b) ## take only genes with recognizable drug anti-targets
# QQ

c<-data.frame(rownames(VCAPd))


VCAPd<-t(VCAPd)
rownames(VCAPd)<-gsub("\\..*","",rownames(VCAPd))
rownames(VCAPd)<-gsub("\\_.*","",rownames(VCAPd))
rownames(VCAPd) <- apply(c,2,toupper)
VCAPdd<-VCAPd[Q,]

c<-data.frame(uniqueF$Name)

uniqueF$Name <- apply(c,2,toupper)
# ccc<-uniqueF[which(uniqueF$Name==Q),]
# ccc <- na.omit(ccc)
rownames(uniqueF)<-uniqueF$Name
ff<-uniqueF[Q,]
# VCAPdd<-data.frame(VCAPdd)
rownames(VCAPdd)<-paste(ff$GeneName)#,"_",ff$Name)
rownames(VCAPdd)<-sort(rownames(VCAPdd))
colnames(VCAPdd)<-sort(colnames(VCAPdd))


abc<-intersect(rownames(VCAPdd),colnames(VCAPdd)) ##make matrix "Square"
# VCAP<-t(VCAP[abc,])
VCAP<-t(VCAPdd)
VCAP<-(VCAP[abc,])
VCAP<-t(VCAP)
# for(i in 1:length(abc)){
#   <-VCAP[which(rownames(VCAP)==abc[i]),]
# }
write.table(VCAP,"~/Dropbox/SciLifeLab/git/R/proteinDB/VCAP_Y_drug.csv",na = "",sep = ",")
