

# "genes" is a vector including name of all genes in the experiment

# "responses" is a matrix which combines all data sets sequentially (including expression profiles of all genes under different conditions)

# "regressors" is a matrix which combines all data sets sequentially (including expression profiles of regulatory genes, known as transcription factors, under different conditions)

# "pr" is a matrix including the similarity between differential behavior of all genes and transcription factors


fused_lasso_GRN_inferrence <- function(pr, genes,responses,regressors,mc.preschedule=T,mc.set.seed=T,mc.cores=8,mc.cleanup=T)
{
  fits_penalized <- (mclapply(genes, function(i,res,reg){
    
    # the response y is set to the expression profile of gene i
    y<-as.numeric(res[i,]);
    
    # check if the selected gene is a transcription factor
    if (i %in% colnames(reg))
    {
      # the similarity between differential behavior of the gene i and all other regressors excluding gene i 
      ib<-diag(pr[i,-which(colnames(pr)==i)])
      
      # excluding the expression profile of gene i from the regressors
      x <-reg[,-which(colnames(reg)==i)];
      colnames(x) <-colnames(reg)[-which(colnames(reg)==i)]
    }
    else
    {
      # the similarity between differential behavior of the gene i and all other regressors 
      ib<-diag(pr[i,])
      
      # set x to the expression profile of regressors
      x <- reg;
      colnames(x) <-colnames(reg);
    }
    
    # call the fused Lasso regression in order to find the regulatory contribution of the regressors into the expression of gene i as response
    fit <- cv.lqa(y.train=y,x.train=x,penalty.family=fused.lasso,intercept=F,...=diag(ib),standardize=T,
                  lambda.candidates=list(c(0.05,0.1,0.5,1,1.5),c(0.1,0.5,1,1.5,2)),n.fold=10,loss.func="dev.loss",family=gaussian())
    
    return(fit);
    
  },responses,regressors,mc.preschedule=T,mc.set.seed=T,mc.cores=8,mc.cleanup=T))
  
  return(fits_penalized)
}


# fits_penalized <- (mclapply(genes, function(i,res,reg){
#   
#   # the response y is set to the expression profile of gene i
#   y<-as.numeric(res[i,]);
#   
#   # check if the selected gene is a transcription factor
#   if (i %in% colnames(reg))
#   {
#     # the similarity between differential behavior of the gene i and all other regressors excluding gene i 
#     ib<-diag(pr[i,-which(colnames(pr)==i)])
#     
#     # excluding the expression profile of gene i from the regressors
#     x <-reg[,-which(colnames(reg)==i)];
#     colnames(x) <-colnames(reg)[-which(colnames(reg)==i)]
#   }
#   else
#   {
#     # the similarity between differential behavior of the gene i and all other regressors 
#     ib<-diag(pr[i,])
#     
#     # set x to the expression profile of regressors
#     x <- reg;
#     colnames(x) <-colnames(reg);
#   }
#   
#   # call the fused Lasso regression in order to find the regulatory contribution of the regressors into the expression of gene i as response
#   fit <- cv.lqa(y.train=y,x.train=x,penalty.family=fused.lasso,intercept=F,...=diag(ib),standardize=T,
#                 lambda.candidates=list(c(0.05,0.1,0.5,1,1.5),c(0.1,0.5,1,1.5,2)),n.fold=10,loss.func="dev.loss",family=gaussian())
#   
#   return(fit);
#   
# },responses,regressors,mc.preschedule=T,mc.set.seed=T,mc.cores=8,mc.cleanup=T))
# 
