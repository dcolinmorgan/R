library(readr)
library(plotly)
library(ggplot2)
#notFIT
DtoS <-read_csv('~/Dropbox/SciLifeLab/git/R/MYC_rss&spearman_inferred_midAugust.csv')
# DtoS <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/compRSS/SthenDsignMYCrss_bisect_15_Mar_2017_04_56_06.csv")
#FIT
# StoD <- read_csv("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/compRSS/SthenDsignMYCrss_ALLfit2_3-20_22_Mar_2017_03_24_42.csv")

DtoS$name<-sapply(strsplit(DtoS$`# sNET`, "_"), `[[`, 1)
DtoS$names<-sapply(strsplit(DtoS$name, "7"), `[[`, 1)
DtoS$namess<-sapply(strsplit(DtoS$names, "8"), `[[`, 1)
DtoS$namesss<-sapply(strsplit(DtoS$namess, "9"), `[[`, 1)
DtoS$namessss<-sapply(strsplit(DtoS$namesss, "J"), `[[`, 1)
DtoS$method<-sapply(strsplit(DtoS$namessss, "j"), `[[`, 1)

# StoD$name<-sapply(strsplit(StoD$`# SINGLES`, "_"), `[[`, 1)
ff <- function(x){ifelse(DtoS$name=='binaryrandom' | DtoS$name=='eyebinaryrandom' |DtoS$name=='randomFit'| DtoS$name=='signrandom'| DtoS$name=='eyesignrandom', .5, 1)}
# ee <- function(x){ifelse(StoD$name=='random' | StoD$name=='randomFit', .5, 1)}
# #FIT
# gg<-ggplot(data=StoD,aes(wrssY,wrssP,colour = factor(name),shape = factor(name)))+
#   scale_shape_manual(values=1:18) +
#   # facet_grid(.~method)+theme_bw()+
#   # geom_boxplot()+
#   geom_point(aes(size =ee(StoD$name))) +scale_x_continuous(limits = c(500, 2000))+scale_y_continuous(limits = c(500, 2000))
# gg + ggtitle("fit ALL networks to singles, optimize against doubles")+ guides(size=FALSE)
#notFIT
library(plotly)
cc<-ggplot(data=DtoS,aes(wrssY,minDist,colour = factor(method),shape = factor(method)))+
  # facet_grid(.~method)+theme_bw()+
  # geom_boxplot()+
  scale_shape_manual(values=1:32) +
  geom_point(aes(size = ff(DtoS$method))) #+scale_x_continuous(limits = c(500, 2000))+scale_y_continuous(limits = c(500, 2000))
plotly_build(cc)
ww<-cc + ggtitle("add identity, re-fit all to singles data, balance error via doubles")+ guides(size=FALSE)
Sys.setenv("plotly_username"="dcolinmorgan")
Sys.setenv("plotly_api_key"="lqg9C8LlefC3OrL4MQME")
plotly_POST(ww, filename = "minIndegree_bisect_plot")
