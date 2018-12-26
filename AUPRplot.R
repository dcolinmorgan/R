M1 <- read.csv("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GeneSPIDER8_AUROC/scalefree100100_high.csv", header=FALSE)

library(RColorBrewer)
#get the range for the x and y axis 
xrange <- range(0:1) 
yrange <- range(0:1) 

# set up the plot 
plot(xrange, yrange, type="n", xlab="FPR or 1-(specificity)",
     ylab="TPR or sensitivity" ) 
colors <- rainbow(4) 
linetype <- c(1:4) 
plotchar <- seq(1,1+4,1)
colors=brewer.pal(4,name = 'Paired')
lines(0:1,0:1)
# add lines 

lines(M1[4,1:100],M1[3,1:100],type="b", lwd=1.5,
      lty=linetype[2], col=colors[2], pch=plotchar[2])
lines(M1[6,1:100],M1[5,1:100],type="b", lwd=1.5,
      lty=linetype[3], col=colors[3], pch=plotchar[3])
lines(M1[8,1:100],M1[7,1:100],type="b", lwd=1.5,
      lty=linetype[4], col=colors[4], pch=plotchar[4])
lines(M1[2,1:100],M1[1,1:100],type="b", lwd=1.5,
      lty=linetype[1], col=colors[1], pch=plotchar[1])

# add a title and subtitle 
title("AUROC ScaleFree, N=100, high IAA, SNR=100")

# add a legend 
legend(.85, .25, c("RNI","lsco","Glmnet","ARACNE"), cex=0.8, col=colors,
       pch=plotchar, lty=linetype, title="Methods")
