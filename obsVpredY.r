
scatterSpet17<-read_csv('~/Dropbox/Sonnhammer_group/Data/SCATTERobsVPREDy.csv',col_names = FALSE)

ggplot(scatterSpet17,aes(x=scatterSpet17$X1,scatterSpet17$X2,color=scatterSpet17$X3))+ geom_point(shape=1,position=position_jitter(width=1,height=.5))+ scale_color_manual(values=c("orange","blue2"))+ labs(x="Observed Doubles' Y",y="mean or predicted Y", title="Observed v Predicted Performance")+theme_bw()+ theme(legend.title=element_blank())+
  geom_smooth(method=lm,   # Add linear regression lines
              se=TRUE,    # Don't add shaded confidence region
              fullrange=TRUE,color="red2") +scale_x_continuous(limits = c(-4, 4))+scale_y_continuous(limits = c(-4, 4))+
  annotate("text", x=-3, y=2, label= "Spearman=0.323",color="red2")
  # annotate("text", x=-10, y=4, label= "Spearman=0.306",color="blue2")




