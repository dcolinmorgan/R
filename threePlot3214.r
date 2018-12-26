setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_151216_nodiag/andreas/3214")
library(RColorBrewer)
require(ggplot2)
library(gridExtra)
library(cowplot)
library(stringr)
library(scales)
filenames<-list.files(pattern = "*.csv")
ldf_1 <- lapply(filenames, read.csv, header=TRUE)
setwd("~/Dropbox/SciLifeLab/PROJECTS/andreas_projects/genespider-paper/data/GS_fig_151216_nodiag/finalFIG")

for (i in 1:length(ldf_1)){
  
  M1<-data.frame(ldf_1[i])
  M1$method =ordered(M1$method,levels=c('Glmnet','lsco','RNI','ARACNe'));
  levels(M1$method)[2]='LSCO'
  levels(M1$method)[3]='RNICO'
  
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4);n1<-paste("Case",n1,"IAA",sep="_")
  # set up the plot
  plotname<-paste(n1,"png",sep=".")
  png(plotname,width=8.5, height=11,units="in",pointsize=12,res=200)#(plotname,8.5,11)
  #par(mfrow=c(2,2))
  
  col.g <- c(brewer.pal(6,"Set1"))[4:5]
  col.p <- c(brewer.pal(6,"Set1"))[1:2]
  my.cols<-c("null model ARACNe"="#cccccc","ARACNe"=brewer.pal(6,"Set1")[2],"RNICO"=brewer.pal(6,"Set1")[3],"LSCO"=brewer.pal(6,"Set1")[5],"Glmnet"=brewer.pal(6,"Set1")[4])
  #my.cols<-c("#000000",col.g,col.p)
  
  #Normalize zetavec
  dd=table(M1$method)
  ccc<-((M1$zetavec[1:(dd[1]+dd[2]+dd[3])]))
  ddd<-((M1$zetavec[(dd[1]+dd[2]+dd[3]+1):length(M1$zetavec)])-min((M1$zetavec[(dd[1]+dd[2]+dd[3]+1):length(M1$zetavec)])))/(max((M1$zetavec[(dd[1]+dd[2]+dd[3]+1):length(M1$zetavec)]))-min((M1$zetavec[(dd[1]+dd[2]+dd[3]+1):length(M1$zetavec)])))
  M1$zeta<-c(ccc,ddd)
  #M1$MEE<-M1$MCC[(dd[2]+dd[1]):(dd[3]+dd[2]+dd[1])]
  
  #sort for area plot
  M1$nlinks<-c(sort(M1$nlinks[1:(dd[1])],decreasing=TRUE),sort(M1$nlinks[(dd[1]+1):(dd[2]+dd[1])],decreasing=TRUE),sort(M1$nlinks[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])],decreasing=TRUE),sort(M1$nlinks[(dd[2]+dd[3]+dd[1]+1):length(M1$nlinks)],decreasing=TRUE))
  M1$TP<-c(sort(M1$TP[1:(dd[1])],decreasing=TRUE),sort(M1$TP[(dd[1]+1):(dd[2]+dd[1])],decreasing=TRUE),sort(M1$TP[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])],decreasing=TRUE),sort(M1$TP[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)],decreasing=TRUE))
  M1$FP<-c(sort(M1$FP[1:(dd[1])]),sort(M1$FP[(dd[1]+1):(dd[2]+dd[1])]),sort(M1$FP[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])]),sort(M1$FP[(dd[2]+dd[3]+dd[1]+1):length(M1$FP)]))
  M1$TN<-c(sort(M1$TN[1:(dd[1])],decreasing=TRUE),sort(M1$TN[(dd[1]+1):(dd[2]+dd[1])],decreasing=TRUE),sort(M1$TN[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])],decreasing=TRUE),sort(M1$TN[(dd[2]+dd[3]+dd[1]+1):length(M1$TN)],decreasing=TRUE))
  M1$FN<-c(sort(M1$FN[1:(dd[1])]),sort(M1$FN[(dd[1]+1):(dd[2]+dd[1])]),sort(M1$FN[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])]),sort(M1$FN[(dd[2]+dd[3]+dd[1]+1):length(M1$FN)]))
  
  #ROC
  M1$sen<-c(sort(M1$sen[1:(dd[1])]),sort(M1$sen[(dd[1]+1):(dd[2]+dd[1])]),sort(M1$sen[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])]),sort(M1$sen[(dd[2]+dd[3]+dd[1]+1):length(M1$sen)]))
  M1$comspe<-c(sort(M1$comspe[1:(dd[1])]),sort(M1$comspe[(dd[1]+1):(dd[2]+dd[1])]),sort(M1$comspe[(dd[2]+dd[1]+1):(dd[2]+dd[3]+dd[1])]),sort(M1$comspe[(dd[2]+dd[3]+dd[1]+1):length(M1$comspe)]))
  M1$method =ordered(M1$method,levels=c('Glmnet','LSCO','RNICO','ARACNe'));
  M1$Method =ordered(M1$method,levels=c('Glmnet','LSCO','RNICO','ARACNe'));
  nn<-dd[4]
  P1<-ggplot(data=M1,aes(x=comspe,y=sen,group=method))  + geom_line(aes(colour=method)) +geom_point(data=M1[c(seq(1,100,3),seq(101,length((M1$zetavec)),(length((M1$zetavec))/sqrt(nn)))),],aes(color=Method),size=.5) +labs(fill="") + scale_colour_manual(values = my.cols) +xlab("FPR")+ylab("TPR") + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F))
  
  # #ROC null aracne
  # M2<-data.frame(M1$TP[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)])
  # M2$TP<-(M1$TP[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)])
  # M2$FP<-(M1$FP[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)])
  # M2$TN<-(M1$TN[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)])
  # M2$FN<-(M1$FN[(dd[2]+dd[3]+dd[1]+1):length(M1$TP)])
  # 

  # #TP null line slope = lowest line
  # m1<-as.numeric((M2$TP[nn]-M2$TP[1])/nn)
  # #TN null line slope = middle
  # m2<-as.numeric((M2$TN[nn]-M2$TN[1])/nn)
  # #FP null line slope = highest line
  # m3<-as.numeric((M2$FP[nn]-M2$FP[1])/nn)
  # #FN null line slope = highest line
  # m4<-as.numeric((M2$FN[nn]-M2$FN[1])/nn)
  # 
  # #ARACNe null link calls
  # M5<-data.frame(1:nn)
  # ff<-sign(M1$MCC[(dd[1]+dd[2]+dd[3]+1):length(M1$MCC)])
  # for (x in 1:(nn)){
  #   #TP
  #   M2$y1[x]<- m1*x + (M2$TP[1])
  #   #TN
  #   M2$y2[x]<- m2*x + (M2$TP[1]+M2$TN[1])
  #   #FP
  #   M2$y3[x]<- m3*x + (M2$TP[1]+M2$TN[1]+M2$FP[1])
  #   #FN
  #   M2$y4[x]<- m4*x + (M2$TP[1]+M2$TN[1]+M2$FP[1]+M2$TN[1])
  #   M2$MCC[x]<- -(1+((M2$y1[x] * M2$y2[x]) - (M2$y3[x]* M2$y4[x]))/ sqrt((M2$y1[x]+M2$y3[x])*(M2$y1[x]+M2$y4[x])*(M2$y2[x]+M2$y3[x])*(M2$y2[x]+M2$y4[x])))
  # }
  # #MCC
  # M6<-data.frame(c(M1$MCC,M2$MCC[1:(length(M2$MCC))]))
  # M6$MCC<-(c(M1$MCC,M2$MCC[1:(length(M2$MCC))]))
  
  # M6<-data.frame(c(M1$MCC,M1$nullMCC[(dd[1]+dd[2]+dd[3]+1):length(M1$nullMCC)]))
  # M6$MCC<-c(M1$MCC,M1$nullMCC[(dd[1]+dd[2]+dd[3]+1):length(M1$nullMCC)])
  # M6$Method<-c(rep("Glmnet",each=dd[1]),rep("LSCO",each=dd[2]),rep("RNICO",each=dd[3]),rep("ARACNe",each=dd[4]),rep("null model ARACNe",each=dd[4]))
  # M6$Method =ordered(M6$Method,levels=c('Glmnet','LSCO','RNICO','ARACNe','null model ARACNe'));
  # M6$size= c(rep(.5,each=length(M1$MCC)),rep(0,each=(dd[4])))
  # M6$zeta<-c(M1$zeta,M1$zeta[(dd[1]+dd[2]+dd[3]+1):length(M1$zeta)])
  # P2<-ggplot(data=M6,aes(x=zeta,y=MCC,group=(Method))) + geom_line(data=M6[seq(1,length(M6),length(M6)/sqrt(nn))],aes(colour=Method))+geom_point(aes(color=Method,size=I(size)))+scale_colour_manual(values = (my.cols),name="") +ylim(-1,1) +xlab(~zeta) + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F))
  P2<-ggplot(data=M1,aes(x=zeta,y=MCC,group=(Method))) + geom_line(aes(colour=Method))+geom_point(data=M1[c(seq(1,100,3),seq(101,length((M1$zetavec)),(length((M1$zetavec))/sqrt(nn)))),],aes(color=Method),size=.5)+scale_colour_manual(values = (my.cols),name="") +ylim(-1,1) +xlab(~zeta) + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F))
  
  #Sparsity
  P3<-ggplot(data=M1,aes(x=zeta,y=1-(nlinks/nn),group=(Method)))  + geom_line(aes(colour=Method))+geom_point(data=M1[c(seq(1,100,3),seq(101,length((M1$zetavec)),(length((M1$zetavec))/sqrt(nn)))),],aes(color=Method),size=.5) + scale_colour_manual(values = my.cols)+xlab(~zeta)+ylab("Sparsity") + theme(legend.direction="horizontal") +guides(colour = guide_legend(reverse=F),linetype = guide_legend(reverse=F))
  
  #normalized link call plot x 4 methodsp
  #M2<-data.frame(c(M1$TP[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$TN[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$FP[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))],M1$FN[c(seq(1,(length(M1$TP)/2),nn),(1+length(M1$TP)/2):(100+length(M1$TP)/2),seq((101+length(M1$TP)/2),(length(M1$TP)),nn))]))
  #M2<-data.frame(c(M1$TP[seq(1,(length(M1$TP)),nn)],M1$FP[seq(1,(length(M1$TP)),nn)],M1$TN[seq(1,(length(M1$TP)),nn)],M1$FN[seq(1,(length(M1$TP)),nn)]))
  #M2$method<-rep(1:((3*nn+1)))
  #M2$type<-c(rep("TP",each=3*nn+1),rep("TN",each=3*nn+1),rep("FP",each=3*nn+1),rep("FN",each=3*nn+1))
  
  # if (nrow(M1)==392) {
    # M3<-data.frame(c(M1$TP,M1$FP,M1$TN,M1$FN))
    # M3$data<-(c(M1$TP,M1$FP,M1$TN,M1$FN))
    # M4$method<-rep(1:(length(M4$data)))
  #   M4<-data.frame(c(M1$TP[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))],M1$FN[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))],M1$FP[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))],M1$TN[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))]))
  #   M4$data<-(c(rev(M1$TP[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))]),rev(M1$FN[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))]),(M1$FP[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))]),(M1$TN[c(1:dd[1],seq(dd[1]+1,length(M1$method),(dd[2]/dd[1])))])))
  #   M4$method<-rep(1:(length(M4$data)/4))
  #   M4$link<-c(rep("TP",each=length(M4$method)/4),rep("FN",each=rep(length(M4$method)/4)),rep("FP",each=rep(length(M4$method)/4)),rep("TN",each=rep(length(M4$method)/4)))
  #   M4$link =ordered(M4$link,levels=c('TP','FN','FP','TN'));  #scale_y_continuous(labels=(function(x)x/max(x)))
  #   P4<-ggplot(data=M4, aes(x=method,y=(data),group=link,fill=link)) + geom_area()+xlab("Glmnet    LSCO    RNICO    ARACNe")+ylab("Fraction of all possible links")  + theme(legend.direction="horizontal")+scale_y_discrete(limits=c(0,(max(M1$FP)+max(M1$TP))*.25,max(max(M1$FP)+max(M1$TP))*.5,max(max(M1$FP)+max(M1$TP))*.75,max(max(M1$FP)+max(M1$TP))),labels=c("0","0.25","0.5","0.75","1"))  +scale_x_discrete(limits=c(0,50,100,150,200,250,300,350,400),labels=c("0","0.5","1 0","0.5","1 0","0.5","1 0","0.5","1 0"))+theme(legend.title=element_blank())#scale_x_continuous(labels=(function(x)(x/x) x[is.nan(x)]=0))
  # # }else{
  #   M3<-data.frame(rep(1:((4*100)*4)))
  #   M3$data<-(c((M1$TP[c(1:100,seq(101,(length(M1$TP)),nn))]),M1$FP[c(1:100,seq(101,(length(M1$TP)),nn))],M1$TN[c(1:100,seq(101,(length(M1$TP)),nn))],M1$FN[c(1:100,seq(101,(length(M1$TP)),nn))])) ^^,axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.text.y=element_blank())
  #   M3$method<-rep(1:((4*100)))
  #   M3$link<-c(rep("TP",each=4*100),rep("TN",each=4*100),rep("FP",each=4*100),rep("FN",each=4*100))
  #   P4<-ggplot(data=M3, aes(x=method,y=M3$data,group=link,fill=link)) + geom_area()+xlab("RNICO    LSCO    Glmnet    ARACNe")+ylab("predicted link count") +labs(fill="") + theme(legend.direction="horizontal",axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.text.y=element_blank())+guides(fill = guide_legend(reverse=TRUE))
  # }
  
  tit<-str_replace_all(n1, "_" , "\ ")
  title <- ggdraw() + draw_label(tit);print(i)
  # prow <-plot_grid(P1+ theme(legend.position="none")+geom_abline(intercept=0,slope=1)+geom_abline(intercept=0,slope=max(M1$sen[(dd[1]+dd[2]+dd[3]+1):(length(M1$sen))])),P2 + theme(legend.position="none")+geom_hline(yintercept = 0),P3 + theme(legend.position="none"),P4 + theme(legend.position="none")+geom_vline(xintercept = c(100,200,300)),labels=c("A","B","C","D"),ncol=2)
  prow <-plot_grid(P1+ theme(legend.position="none")+geom_abline(intercept=0,slope=1)+geom_abline(intercept=0,slope=max(M1$sen[(dd[1]+dd[2]+dd[3]+1):(length(M1$sen))]),color="#cccccc"),P2 + theme(legend.position="none")+geom_hline(yintercept = 0),P3 + theme(legend.position="none"),labels=c("A","B","C"),ncol=2)
  
  legend<-get_legend(P2)
  # legend2<-get_legend(P4)
  print(plot_grid(title, prow,legend,ncol=1, rel_heights=c(0.1, 1,0.1)))
  rm(list= ls()[!(ls() %in% c('filenames','ldf_1'))])
  dev.off()}
