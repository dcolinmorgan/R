library(readr)
library(ggplot2)
#read real Data
# N23 <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCCN10_AUROC.csv")
# N24<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCCREAL.csv")
# N24<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCC_medianREAL.csv")
N24<-read_csv("~/Dropbox/SciLifeLab/PROJECTS/bootBench/KvSNRMCC_medianREAL.csv")


# N24$class<-'High'
N24$SNRR<-paste(N24$SNR,N24$class)


N24$method_f = factor(N24$method, levels=c('CLR','Genie3','LASSO','LSCO','RNICO'))
gg<-ggplot(data=N24[abs(N24$MCC)>0,],aes(x=meth,y=(abs(MCC)),color=factor(SNRR),shape=factor(SNRR),stroke=3))+geom_point()+
  geom_line(data=N24[abs(N24$MCC)>0,],aes(group=interaction(SNRR),color=factor(SNRR)),linetype='dashed')+theme_bw()+scale_shape_discrete(solid=F)+
  facet_grid(.~method_f,scales="free")+ #scale_fill_continuous(guide = guide_legend()) +scale_x_discrete()+
  theme(legend.position="bottom",axis.title.x=element_blank(),axis.text.x = element_text(angle = 45,hjust=1),text = element_text(size=15),legend.title=element_blank(),legend.box='vertical',legend.direction='vertical',panel.grid.major.x = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.y = element_blank())+ theme(plot.title = element_text(vjust=-100))
gg + labs(title = "", y = "Median MCC", x = "NestBoot", color = "dataset & SNR",shape="dataset & SNR")#+ guides(shape = guide_legend(override.aes = list(size=2)))

# RNICO<-c(0,0.021622,0.054054,0.1027,0.15135,0.24324,0.32432,0.41081,0.45946,0.50811,0.54595,0.56757,0.57297,0.57838,0.59459,0.6,0.60541)
# LASSO<-c( 0.059459,0.075676,0.097297,0.14595,0.24865,0.30811,0.39459,0.63784,0.7027,0.83784,0.9027,0.97297,0.98378,0.98919,0.99459,1)
# LSCO<-c(0,0.032432,0.064865,0.14054,0.23784,0.32432,0.41622,0.46486,0.52432,0.57297,0.6,0.61081,0.62162,0.62703)
# TLSCO<-c(0,0.0054054,0.027027,0.11892,0.24324,0.35676,0.46486,0.62703,0.67027,0.71892,0.73514,0.75135,0.75676,0.76216,0.76757,0.77297,0.77838)

