setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_141116_hasdiag/andreas")
library(RColorBrewer)
require(ggplot2)
library(gridExtra)
library(cowplot)
library(stringr)
#library(scales)
filenames<-list.files(pattern = "*.csv")
ldf_1 <- lapply(filenames, read.csv, header=TRUE)
setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_141116_hasdiag/finalFIG")

for (i in 1:length(ldf_1)){
  
  M1<-data.frame(ldf_1[i])
  if (length(t(M1))<150000) {n<- 100;nn<- n
  } else{
    if (length(t(M1))<600000) {n<- 2500;nn<- (sqrt(n)/2)}
    else{n<- 10000;nn<- sqrt(n)}}
  M1$method<-c(rep("RNI",each=n),rep("LSCO",each=n),rep("Glmnet",100),rep("ARACNe",each=n))
  
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4);n1<-paste(n1,"IAA",sep="")
  # set up the plot
  plotname<-paste(n1,"png",sep=".")
  png(plotname,width=8.5, height=11,units="in",pointsize=12,res=200)#(plotname,8.5,11)
  #par(mfrow=c(2,2))
  
  col.g <- c(brewer.pal(6,"Set1"))[4:5]
  col.p <- c(brewer.pal(6,"Set1"))[1:2]
  my.cols<-c("ARACNe_null"="#000000","ARACNe"=brewer.pal(6,"Set1")[2],"RNI"=brewer.pal(6,"Set1")[3],"LSCO"=brewer.pal(6,"Set1")[5],"Glmnet"=brewer.pal(6,"Set1")[4])
  #my.cols<-c("#000000",col.g,col.p)
  
  #Normalize zeta
  aaa<-{(M1$zetavec[1:n]-min(M1$zetavec[1:n]))/(max(M1$zetavec[1:n])-min(M1$zetavec[1:n]))}
  bbb<-{(M1$zetavec[(n+1):(2*n)]-min(M1$zetavec[(n+1):(2*n)]))/(max(M1$zetavec[(n+1):(2*n)])-min(M1$zetavec[(n+1):(2*n)]))}
  ccc<-{(M1$zetavec[(2*n+1):(2*n+100)]-min(M1$zetavec[(2*n+1):(2*n+100)]))/(max(M1$zetavec[(2*n+1):(2*n+100)])-min(M1$zetavec[(2*n+1):(2*n+100)]))}
  ddd<-{(M1$zetavec[(2*n+101):(3*n+100)]-min(M1$zetavec[(2*n+101):(3*n+100)]))/(max(M1$zetavec[(2*n+101):(3*n+100)])-min(M1$zetavec[(2*n+101):(3*n+100)]))}
  M1$zeta<-c(aaa,bbb,ccc,ddd)
  # M1$method<-as.factor(c(M1$method))
  # M1$method = factor(M1$method, levels = levels(M1$method)[c(1,4,3,2)])
  #ROC
  M1$sen<-c(sort(M1$sen[1:(n)]),sort(M1$sen[(1+n):(2*n)]),sort(M1$sen[(1+2*n):(100+2*n)]),sort(M1$sen[(101+2*n):(101+3*n)]))
  M1$comspe<-c(sort(M1$comspe[1:(n)]),sort(M1$comspe[(1+n):(2*n)]),sort(M1$comspe[(1+2*n):(100+2*n)]),sort(M1$comspe[(101+2*n):(101+3*n)]))
  
  #null ARACNe MCC line
  #ARACNe data frame
  M2<-data.frame(M1$TP[(2*n+101):(3*n+100)])
  M2$TP<-M1$TP[(2*n+101):(3*n+100)]
  M2$FP<-M1$FP[(2*n+101):(3*n+100)]
  M2$TN<-M1$TN[(2*n+101):(3*n+100)]
  M2$FN<-M1$FN[(2*n+101):(3*n+100)]
  
  # M1$MCC<-c(sort(M1$MCC[1:(n)]),sort(M1$MCC[(1+n):(2*n)]),sort(M1$MCC[(1+2*n):(3*n)]),sort(M1$MCC[(1+3*n):(4*n)]))
  M1$nlinks<-c(sort(M1$nlinks[1:(n)]),sort(M1$nlinks[(1+n):(2*n)],decreasing=TRUE),sort(M1$nlinks[(1+2*n):(100+2*n)],decreasing=TRUE),sort(M1$nlinks[(101+2*n):(101+3*n)],decreasing=TRUE))
  M1$TP<-c(sort(M1$TP[1:(n)],decreasing=TRUE),sort(M1$TP[(1+n):(2*n)],decreasing=TRUE),sort(M1$TP[(1+2*n):(100+2*n)],decreasing=TRUE),sort(M1$TP[(101+2*n):(101+3*n)],decreasing=TRUE))
  M1$FP<-c(sort(M1$FP[1:(n)]),sort(M1$FP[(1+n):(2*n)]),sort(M1$FP[(1+2*n):(100+2*n)]),sort(M1$FP[(101+2*n):(101+3*n)]))
  M1$TN<-c(sort(M1$TN[1:(n)],decreasing=TRUE),sort(M1$TN[(1+n):(2*n)],decreasing=TRUE),sort(M1$TN[(1+2*n):(100+2*n)],decreasing=TRUE),sort(M1$TN[(101+2*n):(101+3*n)],decreasing=TRUE))
  M1$FN<-c(sort(M1$FN[1:(n)]),sort(M1$FN[(1+n):(2*n)]),sort(M1$FN[(1+2*n):(100+2*n)]),sort(M1$FN[(101+2*n):(101+3*n)]))
  # 
  P1<-ggplot(data=M1,aes(x=comspe,y=sen,group=method))  + geom_line(aes(linetype=method,colour=method))+geom_point(aes(color=method)) +labs(fill="") + scale_colour_manual(values = my.cols) +xlab("FPR")+ylab("TPR") + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=T),linetype = guide_legend(reverse=T))
  
  #TP null line slope = lowest line
  q<-sum(M2$TP !=0)#m1<-(0-M2$TP[1])/(q-0)
  m1<-(M2$TP[q]-M2$TP[n-q])/(q)
  
  #TN null line slope = middle
  r<-sum(M2$TN !=0)#m2<-(M2$TN[length(M2$TN)]+M2$TP[length(M2$TP)])-(M2$TN[length(M2$TN)]+M2$TP[length(M2$TP)])/length(M2$TN)-(length(M2$TN))
  m2<-((M2$TP[q]+M2$TN[r])-(M2$TP[n-q])+M2$TN[n-r])/(n-(n-r))
  
  #FP null line slope = highest line
  s<-sum(M2$FP !=0)#m3<-(M2$TN[length(M2$TN)]-M2$TN[(length(M2$TN)-length(dd))])/(length(M2$TN)-(n-length(dd)))
  m3<-((M2$TP[q]+M2$TN[n]+M2$FP[s])-(M2$TP[n-q]+M2$TN[n-r]+M2$FP[n-s]))/(s)
  
  #FN null line slope = highest line
  t<-sum(M2$FN !=0)#m4<-(M2$TN[length(M2$TN)]-M2$TN[(length(M2$TN)-length(dd))])/(length(M2$TN)-(n-length(dd)))
  m4<-((M2$TP[q]+M2$TN[n]+M2$FP[s]+M2$FN[n])-(M2$TP[n-q]+M2$TN[n-r]+M2$FP[n-s]+M2$FN[n-t]))/(t-(n-t))
  
  P2<-ggplot(data=M1,aes(x=zetavec,y=MCC,group=(M1$method))) + geom_line(aes(linetype=M1$method,colour=M1$method))+geom_point(aes(color=M1$method)) + scale_colour_manual(values = (my.cols))+ylim(-1,1) +xlab("Zetavec") + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F)) 
  
  #Sparsity
  P3<-ggplot(data=M1,aes(x=M1$zetavec,y=1-(nlinks/(n)),group=method))  + geom_line(aes(linetype=M1$method,colour=M1$method))+geom_point(aes(color=M1$method)) + scale_colour_manual(values = my.cols)+xlab("Zetavec")+ylab("Sparsity") + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F))
  
  #normalized link call plot x 4 methods
  #M2<-data.frame(c(M1$TP[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$TN[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$FP[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$FN[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))]))
  #M2<-data.frame(c(M1$TP[seq(1,(length(M1$TP)),nn)],M1$FP[seq(1,(length(M1$TP)),nn)],M1$TN[seq(1,(length(M1$TP)),nn)],M1$FN[seq(1,(length(M1$TP)),nn)]))
  #M2$method<-rep(1:((3*nn+1)))
  #M2$type<-c(rep("TP",each=3*nn+1),rep("TN",each=3*nn+1),rep("FP",each=3*nn+1),rep("FN",each=3*nn+1))
  
  if (nrow(M1)==400) {
    M3<-data.frame(rep(1:((4*nn)*4)))
    M3$data<-(c(M1$TP,M1$FP,M1$TN,M1$FN))
    M3$method<-rep(1:((4*nn)))
    M3$link<-c(rep("TP",each=4*nn),rep("TN",each=4*nn),rep("FP",each=4*nn),rep("FN",each=4*nn))
    P4<-ggplot(data=M3, aes(x=method,y=M3$data,group=link,fill=link)) + geom_area()+xlab("RNI    LSCO    Glmnet    ARACNe")+ylab("predicted link count") +labs(fill="") + theme(legend.direction="horizontal",axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.text.y=element_blank())+guides(fill = guide_legend(reverse=TRUE))
   }# else{
  #   if (nrow(M1)==7600) {
  #     M3<-data.frame(rep(1:((4*nn*7))))
  #     M3$data<-(c(M1$TP[c(seq(1,(2*(length(M1$TP)-100)/3),100),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),100))],M1$FP[c(seq(1,(2*(length(M1$TP)-100)/3),100),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),100))],M1$TN[c(seq(1,(2*(length(M1$TP)-100)/3),100),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),100))],M1$FN[c(seq(1,(2*(length(M1$TP)-100)/3),100),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),100))]))
  #     M3$method<-rep(1:((4*nn)))
  #     M3$link<-c(rep("TP",each=4*nn),rep("TN",each=4*nn),rep("FP",each=4*nn),rep("FN",each=4*nn))
  #     P4<-ggplot(data=M3, aes(x=method,y=M3$data,group=link,fill=link)) + geom_area()+xlab("RNI    LSCO    Glmnet    ARACNe")+ylab("predicted link count") +labs(fill="") + theme(legend.direction="horizontal",axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.text.y=element_blank())+guides(fill = guide_legend(reverse=TRUE))
  #   }
  else{
    M3<-data.frame(rep(1:((4*100)*4)))
    M3$data<-(c(M1$TP[c(seq(1,(2*(length(M1$TP)-100)/3),nn),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),nn))],M1$FP[c(seq(1,(2*(length(M1$TP)-100)/3),nn),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),nn))],M1$TN[c(seq(1,(2*(length(M1$TP)-100)/3),nn),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),nn))],M1$FN[c(seq(1,(2*(length(M1$TP)-100)/3),nn),(1+(2*(length(M1$TP)-100)/3)):(100+(2*(length(M1$TP)-100)/3)),seq((101+(2*(length(M1$TP)-100)/3)),(length(M1$TP)),nn))]))
    M3$method<-rep(1:((4*100)))
    M3$link<-c(rep("TP",each=4*100),rep("TN",each=4*100),rep("FP",each=4*100),rep("FN",each=4*100))
    P4<-ggplot(data=M3, aes(x=method,y=M3$data,group=link,fill=link)) + geom_area()+xlab("RNI    LSCO    Glmnet    ARACNe")+ylab("predicted link count") +labs(fill="") + theme(legend.direction="horizontal",axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.text.y=element_blank())+guides(fill = guide_legend(reverse=TRUE))
  }
  
  #M4$TTP[x]<-sqrt(M4$TP[x]^2 - (x))
  #multiplot(P1, P2, P3, cols=2)
  #grid.text(n1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
  
  tit<-str_replace_all(n1, "_" , "\ ")
  title <- ggdraw() + draw_label(tit); print(i)
  prow <-plot_grid(P1+ theme(legend.position="none")+geom_abline(intercept=0,slope=1)+geom_abline(intercept=0,slope=max(M1$sen[(2*n+101):(3*n+100)])),P2 + theme(legend.position="none")+geom_hline(yintercept = 0),P3 + theme(legend.position="none"),P4 + theme(legend.position="none")+geom_vline(xintercept = c(100,200,300)),labels=c("A","B","C","D"),ncol=2)
  legend<-get_legend(P2)
  legend2<-get_legend(P4)
  print(plot_grid(title, prow,legend,legend2, ncol=1, rel_heights=c(0.1, 1,0.1)))
  rm(list= ls()[!(ls() %in% c('filenames','ldf_1'))])
  dev.off()}
