source('~/Downloads/BINCO/R/BINCO.r')
library(space)
library(ppcor)
library(glmnet)
# library(R.matlab)
library(readr)
library(boot)

dataYY<-read_csv('~/Dropbox/SciLifeLab/git/matlab_code/B.subtilis/Y_min_160413.csv');dataY<-dataYY[2:69]
dataP<-read_csv('~/Dropbox/SciLifeLab/git/matlab_code/B.subtilis/P_min_160413.csv');
AAA<-read_csv('~/Dropbox/SciLifeLab/git/matlab_code/B.subtilis/GSmin_160412.csv');
GS_A<- read_csv('~/Dropbox/SciLifeLab/git/matlab_code/B.subtilis/Bsub_square_A.csv');

n=nrow(dataY)
p=ncol(dataY)
ParCor<-pcor(dataY, method = c("spearman"))
true.adj=abs(ParCor$estimate)>1e-6
####SPACE
alpha=1
l1=1/sqrt(n)*qnorm(1-alpha/(2*p^2))
iter=3
RL<- function(dataY,true.adj){
  result<-space.neighbor(dataY,lam1=.1)
  fit.adj=abs(ParCor$estimate)>1e-6
  sum(fit.adj==1)/2                  ##total number of edges detected
  (sum(fit.adj[true.adj==1]==1)/2)  ##total number of true edges detected
  return(result$sig.fit)
  }
####BOOT
results <- boot(data=dataY, statistic=RL,R=1000)
results
plot(results)

####BINCO
out=BINCO(count.mix=results$t0[1:68])
BINCO.plot(out.BINCO=out) 

nb=length(out$empirical_mix)
pick=((1:nb)/nb)>=out$cut_off
writeLines(paste("\n  Number of selected edges: ", sum(out$empirical_mix[pick]), "\n",
                 " Estimated FDR: ", round(out$estimated_FDR, 3), "\n",
                 " Estimated number of true edges: ", out$estimated_power, "\n"))

