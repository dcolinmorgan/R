# https://github.com/cmap/cmapR/blob/master/cmapR_tutorial.ipynb
# setwd("/scratch/data/L1000/")
# devtools::install_github("cmap/cmapR")
# source("https://bioconductor.org/biocLite.R")
# biocLite("rhdf5")
require(reshape)
library(cmapR)
##LOCATION OF ALL FILES FROM CLUE.IO/data/TS#TOUCH
setwd('/scratch/dmorgan/L1000data/L1000')
# setwd('~/L1000_GSE/')

##dosage/time info
col_meta_path <- "/scratch/dmorgan/L1000data/L1000/GSE92742_Broad_LINCS_sig_info.txt"
col_meta <- read.delim(col_meta_path, sep="\t", header=T, stringsAsFactors=F)

##pert info
exp_meta_path <- "GSE92742_Broad_LINCS_inst_info.txt"
exp_meta <- read.delim(exp_meta_path, sep="\t", header=T, stringsAsFactors=F)

##cell info
cell_meta_path <- "GSE92742_Broad_LINCS_cell_info.txt"
cell_meta <- read.delim(cell_meta_path, sep="\t", header=T, stringsAsFactors=F)

##gene symbol & ID info
gene_meta_path <- "GSE92742_Broad_LINCS_gene_info.txt"
gene_meta <- read.delim(gene_meta_path, sep="\t", header=T, stringsAsFactors=F)

##raw expression with initial test probes
# ds_path <- "GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
ds_path <- "GSE92742_Broad_LINCS_Level2_GEX_epsilon_n1269922x978.gctx"

L978_meta_path <-"GSE92742_Broad_LINCS_gene_info.txt"
L978_meta <- read.delim(L978_meta_path, sep="\t", row.names=1, stringsAsFactors=F)

##more raw expression with new probes, expanded dataset, both delta+epsilon needed!
# ds_path <- "GSE92742_Broad_LINCS_Level2_GEX_epsilon_n1269922x978.gctx"
# L978_meta_path <-"GSE92742_Broad_LINCS_gene_info.txt"
# L978_meta <- read.delim(L978_meta_path, sep="\t", row.names=1, stringsAsFactors=F)
##cat D+E gene_info
# L978_meta2$pr_is_lm<-NULL
# L978_meta2$pr_is_bing<-NULL
# L978_meta<- rbind(L978_meta,L978_meta2)
# L978_meta2<-NULL
##select perturbed subset
idx <- which(exp_meta$pert_iname %in% L978_meta$pr_gene_symbol)
# idx2<-which(gene_meta$pr_gene_symbol %in% L978_meta2$pr_gene_symbol)
gene_meta$index<-rownames(gene_meta)
TRCN_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[idx])

exp_meta<-transform(exp_meta,FOO=colsplit(rna_plate,split="_",names=c('a','b','c','d'))) ### this splits experiment names ie plates
empty_idx <- which(exp_meta$pert_iname=="EMPTY_VECTOR") #find empty vectors before cat plate ID

exp_meta$pert_iname<-paste0(exp_meta$pert_iname,"_",exp_meta$FOO.c,exp_meta$FOO.d) ##taking just plate ID we cat it to pert_name
# exp_meta$FOO.a<-NULL
# exp_meta$FOO.b<-NULL
# exp_meta$FOO.c<-NULL
# exp_meta$FOO.d<-NULL
(TRCN_ds_annotated <- annotate.gct(TRCN_ds, exp_meta, dim="col", keyfield="inst_id"))
(TRCN_ds_annotated <- annotate.gct(TRCN_ds_annotated, gene_meta, dim="row", keyfield="index")) # we annotated matrix with experiment/plate names
idx2<-which(TRCN_ds_annotated@rdesc$pr_gene_symbol %in% L978_meta$pr_gene_symbol) # only interested in genes perturbed
# 
# idx <- which(TRCN_ds_annotated@cdesc$cell_id == "HEPG2" & TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$pert_type=="trt_sh")
idx <- which(TRCN_ds_annotated@cdesc$pert_time == "96"& TRCN_ds_annotated@cdesc$pert_type=="trt_sh" & TRCN_ds_annotated@cdesc$cell_id == "HEPG2" |TRCN_ds_annotated@cdesc$cell_id == "MCF7"|TRCN_ds_annotated@cdesc$cell_id == "PC3"|TRCN_ds_annotated@cdesc$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|TRCN_ds_annotated@cdesc$cell_id == "HA1E"|TRCN_ds_annotated@cdesc$cell_id == "A375"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "HT29")
TRCN_ds_96h <- subset.gct(TRCN_ds_annotated, cid=idx) # take only cell lines of interest
TRCN_ds_96h_SQ <- subset.gct(TRCN_ds_96h, rid=idx2) # only interested in genes perturbed

