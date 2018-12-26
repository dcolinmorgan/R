library(readr); library(ggplot2);library(plotly);
DtoS <-read_csv('~/Dropbox/SciLifeLab/git/R/MYC_rss&spearman_inferred - end.csv')
cc<-DtoS
cc$strata = do.call(c,sapply(cc$sNET,function(x)gregexpr("FIT",x)))

for (i in 1:dim(cc)[1]){
  if (cc$strata[i]==1){
    cc$ss[i]<-'MEASURED LINKS'
    }
  else{
    cc$ss[i]<-'SHUFFLED LINKS'
    }
}
bb<-data.frame(cc$`WRSS (obs-pred)`[1:200])
bb$x<-(cc$`WRSS (obs-pred)`[1:200])
bb$strata<-cc$ss[1:200]

bb$y[1]=bb$x[1]
for (i in 2:200){
  bb$y[i]=bb$y[i-1] + bb$x[i]
}
zz<-cc[order(cc$`WRSS (obs-pred)`),]

zz$z<-c(1:431)
zz$zzz<-c((1:431)/431)

p1<-ggplot(zz, aes(x=(zz$`WRSS (obs-pred)`), colour = ss,fill=ss))+
  geom_point(aes(x = log10(zz$`WRSS (obs-pred)`),y=log10(zzz),colour=ss))


main<-ggplot(zz)+  geom_point(aes(x = log10(zz$`WRSS (obs-pred)`),y=log10(zzz),colour=ss))+ theme_bw() +
  labs(x=" ",y="", subtitle=" ") + guides(colour=FALSE) +  scale_color_manual(values=c("blue1","red1"))

sub<- main + geom_rect(data=zz[1:431,],xmin=3.5, ymin=0, xmax=5, ymax=.2, fill="grey", alpha=.5) + theme_bw() + theme(panel.grid.minor.y = element_blank(), panel.grid.major.y = element_blank(),panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank())
sub$layers <- rev(sub$layers) # draw rect below

p1 + annotation_custom(ggplotGrob(sub), xmin=3.5, xmax=4.25, ymin=-1, ymax=.0) +theme_bw() +  scale_color_manual(values=c("blue1","red1")) + 
  scale_x_continuous(limits=c(3.5, 5)) + 
  scale_y_continuous(limits=c(-3,0)) + theme(legend.title=element_blank(),text=element_text(size=15),legend.position=c(.5,.3),panel.grid.minor.y = element_blank(), panel.grid.major.y = element_blank(),panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank()) +
  labs(x="log wRSS(obs-pred)",y="log wRSS", title="", subtitle=" ")


# 
# plotly_build(p)
# 
# 
# x = cc$`WRSS(Yobs-Ypred) LOO`[cc$`WRSS(Yobs-Ypred) LOO` <(summary(cc$`WRSS(Yobs-Ypred) LOO`)[5])]
# y = cc$`WRSS(Pobs-Ppred) LOO`[cc$`WRSS(Yobs-Ypred) LOO` <(summary(cc$`WRSS(Yobs-Ypred) LOO`)[5])]
# # s = cc$`ss`[cc$`WRSS(Yobs-Ypred) LOO` <(summary(cc$`WRSS(Yobs)`)[5])]
# # sss = cc$`strata`[cc$`WRSS(Yobs)` <(summary(cc$`WRSS(Yobs)`)[5])]
# p11<-ggplot(cc[1:429,],aes(log10(x), log10(y)))+ geom_point(aes(colour = factor(ss)))+ labs(x="WRSS(Yobs)",y="WRSS(Pobs)", subtitle="Inferred v Random Performance")
# 
# sub <- p11 + geom_rect(data=cc[1:429,],xmin=4, ymin=3, xmax=8, ymax=5, fill="blue", alpha=0.5)
# sub$layers <- rev(sub$layers) # draw rect below
# 
# p11 + annotation_custom(ggplotGrob(sub), xmin=4, xmax=8, ymin=3, ymax=5) +
#   scale_x_continuous(limits=c(4, 8)) + scale_y_continuous(limits=c(5,8)) + labs(x="WRSS of prediction of Y",y="Y pred for LOO", title="Zoomed view of")
