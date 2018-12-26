library(GGally)
library(network)
library(sna)
library(ggplot2)
#library(igraph)
#library(networkD3)

setwd("~/Dropbox/SciLifeLab/PROJECTS/nestBoot_MYC/cytoscape_net/")
filenames<-list.files(pattern = "*.csv") #TSV
ldf <- lapply(filenames, read.csv, header=FALSE) #TSV push edited cytoscape csv output

for (i in 1:length(ldf)){
  
  M1<-data.frame(ldf[i])
  network(M1[1:2],directed=TRUE)
  n1<-substr(filenames[i], 1, nchar(filenames[i])-4)
  cc<-ggnet2(M1[1:2],size = "degree",label=TRUE,arrow.size = 10)#,edge.color="sign")
  #D3_network_LM<- simpleNetwork(data.frame(c(M1[1]),c(M1[2])))
  #D3_network_LM <- networkD3::forceNetwork(Links = M1[1], Nodes = M1[2])#,height = 500, width = 1000,fontSize = 20, linkDistance = networkD3::JS("function(d) { return 10*d.value; }"),linkWidth = networkD3::JS("function(d) { return d.value/5; }"),opacity = 0.85,zoom = TRUE, opacityNoHover = 0.1)
  
  #networkD3::saveNetwork(D3_network_LM, "D3_LM.html", selfcontained = TRUE)
}