library(ggplot2);library(readr);library(plotly);
# setwd("/afs/pdc.kth.se/home/d/dmorgan/Volume1/Documents/nestBoot_MYC/bestP_PE")
setwd("~/Dropbox/")#SciLifeLab/PROJECTS/nestBoot_MYC/best")
temp = list.files(pattern="*.csv")
for (i in 1:length(temp)) assign(temp[i], read_delim(temp[i],",", escape_double = FALSE, trim_ws = TRUE))

# N23<-rbind(MYCrss_best_24_May_2017_17_05_27.csv,MYCrss_best_26_May_2017_08_35_25.csv,MYCrss_best_26_May_2017_08_36_13.csv,MYCrss_best_26_May_2017_08_36_38.csv,MYCrss_best_26_May_2017_08_37_03.csv)
N23 <- read_csv("~/Dropbox/MYC_best.csv")
N23$SNET<-gsub("\\d", "", N23$NET)

N23$log_pred_wRSSY<-log10(N23$pred_wRSSY)

gg<-ggplot(N23,aes(x=log_pred_wRSSY)) + 
  geom_histogram(data=subset(N23,NET == 'indegreeRandomFit'),fill = "black", alpha = 0.2, breaks=seq(0, 20, by=.05)) +
  geom_histogram(data=subset(N23,NET == 'complimentRandomFit'),fill = "grey", alpha = 0.2, breaks=seq(0, 20, by=.05)) +
  geom_histogram(data=subset(N23,NET == 'FITBolasso'),fill = "green", alpha = 0.2, breaks=seq(0, 20, by=.05)) +
  geom_histogram(data=subset(N23,NET == 'FITBolsco'),fill = "red", alpha = 0.2, breaks=seq(0, 20, by=.05)) +
  geom_histogram(data=subset(N23,NET == 'FITBotlsco'),fill = "blue", alpha = 0.2, breaks=seq(0, 20, by=.05))

# gg<- gg +scale_x_log10(x=N23$pred_wRSSY)

  # + geom_histogram(data=subset(N23,'#NET' == 'Bolasso'),fill = "orange", alpha = 0.2,breaks=seq(5000, 1000000, by=10000))
ww<-plotly_build(gg)
ww %>%layout(title="zoom Pred.Error inferred MYC v random")

gg<-ggplot(data=N23,aes(x=wrssy,y=wrssynf,color=factor(NET)))+geom_point(shape=1) #+geom_smooth()#+facet_grid(.~method_f)+theme_bw()+ geom_boxplot()+scale_x_discrete(limits=c("High","Low"))
# gg<-plot_ly(N23,x=~wrssy,y=~wrssynf,type='scatter')%>%layout(xaxis = x, yaxis = y)
# gg + labs(title = "Observed v Expected inferred MYC v random", y = "Expected", x = "Observed", color = "NET(source)")
gg


ww %>%layout(title="Observed v Expected inferred MYC v random")


# ww<-gg + ggtitle("Observed v Expected inferred MYC v random")+ guides(size=FALSE)
Sys.setenv("plotly_username"="dcolinmorgan")
Sys.setenv("plotly_api_key"="lqg9C8LlefC3OrL4MQME")
api_create(ww, filename = "plot_MYCcomp")


hh<-ggplot(data=N23,aes(x=factor(NET),y=Pred.Error))+geom_violin() #+geom_smooth()#+facet_grid(.~method_f)+theme_bw()+ geom_boxplot()+scale_x_discrete(limits=c("High","Low"))
xx<-plotly_build(hh)
xx %>%layout(title="Prediction Error per method")
