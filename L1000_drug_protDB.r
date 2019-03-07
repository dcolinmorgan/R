library(readr)
A <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/DrugBank_2_gene.tsv","\t") #universal map of gene symbol to drugbankID
A$UniProtID<-A$DrugBankID
A$DrugBankID<-NULL

B <- read_csv("~/Dropbox/SciLifeLab/git/R/proteinDB/ProteinClassDBDec5.csv") #map gene symbol to proteinID
B$UniProtID<-B$ProteinID
B$GeneName<-B$GeneNames
B$GeneNames<-NULL
B$ProteinID<-NULL

C <- read_csv("~/Dropbox/SciLifeLab/git/R/proteinDB/DrugBank_2_uniprot.csv") #uniprotID to drug name
C$UniProtID<-C$`UniProt ID`
C$`UniProt ID`<-NULL

E <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/L1000_genpert.txt","\t", escape_double = FALSE, trim_ws = TRUE) #L1000 drug to gene KD
E$GeneName<-E$`61E3.4`
E$`61E3.4`<-NULL
EE<-unique(E$GeneName)
EE<-data.frame(EE)
EE$GeneName<-EE$EE
EE$EE<-NULL

J <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/DrugBank_all_protien_ID.csv",",", escape_double = FALSE, trim_ws = TRUE)
J$UniProtID<- J$`UniProt ID`
J$`UniProt ID`<-NULL
K <- read_delim("~/Dropbox/SciLifeLab/git/R/proteinDB/PharmGKB_relationships.tsv","\t", escape_double = FALSE, trim_ws = TRUE)
# L <- read_delim("~/Desktop/STITCH_9606.protein_chemical.links.v5.0.tsv","\t", escape_double = FALSE, trim_ws = TRUE)


D<-merge(A,C,by="UniProtID")
D<-merge(D,B,by="UniProtID")
D<-merge(D,J,by="UniProtID")

D$X1<-NULL
D$GeneName.x<-NULL
D$GeneName<-D$GeneName.y
D$GeneName.y<-NULL


F<-merge(D,EE,by="GeneName",all=FALSE)

# write.table(F,"~/Dropbox/SciLifeLab/git/R/proteinDB/L1000_drug.csv",na = "",sep = ",") #contains gene symbol, uniprotID,drugbankID, drug name

n_occur <- data.frame(table(F$`DrugBank ID`))
uniqueF<-F[F$`DrugBank ID` %in% n_occur$Var1[n_occur$Freq <=2],] #2703 all unique
# write.table(uniqueF,"~/Dropbox/SciLifeLab/git/R/proteinDB/L1000_uniqueDrugP.csv",na = "",sep = ",")

Pname<-(uniqueF$GeneName)
# drug_HA1E_24_Y <- read.table(file="~/drug_HA1E_24_Y.csv",row.names=1,header=TRUE,sep=",")

Z<-intersect(unique(Pname),rownames(drug_HA1E_24_Y)) #take only genes matching L1000 list #2700 drugs
ZZ<-intersect(rownames(drug_HA1E_24_Y),unique(Pname)) #take only drugs with single gene target = 2700 drugs
HA1Ed<-drug_HA1E_24_Y[ZZ,]

uniqueF$Name<-uniqueF$Name.x
uniqueF$Name.x<-NULL
uniqueF$Name.y<-NULL
a<-data.frame(sort(uniqueF$Name))
# a<-a[1015:dim(a)[1],]
b<-(sort(colnames(HA1Ed)))
b<-gsub("\\..*","",b)
b<-gsub("\\_.*","",b)
b<-data.frame(sort(unique(b)))
# b<-(sort(colnames(HA1Ed)))
a <- apply(a,2,toupper)
b <- apply(b,2,toupper)
Q<-intersect(a,b) ## take only genes with recognizable drug anti-targets, ie find drugs with single gene targets
# QQ



HA1Ed<-t(HA1Ed)
rownames(HA1Ed)<-gsub("\\..*","",rownames(HA1Ed))
rownames(HA1Ed)<-gsub("\\_.*","",rownames(HA1Ed))
c<-data.frame(rownames(HA1Ed))
rownames(HA1Ed) <- apply(c,2,toupper)
HA1Edd<-HA1Ed[Q,]

c<-data.frame(uniqueF$Name)

uniqueF$Name <- apply(c,2,toupper)
# ccc<-[which(uniqueF$Name==Q),]
# ccc <- na.omit(ccc)
rownames(uniqueF)<-uniqueF$Name
ff<-uniqueF[Q,]
# HA1Edd<-data.frame(HA1Edd)
rownames(HA1Edd)<-paste(ff$GeneName)#,"_",ff$Name)
rownames(HA1Edd)<-sort(rownames(HA1Edd))
colnames(HA1Edd)<-sort(colnames(HA1Edd))


abc<-intersect(rownames(HA1Edd),colnames(HA1Edd)) ##make matrix "Square"
rownames(HA1Edd)<-paste(ff$Name)
HA1E<-t(HA1Edd)
HA1E<-(HA1E[abc,])
HA1E<-t(HA1E)
abc<-match(abc,colnames(HA1Edd))
HA1E<-(HA1E[abc,])



# rownames(HA1Edd)<-paste(ff$Name)

# rownames(HA1Edd)<-paste(ff$Name)

# for(i in 1:length(abc)){
#   <-HA1E[which(rownames(HA1E)==abc[i]),]
# }
write.table(HA1E,"~/Dropbox/SciLifeLab/git/R/proteinDB/HA1E_Y_drug.csv",na = "",sep = ",")
