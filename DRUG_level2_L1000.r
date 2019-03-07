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
ds_path <- "GSE92742_Broad_LINCS_Level2_GEX_epsilon_n1269922x978.gctx"

L978_meta_path <-"GSE92742_Broad_LINCS_gene_info.txt"
L978_meta <- read.delim(L978_meta_path, sep="\t", row.names=1, stringsAsFactors=F)

idx<-which(exp_meta$pert_type=="trt_cp")

gene_meta$index<-rownames(gene_meta)
TRCN_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[idx])

exp_meta$pert_iname<-paste0(exp_meta$pert_iname,"_",exp_meta$FOO.c,exp_meta$FOO.d) ##taking just plate
(TRCN_ds_annotated <- annotate.gct(TRCN_ds, exp_meta, dim="col", keyfield="inst_id"))
(TRCN_ds_annotated <- annotate.gct(TRCN_ds_annotated, gene_meta, dim="row", keyfield="index")) # we annotated matrix with experiment/plate names
idx2<-which(TRCN_ds_annotated@rdesc$pr_gene_symbol %in% L978_meta$pr_gene_symbol) # only interested in genes perturbed
#
# idx <- which(TRCN_ds_annotated@cdesc$cell_id == "VCAP" & TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$pert_type=="trt_sh")




idx <- which(TRCN_ds_annotated@cdesc$pert_time == "24"&TRCN_ds_annotated@cdesc$cell_id == "VCAP")#|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|TRCN_ds_annotated@cdesc$cell_id == "HA1E"|TRCN_ds_annotated@cdesc$cell_id == "A375"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "VCAP")
TRCN_ds_96h <- subset.gct(TRCN_ds_annotated, cid=idx) # take only cell lines of interest
TRCN_ds_96h_SQ <- subset.gct(TRCN_ds_96h, rid=idx2) # only interested in genes perturbed

TRCN_ds_96h_SQ@cdesc$FOO.e<-paste(TRCN_ds_96h_SQ@cdesc$pert_iname,TRCN_ds_96h_SQ@cdesc$FOO.d,TRCN_ds_96h_SQ@cdesc$rna_well,sep='_')
VCAPSQ <- TRCN_ds_96h_SQ@mat
rownames(VCAPSQ)<-TRCN_ds_96h_SQ@rdesc$pr_gene_symbol
colnames(VCAPSQ) <- TRCN_ds_96h_SQ@cdesc$FOO.e

empty_idx <- which(exp_meta$pert_type=="ctl_untrt") #find empty vectors before cat plate ID

# sig_ids <- col_meta$distil_id[empty_idx]    ## all empty vector controls in Q2NROM data
EMPTY_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[empty_idx]) # parse same initial matrix for empty viral vectors
(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds, exp_meta, dim="col", keyfield="inst_id")) #annotate expt
(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds_annotated, gene_meta, dim="row", keyfield="index")) # annotate genes

# idx <- which(EMPTY_ds_annotated@cdesc$cell_id == "VCAP" &EMPTY_ds_annotated@cdesc$pert_time == "96"& EMPTY_ds_annotated@cdesc$pert_type=="ctl_vector") # we take only 96 hour empty but is this 
idx <- which(EMPTY_ds_annotated@cdesc$pert_time == "24" & EMPTY_ds_annotated@cdesc$cell_id == "VCAP" )#|EMPTY_ds_annotated@cdesc$cell_id == "VCAP"|EMPTY_ds_annotated@cdesc$cell_id == "VCAP"|EMPTY_ds_annotated@cdesc$cell_id == "VCAP"|EMPTY_ds_annotated@cdesc$cell_id == "HCC515"|EMPTY_ds_annotated@cdesc$cell_id == "HA1E"|EMPTY_ds_annotated@cdesc$cell_id == "A375"|EMPTY_ds_annotated@cdesc$cell_id == "VCAP"|EMPTY_ds_annotated@cdesc$cell_id == "VCAP")
EMPTY_ds_96h <- subset.gct(EMPTY_ds_annotated, cid=idx)
EMPTY_ds_96h_SQ <- subset.gct(EMPTY_ds_96h, rid=idx2)
zz<-apply(EMPTY_ds_96h_SQ@mat,1,mean) #averaging 449 empty_vectors for VCAP

ww<-log2(TRCN_ds_96h_SQ@mat/zz)
colnames(ww)<-TRCN_ds_96h_SQ@cdesc$pert_iname # pert_iname
rownames(ww)<-TRCN_ds_96h_SQ@rdesc$pr_gene_symbol
# xa=aggregate(t(ww),by=list(rownames(t(ww))),FUN=mean) #need to run before combining distil_ids %% may not need for drug knockdown (??)
# rownames(xa)=xa[,1]
# xa=xa[,2:length(xa)]
# xa<-t(xa)
# xa<-xa[sort(rownames(xa)),]
# 


# c<-which(rownames(xa) %in% colnames(xa))
# ww<-t(ww)
write.csv(ww,"drug_VCAP_24_Y.csv")


