#### Load necessary packages and data ####

library(reshape2)
library(ggplot2)
library(reshape2)
library(plyr)
require(visNetwork, quietly = TRUE)
# ### LOAD PLOT DATA ###
setwd("~/Dropbox/SciLifeLab/git/R/GSnetApp/")
load("lscoL978linkplotdata2018-03-30.rdata")
load("lscodataL978sign2018-03-30.rdata")
eee<-list(lscoL978linkplotdata=lscoL978linkplotdata)
wee<-"lscoL978linkplotdata"
datum<-(eee[[wee]])
data<-data.frame(datum[[18]])
# if ((identical(input$data, "MYCsign" )) ){
  # data[1:(dim(data)[1]-3),11]<-(as.numeric(as.character(data[1:(dim(data)[1]-3),9]))+(max(as.numeric(as.character(data[1:(dim(data)[1]-3),6])))-max(as.numeric(as.character(data[1:(dim(data)[1]-3),9])))))
  # data[1:(dim(data)[1]-3),11]<-scale(as.numeric(data[1:(dim(data)[1]-3),6]),center=F,scale=(0,max(as.numeric(data[1:(dim(data)[1]-3),9])))
  # colnames(data)[colnames(data)=="V11"] <- "overlap_MYC"
  # data<-data.frame(data[1:(dim(data)[1]-3),c(2,7,8,6,11)])}else{
  data<-data.frame(data[1:(dim(data)[1]-3),c(2,3,4,6,5)])#}
# qee<-paste(input$method,"name",input$data,sep="")
# fff[[qee]][[input$sparsity]]
  ggg<-list(lscoL978linkcutdata=lscoL978linkcutdata)
  zee<-"lscoL978linkcutdata"
  cutoffs<-(ggg[[zee]])
  cutoff<-(cutoffs[[18]])
  cutoff<-data.frame(cutoff)
  cutoff$CUT<-cutoff$support.at.cross


# data<-rename(data,c("MYC"="Measured","shuffle"="Randomized","overlap_MYC"="Overlap, Measured","overlap_shuffle"="Overlap, Randomized"))
data<-rename(data, Measured = MYC, Randomized = shuffle, `Overlap, Randomized` = overlap_MYC, `Overlap, Measured` = overlap_shuffle)

# library(fisheyeR)
# addNoise(matrix(rep(1,100), ncol = 2))

long <- melt(data, id.vars = c("bins"))
long$bins<-as.numeric(long$bins)
long$value<-as.numeric(long$value)
intercept1=cutoff$support.at.cross2[2]
ccc=max(long[c(10:(dim(data)[1]),(dim(data)[1]):(((dim(data)[1]))*2)),]$value)
fff<-list(lsconameL978sign=lsconameL978sign)
qee<-paste("lsconameL978sign",sep="")
aa<-fff[[qee]][[18]]
bb<-strsplit(aa,"_")
cc<-sapply(bb,"[[",5)
dd<-substr(cc,5,nchar(cc))
ay <- list(
  tickfont = list(color = "black"),
  overlaying = "y",
  side = "right",
  title = "Frequency",
  range = c(0, ccc),
  showline = FALSE,
  showgrid = FALSE
)
ff=1
hh=(dim(data)[1])

  cutoff$CUT<-(cutoff$support.at.cross)*10
  # ccc=max(long[c(1:(dim(data)[1]),(dim(data)[1]):(((dim(data)[1]))*2)),]$value)
  # ff=1
  gg=(dim(data)[1])+1
  ee=as.numeric(dd)


a<-vector()
b<-vector()
for (i in 1:(dim(data)[1])){
  a[i]<-trapz(long$bins[c(i:(dim(data)[1]))]/(dim(data)[1]), long$value[c(i:(dim(data)[1]))]/max(long$value[c(i:(dim(data)[1]))]))
  b[i]<-trapz(long$bins[c(((hh)+i):(hh*2))]/(dim(data)[1]), long$value[c(((hh)+i):(hh*2))]/max(long$value[c(i:(dim(data)[1]))]))
}
# ab<-((1002-(length(na.omit(b/a)))))
ww<-plot_ly() %>%
  add_lines(x = long$bins[c(ff:(dim(data)[1]))]/(dim(data)[1]), y = (long$value[c(ff:(dim(data)[1]))]/max(long$value[c(ff:(dim(data)[1]))])), name = "Measured",line = list(color = 'rgb(22, 96, 167)')) %>%
  
  add_lines(x = long$bins[c(gg:(hh*2))]/(dim(data)[1]), y = (long$value[c(gg:(hh*2))]/max(long$value[c(ff:(dim(data)[1]))])), name = "Randomized", line = list(color = 'rgb(205, 12, 24)'))%>%
  add_lines(x = long$bins[(1+hh*3):(hh*4)]/(dim(data)[1]), y = (long$value[(1+hh*3):(hh*4)]/max(long$value[(1+hh*3):(hh*4)]))*ccc, name = "Overlap, Measured", yaxis = "y2",fill = 'tozeroy',line = list(color = 'rgba(55, 15, 255,0.1)'),fillcolor = list(color = 'rgba(55, 15, 255,0.01)')) %>%
  add_lines(x = long$bins[(1+hh*2):(hh*3)]/(dim(data)[1]), y = (long$value[(1+hh*2):(hh*3)]/max(long$value[(1+hh*2):(hh*3)]))*ccc, name = "Overlap, Randomized", yaxis = "y2",fill = 'tozeroy',line = list(color = 'rgba(207, 114, 129,0.1)'),fillcolor = list(color = 'rgba(207, 114, 129,0.01)')) %>%
  # add_lines(x=c(1:(length(na.omit(b/a)))/(dim(data)[1])),y=na.omit(b/a), name = "FDR",line = list(color = 'grey',dash = "dash")) %>%
  add_lines(x=c(1:(dim(data)[1]))/(dim(data)[1]),y=na.locf(b/a)/2, name = "FDR",line = list(color = 'grey',dash = "dash")) %>%
  add_trace(x = as.numeric(ee)/10, y = c(0,1),line = list(dash = "dash",color = "orange"),type='scatter',mode='lines',name="support at cutoff") %>%
  # add_trace(x = (cutoff$CUT[1])-.02, y = c(0,1),line = list(dash = "dash",color = "orange"),type='scatter',mode='lines',name="support at cutoff") %>%
  layout(margin = list(l=100, r=50, b=50, t=50, pad=0),
         paper_bgcolor='rgba(0,0,0,0)',
         plot_bgcolor='rgba(0,0,0,0)',
         yaxis2 = ay,yaxis=list(range=c(0,1),title="Overlap",showline = FALSE,showgrid = FALSE), 
         xaxis = list(title="Support",y = 0.05,showline = FALSE,showgrid = FALSE),
         legend = list(x = 0.1, y = -0.2,orientation = 'h')
  )

