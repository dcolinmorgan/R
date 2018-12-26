# https://github.com/cmap/cmapR/blob/master/cmapR_tutorial.ipynb
# setwd("/scratch/data/L1000/")
# devtools::install_github("cmap/cmapR")
# source("https://bioconductor.org/biocLite.R")
# biocLite("rhdf5")
require(reshape)
library(cmapR)
setwd('../../../../../../../../../../scratch/dmorgan/L1000data/L1000')
# setwd('L1000_GSE')

col_meta_path <- "GSE92742_Broad_LINCS_sig_info.txt"
col_meta <- read.delim(col_meta_path, sep="\t", header=T, stringsAsFactors=F)
exp_meta_path <- "GSE92742_Broad_LINCS_inst_info.txt"
exp_meta <- read.delim(exp_meta_path, sep="\t", header=T, stringsAsFactors=F)
cell_meta_path <- "GSE92742_Broad_LINCS_cell_info.txt"
cell_meta <- read.delim(cell_meta_path, sep="\t", header=T, stringsAsFactors=F)
gene_meta_path <- "GSE92742_Broad_LINCS_gene_info.txt"
gene_meta <- read.delim(gene_meta_path, sep="\t", header=T, stringsAsFactors=F)
ds_path <- "GSE92742_Broad_LINCS_Level2_GEX_epsilon_n1269922x978.gctx"
# ds_path <- "GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"

# ds_path <-"GSE92742_Broad_LINCS_Level4_ZSPCINF_mlr12k_n1319138x12328.gctx"
L978_meta_path <-"GSE92742_Broad_LINCS_gene_info.txt"
L978_meta <- read.delim(L978_meta_path, sep="\t", row.names=1, stringsAsFactors=F)
L12328_meta_path <-"GSE92742_Broad_LINCS_gene_info.txt"
L12328_meta <- read.delim(L12328_meta_path, sep="\t", row.names=1, stringsAsFactors=F)

idx <- which(exp_meta$pert_iname %in% L978_meta$pr_gene_symbol) ## all L978 genes in Q2NORM data
# idx2<-which(L12328_meta$pr_gene_symbol %in% L978_meta$pr_gene_symbol)
L12328_meta$index<-rownames(L12328_meta)
TRCN_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[idx])

exp_meta<-transform(exp_meta,FOO=colsplit(rna_plate,split="_",names=c('a','b','c','d')))
# exp_meta$pert_iname<-paste0(exp_meta$pert_iname,"_",exp_meta$FOO.d)
# exp_meta$FOO.a<-NULL
# exp_meta$FOO.b<-NULL
# exp_meta$FOO.c<-NULL
# exp_meta$FOO.d<-NULL
(TRCN_ds_annotated <- annotate.gct(TRCN_ds, exp_meta, dim="col", keyfield="inst_id"))
(TRCN_ds_annotated <- annotate.gct(TRCN_ds_annotated, L12328_meta, dim="row", keyfield="index"))
idx2<-which(TRCN_ds_annotated@rdesc$pr_gene_symbol %in% L978_meta$pr_gene_symbol)
# 

# idx <- which( TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$cell_id == "PC3" & TRCN_ds_annotated@cdesc$pert_type == "trt_sh")
# idx3 <- which( TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$cell_id == "A375" & TRCN_ds_annotated@cdesc$pert_type == "ctl_vector")
idx <- which(TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$pert_type == "trt_sh" & TRCN_ds_annotated@cdesc$cell_id == "HEPG2" |TRCN_ds_annotated@cdesc$cell_id == "MCF7"|TRCN_ds_annotated@cdesc$cell_id == "PC3"|TRCN_ds_annotated@cdesc$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|TRCN_ds_annotated@cdesc$cell_id == "HA1E"|TRCN_ds_annotated@cdesc$cell_id == "A375"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "HT29")
TRCN_ds_PC3_96h <- subset.gct(TRCN_ds_annotated, cid=idx)
TRCN_ds_PC3_96h_SQ <- subset.gct(TRCN_ds_PC3_96h, rid=idx2)

TRCN_ds_PC3_96h_SQ@cdesc$FOO.e<-paste(TRCN_ds_PC3_96h_SQ@cdesc$pert_iname,TRCN_ds_PC3_96h@cdesc$FOO.d,TRCN_ds_PC3_96h@cdesc$rna_well,sep='_')
TRCN_ds_PC3_96h_SQ@cdesc$FOO.f<-paste(TRCN_ds_PC3_96h_SQ@cdesc$pert_iname,TRCN_ds_PC3_96h@cdesc$FOO.d,sep='_')
TRCN_ds_PC3_96h_SQ@cdesc$FOO.g<-paste(TRCN_ds_PC3_96h_SQ@cdesc$pert_iname,TRCN_ds_PC3_96h@cdesc$rna_well,sep='_')

PC3SQ <- TRCN_ds_PC3_96h_SQ@mat
rownames(PC3SQ)<-TRCN_ds_PC3_96h_SQ@rdesc$pr_gene_symbol
colnames(PC3SQ) <- TRCN_ds_PC3_96h_SQ@cdesc$FOO.e
# write.csv(PC3SQ, "PC3SQ.csv", row.names = TRUE, col.names = TRUE, sep = ",")

