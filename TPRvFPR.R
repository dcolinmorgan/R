#M1 <- read.csv("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS2_sortAUROC/csv/random_N50_SNR100_high.csv", header=FALSE)
setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_111016/testcsv")
dev.new(width=5, height=4)
library(RColorBrewer)
#library(wordcloud)
#library(tm)
require(lattice)
filenames<-list.files(pattern = "*.csv")
ldf <- lapply(filenames, read.csv, header=FALSE)
eee<-ncol(M1)/5
nn=10

for (i in 1:length(ldf)){
  M1<-data.frame(ldf[i])
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  #get the range for the x and y axis 
  xrange <- range(0:1) 
  yrange <- range(0:1)
  
  plotname<-paste(n1,"svg",sep=".")
  svg(plotname)
  # set up the plot 
  plot(xrange, yrange, type="n", xlab="FPR or 1-(specificity)",ylab="TPR or sensitivity" ) 
  colors <- rainbow(4) 
  linetype <- c(1:8) 
  plotchar <- c(1,2,0,5)
  colors=brewer.pal(4,name = 'Paired')
  lines(0:1,0:1)
  M2<-seq(0,1,1/ncol(M1))
  
  M1[3,]= round(M1[3,],2)
  M1[4,]= round(M1[4,],2)
  M1[7,]= round(M1[7,],2)
  M1[8,]= round(M1[8,],2)
  
  # add lines
  #RNI
  lines(rev(M1[14,seq(101,ncol(M1))]/(M1[13,seq(101,ncol(M1))]+M1[14,seq(101,ncol(M1))])),rev(M1[12,seq(101,ncol(M1))]/(M1[11,seq(101,ncol(M1))]+M1[12,seq(101,ncol(M1))])),type="o", lwd=1.5,lty=1, col=colors[1], pch = c(1, rep(NA,ncol(M1)/5)))
  #lines(M1[2,seq(101,ncol(M1))],M1[1,seq(101,ncol(M1))],type="p", col=colors[1],lwd=1.5,lty=1,cex=0.01)
  #MCC
  #text(M1[2,seq((101),(eee*4),eee+1)],M1[1,seq((101),(eee*4),eee+1)],(M1[4,seq((101),(eee*4),eee+1)]),cex=0.7,pos=3)  
  #sparsity
  #text(M1[2,seq((101),(eee*4),eee+1)],M1[1,seq((101),(eee*4),eee+1)],(M1[3,seq((101),(eee*4),eee+1)]),cex=0.7,pos=1, col="red")
  
  #LSCO
  lines(rev(M1[14,1:100]/(M1[13,1:100]+M1[14,1:100])),rev(M1[12,1:100]/(M1[11,1:100]+M1[12,1:100])),type="o", lwd=1.5,lty=1, col=colors[2], pch = c(2, rep(NA, nn+2)))
 # lines(M1[2,1:100],M1[1,1:100],type="p", col=colors[2],lwd=1.5,lty=1,cex=0.01)
  #text(M1[2,seq(1+nn+3,qq,nn+3)],M1[1,seq(1+nn+3,qq,nn+3)],rev(M1[3,seq(nn-2,qq,nn+3)]),cex=0.7,pos=1,col="red")
  #text(M1[2,seq(1+nn+3,qq,nn+3)],M1[1,seq(1+nn+3,qq,nn+3)],rev(M1[4,seq(1+nn+3,qq,nn+3)]),cex=0.7,pos=3)
  
  #Glmnet
  lines(rev(M1[19,1:100]/(M1[18,1:100]+M1[19,1:100])),rev(M1[17,1:100]/(M1[16,1:100]+M1[17,1:100])),type="o", lwd=1.5,lty=1, col=colors[3], pch = c(0, rep(NA, nn)))
 # lines(M1[6,1:100],M1[5,1:100],type="p",col=colors[3], lwd=1.5,lty=1,cex=0.01)
  #text(M1[6,seq(1+nn+1,qq,nn+1)],M1[5,seq(1+nn+1,qq,nn+1)],rev(M1[7,seq(nn-2,qq,nn+1)]),cex=0.7,pos=1,col="red")
  # text(M1[6,seq(1+nn+1,qq,nn+1)],M1[5,seq(1+nn+1,qq,nn+1)],rev(M1[8,seq(1+nn+1,qq,nn+1)]),cex=0.7,pos=3)
  
  FUCKME<-M1[20,]-(M1[16,]+M1[18,])
  
  #ARACNe  
  lines(rev(M1[19,seq(101,ncol(M1))]/(M1[18,seq(101,ncol(M1))]+M1[19,seq(101,ncol(M1))])),rev(M1[17,seq(101,ncol(M1))]/(M1[16,seq(101,ncol(M1))]+M1[17,seq(101,ncol(M1))])),type="o", lwd=1.5,lty=1, col=colors[4], pch =c(5, rep(NA,(ncol(M1)/5))))
  #lines((M1[6,seq(101,ncol(M1))]),(M1[5,seq(101,ncol(M1))]),type="p", col=colors[4],lwd=1.5,lty=1,cex=0.01)
 # text(M1[6,seq(101,ncol(M1),ncol(M1)/5)],M1[5,seq(101,ncol(M1),ncol(M1)/5)],FUCKME[1,seq(101,ncol(FUCKME),ncol(M1)/5)],cex=0.7,pos=1,col="red")
  #text(M1[6,seq(101,ncol(M1),ncol(M1)/5)],M1[5,seq(101,ncol(M1),ncol(M1)/5)],FUCKME[1,seq(101,ncol(FUCKME),ncol(M1)/5)],cex=0.7,pos=1,col="red")
  
  # text(range02[1,seq(1,ncol(range02),eee+1)],M1[5,seq(101,ncol(M1),eee+1)],(M1[7,seq(((eee*1)),((eee*4)),(eee))]),cex=0.7,pos=1,col="red")
  #text(range02[1,seq(1,ncol(range02),eee+1)],M1[5,seq(101,ncol(M1),eee+1)],M1[8,seq(((eee*1)),((eee*4)),(eee))],cex=0.7,pos=3)
  
  # add a title and subtitle 
  title(n1)
  
  # add a legend 
  legend(.85, .25, c("RNI","LSCO","Glmnet","ARACNe"), cex=0.8, col=colors,
         pch=plotchar, lty=1, title="Methods")
  dev.off()}