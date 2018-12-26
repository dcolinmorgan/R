setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/MYCBolasso506-Feb-2017/plot-data")
library(ggplot2)
temp = list.files(pattern="*.dat")
for (i in 1:length(temp))
  data <-read.delim(temp[i], header = TRUE, sep="\t",skip=1)
  data<-data.frame(data[1:1001,c(2,7:10)])
  cutoff<-read.delim(temp[i], header = TRUE, sep="\t",skip=1003)
  long <- melt(data, id.vars = c("bins"))
  long$bins<-as.numeric(long$bins)
  long$value<-as.numeric(long$value)
  ggplot(data=long[c(10:1001,1010:2002),],aes(bins,value/max(value),colour=variable))+ xlab("support")+
    geom_line(data=long[2003:4004,],aes(bins,value,colour=variable))+ xlab("support")+ylab("overlap")+
   geom_vline(xintercept = cutoff$support.at.cross2*1000)
  