# PC3SQaw <- TRCN_ds_PC3_96h_SQ@mat
# rownames(PC3SQaw)<-TRCN_ds_PC3_96h_SQ@rdesc$pr_gene_symbol
# colnames(PC3SQaw) <- TRCN_ds_PC3_96h_SQ@cdesc$FOO.g
# j<-aggregate(t(PC3SQaw),list(rownames(t(PC3SQaw))),mean)
# rownames(j)<-j$Group.1
# j$Group.1<-NULL
# j<-t(j)
# j<-j[order(rownames(j)),]
# 
# PC3SQax <- TRCN_ds_PC3_96h_SQ@mat
# rownames(PC3SQax)<-TRCN_ds_PC3_96h_SQ@rdesc$pr_gene_symbol
# colnames(PC3SQax) <- TRCN_ds_PC3_96h_SQ@cdesc$FOO.f
# k<-aggregate(t(PC3SQax),list(rownames(t(PC3SQax))),mean)
# rownames(k)<-k$Group.1
# k$Group.1<-NULL
# k<-t(k)
# k<-k[order(rownames(k)),]


###EMPTY STUFF
# empty_idx1 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X1")
# empty_idx2 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X2")
# empty_idx3 <- which(exp_meta$pert_iname=="EMPTY_VECTOR_X3")
exp_meta<-transform(exp_meta,FOO=colsplit(rna_plate,split="_",names=c('a','b','c','d'))) ### this splits experiment names ie plates
empty_idx <- which(exp_meta$pert_iname=="EMPTY_VECTOR"&exp_meta$cell_id == "HEPG2" |exp_meta$cell_id == "MCF7"|exp_meta$cell_id == "PC3"|exp_meta$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|exp_meta$cell_id == "HA1E"|exp_meta$cell_id == "A375"|exp_meta$cell_id == "VCAP"|exp_meta$cell_id == "HT29") #find empty vectors before cat plate ID

# empty_idx<-c(empty_idx1,empty_idx2,empty_idx3)

# sig_ids <- col_meta$distil_id[empty_idx]    ## all empty vector controls in Q2NROM data
EMPTY_ds <- parse.gctx(ds_path, cid=exp_meta$inst_id[empty_idx])
# EMPTY_ds <- parse.gctx(ds_path,cid=TRCN_ds_annotated@cdesc$pert_time == "96" & TRCN_ds_annotated@cdesc$pert_type == "ctl_vector" & TRCN_ds_annotated@cdesc$cell_id == "HEPG2" |TRCN_ds_annotated@cdesc$cell_id == "MCF7"|TRCN_ds_annotated@cdesc$cell_id == "PC3"|TRCN_ds_annotated@cdesc$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|TRCN_ds_annotated@cdesc$cell_id == "HA1E"|TRCN_ds_annotated@cdesc$cell_id == "A375"|TRCN_ds_annotated@cdesc$cell_id == "VCAP"|TRCN_ds_annotated@cdesc$cell_id == "HT29")

(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds, exp_meta, dim="col", keyfield="inst_id"))
(EMPTY_ds_annotated <- annotate.gct(EMPTY_ds_annotated, L12328_meta, dim="row", keyfield="index"))

idx <- which(EMPTY_ds_annotated@cdesc$pert_type == "ctl_vector" &EMPTY_ds_annotated@cdesc$cell_id == "HEPG2" |EMPTY_ds_annotated@cdesc$cell_id == "MCF7"|EMPTY_ds_annotated@cdesc$cell_id == "PC3"|EMPTY_ds_annotated@cdesc$cell_id == "A549"|TRCN_ds_annotated@cdesc$cell_id == "HCC515"|EMPTY_ds_annotated@cdesc$cell_id == "HA1E"|EMPTY_ds_annotated@cdesc$cell_id == "A375"|EMPTY_ds_annotated@cdesc$cell_id == "VCAP"|EMPTY_ds_annotated@cdesc$cell_id == "HT29")
EMPTY_ds_PC3_96h <- subset.gct(EMPTY_ds_annotated, cid=idx)
EMPTY_ds_PC3_96h_SQ <- subset.gct(EMPTY_ds_PC3_96h, rid=idx2)
zz<-apply(EMPTY_ds_PC3_96h_SQ@mat,1,mean) #averaging 449 empty_vectors for PC3

ww<-log2(TRCN_ds_PC3_96h_SQ@mat/zz)
# ww<-(TRCN_ds_PC3_96h_SQ@mat)
colnames(ww)<-TRCN_ds_PC3_96h_SQ@cdesc$pert_iname
rownames(ww)<-TRCN_ds_PC3_96h_SQ@rdesc$pr_gene_symbol
xa=aggregate(t(ww),by=list(rownames(t(ww))),FUN=mean) #need to run before combining distil_ids
rownames(xa)=xa[,1]
xa=xa[,2:length(xa)]
xa<-t(xa)
xa<-xa[sort(rownames(xa)),]

# pca3d(cc,group=gr)
# snapshotPCA3d(file="first_plot.png")
# jpeg('PC3.jpg')
# pca2d(cc, group=gr, biplot=TRUE, biplot.vars=3)
# dev.off()
# 

pp<-data.frame(colnames(xa))
pp<-transform(pp,FOO=colsplit(colnames.xa.,"_",names=c('a','b')))

pp$colnames.xa.<-NULL
pp$FOO.b<-NULL
library(plyr)
p<-ddply(pp,.(FOO.a),nrow)
P<-array(0L, dim(xa))
rownames(P)<-rownames(xa)
colnames(P)<-pp[,1]

c<-which(rownames(P) %in% colnames(P))
d<-which(colnames(P) %in% rownames(P))
P_new <- P
P_new<-P_new[c,d]
# P_new<-P-new[,d]
j <- 1
p_cum <- as.matrix(cumsum(p[,2]))
for (i in 1:dim(p_cum)[1]){
  P_new[i,j:p_cum[i,1]] <- 1
  j <- p_cum[i,1]+1
}

xa<-xa[c,d]
write.csv(xa,"9cancerL1000_Y.csv")
write.csv(P_new,"9cancerL1000_P.csv")