TRCN_ds_96h_SQ@cdesc$FOO.e<-paste(TRCN_ds_96h_SQ@cdesc$pert_iname,TRCN_ds_96h_SQ@cdesc$FOO.d,TRCN_ds_96h_SQ@cdesc$rna_well,sep='_')
HEPG2SQ <- TRCN_ds_96h_SQ@mat
rownames(HEPG2SQ)<-TRCN_ds_96h_SQ@rdesc$pr_gene_symbol
colnames(HEPG2SQ) <- TRCN_ds_96h_SQ@cdesc$FOO.e

# idx3<- which(TRCN_ds_96h_SQ@cdesc$pert_time == "96")
# TRCN_ds_96h_SQ <- subset.gct(TRCN_ds_96h_SQ, cid=idx3) # take only 96 hours

###EMPTY STUFF
# empty_idx1 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X1")
# empty_idx2 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X2")
# empty_idx3 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X3")
# empty_idx<-c(empty_idx1,empty_idx2,empty_idx3)

# sig_ids <- col_meta$distil_id[empty_idx]    ## all empty vector controls in Q2NROM data
EMPTY_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[empty_idx]) # parse same initial matrix for empty viral vectors
(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds, exp_meta, dim="col", keyfield="inst_id")) #annotate expt
(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds_annotated, gene_meta, dim="row", keyfield="index")) # annotate genes

# idx <- which(EMPTY_ds_annotated@cdesc$cell_id == "HEPG2" &EMPTY_ds_annotated@cdesc$pert_time == "96"& EMPTY_ds_annotated@cdesc$pert_type=="ctl_vector") # we take only 96 hour empty but is this 
idx <- which(TRCN_ds_annotated@cdesc$pert_time == "96"& TRCN_ds_annotated@cdesc$pert_type=="ctl_vector" & TRCN_ds_annotated@cdesc$cell_id == "HEPG2" |TRCN_ds_annotated@cdesc$cell_id == "MCF7"|TRCN_ds_annotated@cdesc$cell_id == "PC3"|TRCN_ds_annotated@cdesc$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|TRCN_ds_annotated@cdesc$cell_id == "HA1E"|TRCN_ds_annotated@cdesc$cell_id == "A375"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "HT29")
EMPTY_ds_96h <- subset.gct(EMPTY_ds_annotated, cid=idx)
EMPTY_ds_96h_SQ <- subset.gct(EMPTY_ds_96h, rid=idx2)
zz<-apply(EMPTY_ds_96h_SQ@mat,1,mean) #averaging 449 empty_vectors for HEPG2

ww<-log2(TRCN_ds_96h_SQ@mat/zz)
colnames(ww)<-EMPTY_ds_96h_SQ@cdesc$pert_type
rownames(ww)<-EMPTY_ds_96h_SQ@rdesc$pr_gene_symbol
xa=aggregate(t(ww),by=list(rownames(t(ww))),FUN=mean) #need to run before combining distil_ids
rownames(xa)=xa[,1]
xa=xa[,2:length(xa)]
xa<-t(xa)
xa<-xa[sort(rownames(xa)),]


pp<-data.frame(colnames(xa))
pp<-transform(pp,FOO=colsplit(colnames.xa.,"_",names=c('a','b')))



pp$colnames.xa.<-NULL
pp$FOO.b<-NULL
library(plyr)
p<-ddply(pp,.(FOO.a),nrow)
P<-array(0L, dim(xa))
rownames(P)<-rownames(xa)
colnames(P)<-pp[,1]

i<-1
j<-1
x <- matrix(c(rep(1,length(p[,2])),p[,2]), length(p[,2]), 2)
rowSums(x)

P_new <- P
j <- 1
p_cum <- as.matrix(cumsum(p[,2]))
for (i in 1:dim(p_cum)[1]){
  P_new[i,j:p_cum[i,1]] <- 1
  j <- p_cum[i,1]+1
}

c<-which(rownames(P) %in% colnames(P))
xa<-xa[c,]
P_new<-P_new[c,]
write.csv(xa,"9cancerL1000_Y.csv")
write.csv(P_new,"9cancerL1000_P.csv")


