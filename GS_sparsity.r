#M1 <- read.csv("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS2_AUROC/csv/random_N50_SNR100_high.csv", header=FALSE)
setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_181016/sparsity")
dev.new(width=5, height=4)
library(RColorBrewer)
require(lattice)
filenames<-list.files(pattern = "*.csv")
ldf <- lapply(filenames, read.csv, header=FALSE)

for (i in 1:length(ldf)){
  M1<-data.frame(ldf[i])
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  #get the range for the x and y axis 
  xrange <- range(0:1) 
  yrange <- range(0:1)
  eee<-ncol(M1)*.1
  ccc<-ncol(M1)-eee
  #xrange2<- (logspace(-10,0,2))
  #xrange2 <-range(min(M1[5,101:(ncol(M1))]):max(M1[5,101:(ncol(M1))]))
  plotname<-paste(n1,"svg",sep=".")
  svg(plotname)
  # set up the plot 
  plot(xrange, yrange, type="n", xlab="Zetavec",
       ylab="" ) 
  linetype <- c(1:8) 
  plotchar <- c(1,2,0,5)
  colors<- brewer.pal(6,"Set1")
  #lines(0:1,0:1)
  #x1<-(M1[1,(101+eee):(ccc+eee)])
  #x2<-(M1[4,(101+eee):(ccc+eee)])
  x1<-(M1[1,(101):(ncol(M1))])
  x2<-(M1[4,(101):(ncol(M1))])
  x3<-(M1[2,(101):(ncol(M1))])
  x4<-(M1[3,(101):(ncol(M1))])
  x5<-(M1[5,(101):(ncol(M1))])
  x6<-(M1[6,(101):(ncol(M1))])
  x7<-(M1[3,1:100])
  x8<-(M1[6,1:100])
  x9<-(M1[2,1:100])
  x10<-(M1[5,1:100])
  range01 <- {(x1-min(x1))/(max(x1)-min(x1))}
  range02 <- {(x2-min(x2))/(max(x2)-min(x2))}
  range03 <- {(x3-min(x3))/(max(x3)-min(x3))}
  range04 <- {(x4-min(x4))/(max(x4)-min(x4))}
  range04[1,ncol(range04)]=0
  # range04<-replace(range04,range04>.99,0)
  range05 <- {(x5-min(x5))/(max(x5)-min(x5))}
  range06 <- {(x6-min(x6))/(max(x6)-min(x6))}
  range06[1,ncol(range06)]=0
  #  range06<-replace(range06,range06>.99,0)
  range07 <- {(x7-min(x7))/(max(x7)-min(x7))}
  range08 <- {(x8-min(x8))/(max(x8)-min(x8))}
  range09 <- {(x9-min(x9))/(max(x9)-min(x9))}
  range10 <- {(x10-min(x10))/(max(x10)-min(x10))} 
  
  # add lines
  #RNI
  #  lines(range01[1,seq(1,(ncol(range01)),eee)],M1[2,seq(101+eee,(ncol(M1)),eee)],type="b", lwd=1.5,lty=1, col=colors[1], pch=1)
  #  lines(range01[1,seq(1,(ncol(range01)),eee)],M1[3,seq(101+eee,(ncol(M1)),eee)],type="b", lwd=1.5,lty=2, col=colors[1], pch=1,cex=.5)
  #lines(range01[1,seq(1,(ncol(range01)))],(range03[1,seq(1,(ncol(range03)))]),type="o", lwd=1.5,lty=1, col=colors[2], pch = c(1, rep(NA, eee)))
  #lines(range01[1,seq(1,(ncol(range01)))],(range03[1,seq(1,(ncol(range03)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[2])
  lines(range01[1,seq(1,(ncol(range01)))],rev(range04[1,seq(1,(ncol(range04)))]),type="o", lwd=1.5,lty=1, col=colors[2],pch = c(1, rep(NA, eee)))
  lines(range01[1,seq(1,(ncol(range01)))],rev(range04[1,seq(1,(ncol(range04)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[2])
  #LSCO
  #lines(M1[1,1:100],(range09),type="o", lwd=1.5,lty=1, col=colors[3], pch = c(2, rep(NA, 10)))
  lines(seq(0,1,length=100),rev(M1[3,1:100]),type="o", lwd=1.5,lty=1, col=colors[3], pch = c(2, rep(NA, 10)))
  #lines(M1[1,1:100],(range09),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[3])
   lines(seq(0,1,length=100),rev(M1[3,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[3])
  
  #Glmnet
  #lines(M1[4,1:100],(range10),type="o", lwd=1.5,lty=1, col=colors[4], pch = c(0, rep(NA, 10)))
  lines(seq(0,1,length=100),rev(M1[6,1:100]),type="o", lwd=1.5,lty=1, col=colors[4], pch = c(0, rep(NA, 10)))
  #lines(M1[4,1:100],(range10),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[4])
  lines(seq(0,1,length=100),rev(M1[6,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[4])
  
  #ARACNe  
  #lines(range02[1,seq(1,(ncol(range01)),eee)],M1[5,seq(101+eee,(ncol(M1)),eee)],type="b", lwd=1.5,lty=1, col=colors[4], pch=5)
  #lines(range02[1,seq(1,(ncol(range01)),eee)],M1[6,seq(101+eee,(ncol(M1)),eee)],type="b", lwd=1.5,lty=2, col=colors[4], pch=5,cex=.5)
  #range06<-setdiff(range06,c(0,1))
  dd<-length(range02)-length(range06)
  #def<-min(range02[1,seq(1,(ncol(range02))-dd)])  
  #range02<-range02-def
  
  #lines(range02[1,seq(1+dd,(ncol(range02)))],(range05[1,seq(1+dd,(ncol(range05)))]),type="o", lwd=1.5,lty=1, col=colors[5], pch = c(5, rep(NA, eee)))
  #lines(range02[1,seq(1+dd,(ncol(range02)))],(range05[1,seq(1+dd,(ncol(range05)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[5])
  lines(range02[1,seq(1+dd,(ncol(range02)))],(range06[1,seq(1+dd,(ncol(range06)))]),type="o", lwd=1.5,lty=1, col=colors[5], pch = c(5, rep(NA, eee)))
  lines(range02[1,seq(1+dd,(ncol(range02)))],(range06[1,seq(1+dd,(ncol(range06)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[5])
  
  
  # add a title and subtitle
  title(n1)
  
  # add a legend 
  legend(.75, .35, c("RNI density","LSCO density","Glmnet density","ARACNe density"), cex=0.8, col=colors[2:5],
         pch=plotchar, lty=c(1,1,1,1), title="Methods")
  dev.off()}