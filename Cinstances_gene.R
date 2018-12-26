# aa<-info_compact[match(info_compact$X2,shRNAmap$X1),]
# 
# info_compact$X9<-info_compact$X2 %in% shRNAmap$X1
# info_order = info_compact[order(info_compact$X2),]

shRNAmap <- read_delim("~/Volume1/L1000/data_broad/shRNAmap.txt", 
                       "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
info_compact <- read_delim("~/Volume1/L1000/data_broad/info_compact.txt", 
                           "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
L978 <- read_delim("~/Volume1/L1000/data_broad/data_bin/Rgenes.txt", 
                   "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
Cinst <- read_delim("~/Volume1/L1000/data_broad/data_bin/Cinstances.txt", 
                    "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)




library(readr)
shRNAmap <- read_delim("~/Dropbox/SciLifeLab/PROJECTS/L1000/data_broad/shRNAmap.txt", 
                       "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
info_compact <- read_delim("~/Dropbox/SciLifeLab/PROJECTS/L1000/data_broad/info_compact.txt", 
                       "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
L978 <- read_delim("~/Dropbox/SciLifeLab/PROJECTS/L1000/data_bin/Rgenes.txt", 
                           "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
Cinst <- read_delim("~/Dropbox/SciLifeLab/PROJECTS/L1000/data_bin/Cinstances.txt", 
                   "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)


# Y <- read_delim("Ygene.txt", "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
c<-info_compact
# info_compact<-info_compact[jj,]

Cinst$index<-1:nrow(Cinst)

info_compact$rownumber = 1:nrow(info_compact)
# info_compact$ID<-info_compact$X2
info_compact$ID<-info_compact$X8
Cinst$ID<-Cinst$X1
IC<-merge(info_compact,Cinst,by=c("ID"),all=FALSE)


shRNAmap$ID<-shRNAmap$X1
xx_ALL<-merge(info_compact,shRNAmap,by=c("ID"),all=TRUE)

xx$IDD<-xx$X3.y
L978$IDD<-L978$X1
yyy<-merge(xx,L978,by=c("IDD"))


jj<- data.frame(yyy$X1.x)
jj$C<- (yyy$X1.x)
jj$Rgenes<- (yyy$X3.y)
jj$index<-(yyy$rownumber)
write.table(jj,file='Cinst_L978.csv')

#matlab

#Cinst_L978=readtable('Cinst_L978.csv');
#index=Cinst_L978(:,3);
#index=table2array(index);
#Ygene=Y(:,index);;

dirnames <- list.dirs(recursive = T)
filenames <- list.files(dirnames, pattern="*.rds", full.names=TRUE)
for (i in 1:length(filenames)){
  name<-paste('matrix',i,sep="")
  assign(name,readRDS(filenames[i]))
}
MM<-0
for (i in 1:length(filenames)){
  # name<-as.symbol(paste('matrix',i,sep=""))
  MM<- cbind(get(paste('matrix',i,sep="")),MM)
  }

load("~/Dropbox/SciLifeLab/PROJECTS/L1000/FC1000code/data/NPC_2_shRNA.rda")
row.names(MM)<-NPC_2_shRNA$Rgenes
MM<-MM[ ,order(colnames(MM))]
MM<-MM[order(rownames(MM)),]

write.csv(MM,'HEPG2.csv')
