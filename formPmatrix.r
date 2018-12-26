exp_P_160408 <- read.csv("~/Dropbox/Sonnhammer_group/Data/GeneSPIDER/B.subtilis/exp_P_160408.csv", row.names=1)
exp_P_160406 <- read.csv("~/Dropbox/Sonnhammer_group/Data/GeneSPIDER/B.subtilis/exp_P_160406.csv", header=FALSE)
aa<-data.frame(exp_P_160408)
bb<-data.frame(exp_P_160406)

#index1<-pmatch(bb[,1],noquote(rownames(aa)),duplicates.ok = TRUE)
#exp_P_160408[index1,]
for (i in 1818){
for (j in 153){
  
    if(pmatch(bb[i,2],noquote(rownames(aa[j,]))) && 
       pmatch(bb[i,1],noquote(colnames(aa[i])))){
      
      zz[i,j]<- bb[i,3]
      }
    }
  }


