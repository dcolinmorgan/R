setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_091116_nodiag/csv")
library(RColorBrewer)
require(lattice)
library(stringr)
filenames<-list.files(pattern = "*.csv")
ldf_1 <- lapply(filenames, read.csv, header=FALSE)

setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_091116_nodiag/zetavec")
require(lattice)
filenames<-list.files(pattern = "*.csv")
ldf_2 <- lapply(filenames, read.csv, header=FALSE)
setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/suppNODIAG/")


for (i in 1:length(ldf_1)){
  
  M1<-data.frame(ldf_1[i])
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  #get the range for the x and y axis 
  xrange <- range(0:1) 
  yrange <- range(0:1)
  eee<-ncol(M1)*.25
  nn=10
  # set up the plot
  plotname<-paste(n1,"pdf",sep=".")
  pdf(plotname,8.5,11)
  par(mfrow=c(2,2))
  plot(xrange, yrange, type="n", xlab="FPR", ylab="TPR" ) 
  colors <- rainbow(4) 
  linetype <- c(1:8) 
  plotchar <- c(1,2,0,5)
  colors<- brewer.pal(8,"Set1")
  lines(0:1,0:1,lty=2)
  segments(0,0,1,M1[5,ncol(M1)],lty=2)

  #Glmnet
  lines(M1[6,1:100],M1[5,1:100],type="o", lwd=1.5,lty=1, col=colors[4], pch = c(0, rep(NA, nn)))
  lines(M1[6,1:100],M1[5,1:100],type="p",col=colors[4], lwd=1.5,lty=1,cex=0.01)
  #LSCO
  lines(M1[2,1:100],M1[1,1:100],type="o", lwd=1.5,lty=1, col=colors[5], pch = c(2, rep(NA, nn+2)))
  lines(M1[2,1:100],M1[1,1:100],type="p", col=colors[5],lwd=1.5,lty=1,cex=0.01)
  #RNI
  lines(M1[2,seq(101,ncol(M1))],M1[1,seq(101,ncol(M1))],type="o", lwd=1.5,lty=1, col=colors[3], pch = c(1, rep(NA,eee)))
  lines(M1[2,seq(101,ncol(M1))],M1[1,seq(101,ncol(M1))],type="p", col=colors[3],lwd=1.5,lty=1,cex=0.01)
  #ARACNe  
  lines(M1[6,seq(101,ncol(M1))],M1[5,seq(101,ncol(M1))],type="o", lwd=1.5,lty=1, col=colors[2], pch =c(5, rep(NA,eee)))
  lines(M1[6,seq(101,ncol(M1))],M1[5,seq(101,ncol(M1))],type="p", col=colors[2],lwd=1.5,lty=1,cex=0.01)

  ###########################3
  M1<-data.frame(ldf_2[i])
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  #get the range for the x and y axis
  dd<-max(M1[4,seq(101,(ncol(M1)))])
  if (dd>1) {
    xrange <- c(0:dd) 
  }else{
    xrange <- c(0:1) 
    }
  M3<-M1[1,101:(ncol(M1))]
  M4<-M1[4,101:(ncol(M1))]
  range01 <- {(M3-min(M3))/(max(M3)-min(M3))}
  range02 <- {(M4-min(M4))/(max(M4)-min(M4))}
  
  yrange <- range(0:1)
  eee<-ncol(M1)*.1
  ccc<-ncol(M1)-eee
  # set up the plot 
  plot(xrange, yrange, type="n", xlab= expression(~zeta), ylab="Sparsity" ) 
  linetype <- c(1:8) 
  plotchar <- c(0,2,1,5)
  colors<- brewer.pal(6,"Set1")
 
  # add lines
  #Glmnet
  lines((M1[4,1:100]),(M1[5,1:100]),type="o", lwd=1.5,lty=1, col=colors[4], pch = c(0, rep(NA, 10)),log="x")
  lines((M1[4,1:100]),(M1[5,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[4],log="x")
  #LSCO
  lines((M1[1,1:100]),(M1[2,1:100]),type="o", lwd=1.5,lty=1, col=colors[5], pch = c(2, rep(NA, 10)),log="x")
  lines((M1[1,1:100]),(M1[2,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[5],log="x")
  #RNI
  lines(range01,(M1[2,seq(101,(ncol(M1)))]),type="o", lwd=1.5,lty=1, col=colors[3], pch = c(1, rep(NA, eee)),log="x")
  lines(range01,(M1[2,seq(101,(ncol(M1)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[3],log="x")
  #ARACNe  
  #dd<-length(range02)-length(range06)
  lines(range02,(M1[5,seq(101,(ncol(M1)))]),type="o", lwd=1.5,lty=1, col=colors[2], pch = c(5, rep(NA, eee)),log="x")
  lines(range02,(M1[5,seq(101,(ncol(M1)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[2],log="x")

  ################################3
  
  M1<-data.frame(ldf_2[i])
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  #get the range for the x and y axis 
  dd<-max(M1[4,seq(101,(ncol(M1)))])
  if (dd>1) {
    xrange <- c(0:dd) 
  }else{
    xrange <- c(0:1) }
  yrange <- range(-1:1)
  eee<-ncol(M1)*.1
  ccc<-ncol(M1)-eee
  # set up the plot 
  plot(xrange, yrange, type="n", xlab= expression(~zeta), ylab="MCC" ) 
  linetype <- c(1:8) 
  plotchar <- c(0,2,1,5)
  colors<- brewer.pal(6,"Set1")

  # add lines
  segments(-1,0,2,0)
  #Glmnet
  lines((M1[4,1:100]),(M1[6,1:100]),type="o", lwd=1.5,lty=1, col=colors[4], pch = c(0, rep(NA, 10)),log="x")
  lines((M1[4,1:100]),(M1[6,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[4],log="x")
  #LSCO
  lines((M1[1,1:100]),(M1[3,1:100]),type="o", lwd=1.5,lty=1, col=colors[5], pch = c(2, rep(NA, 10)),log="x")
  lines((M1[1,1:100]),(M1[3,1:100]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[5],log="x")
  #RNI
  lines(range01,(M1[3,seq(101,(ncol(M1)))]),type="o", lwd=1.5,lty=1, col=colors[3],pch = c(1, rep(NA, eee)),log="x")
  lines(range01,(M1[3,seq(101,(ncol(M1)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[3],log="x")
  #ARACNe  
  lines(range02,(M1[6,seq(101,(ncol(M1)))]),type="o", lwd=1.5,lty=1, col=colors[2], pch = c(5, rep(NA, eee)),log="x")
  lines(range02,(M1[6,seq(101,(ncol(M1)))]),type="p", lwd=1.5,lty=1,cex=0.01,col=colors[2],log="x")

  
  plot.new()
  n1<-paste(n1,"IAA",sep=" ")
  title(str_replace_all(n1, "_" , "\n"), cex=2, line=-4)
  legend(x="center", c("Glmnet","LSCO","RNI","ARACNe","True Positive Rate= sensitivity","False Positive Rate (FPR)= 1-specificity"), cex=1.5, col=colors[c(4,5,3,2)],pch=plotchar, lty=1, title="Methods")
  dev.off()}
