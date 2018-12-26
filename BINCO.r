#############################################################
###### 04-11-2012: R package "BINCO"
###### R functions for U-shape detection and density fitting
#############################################################



################################################################################
####################### function for users #####################################
################################################################################


####################################################
####### 1. BINCO procedure #########################
####################################################

BINCO<-function(count.mix=NULL, freq.m=NULL, nb=NULL, FDR=0.05, vpr=0.8, conservative=F, niv=3, ini.bound=c(10,10,20))
{
# count.mix is a vector of non-negative integers as the counts of edges of 
# different selection frequencies. Its length is the number of (bootstrap) 
# resamples from which is was generated. For example, if the second entry is 50 
# then it means 50 edges/variables are selected exactly twice while applying the 
# original procedure on all resamples. The last entry is the number of 
# edges/variables that are selected consistently while applying the original 
# procedure on all resamples.
                    
# freq.m is a matrix recording the selection frequencies of all edges, e.g.,
# freq.m[i,j] is the selection frequency of the edge connecting nodes i and j. 
# It must be provided if count.mix is not.
                  
# nb is a positive integer as the number of (bootstrap) resmaples used to generate
# count.mix of freq.m. It must be provided along with freq.m if count.mix is not
# provided.
              
# FDR is a numeric value between 0 and 1, the desired control level for the false
# discovery rate. Default is 0.05.
                
# vpr is a numeric value between 0.8 and 0.95, as the rule for the "valley point"
# of the empirical distribution (see Li, et al.,2012). Default value is 0.8. 
# Large valley point values may result in liberal selection.
                
# conservative is a logic value of TRUE or FALSE. Default is FALSE. Set 
# conservative=TRUE if a conservative selection is needed (i.e., when the FDR 
# control needs to be stringent). We recommand to apply \code{BINCO} under the 
# consertive mode for the data where its "valley point" value is large. 
                      
# niv is a positive integer as the number of sets of initial parameter values to
# be used for density fitting. Default is 3, and 10 is large enough for most 
# usual situations.
               
# ini.bound is a vector of three positive real numbers. It gives the upper bound
# of randomly generated initial parameter values used for density fitting. Defualt
# value is (10,10,20).

#### check input
if(is.null(count.mix)|(!is.vector(count.mix)))
{
if (is.matrix(count.mix))
{
freq.m<-count.mix
}
if(is.null(freq.m)|is.null(nb))
{
stop("'count.mix' is NULL, both 'freq.m' and 'nb' need to be specified")
}
else
{
count.mix=freq_to_count(freq.m,nb)
}
}

nb<-length(count.mix)
diagnosis.v<-u_shape_test(count.mix=count.mix,vpr=vpr)
diagnosis=diagnosis.v[1]
vp=diagnosis.v[2]
mu=diagnosis.v[3]

#### check for u-shape
if (diagnosis!=0)
{
print("The empirical density is not u-shaped, BINCO will not apply.")
suggestion="try to change settings to generate u-shaped empirical density of selection frequencies."
if (diagnosis==1&vp<=0.95)
{
suggestion=paste("current valley point value is", vp, ", try a larger vpr.")
}
stop(suggestion)
}

##### fit the null
fit<-null.estimate(count.mix=count.mix,mu=mu,vp=vp,niv=niv,mod=conservative)
fit.count.null<-fit[[1]] # estimate null  
r<-fit[[2]] # lower bound of the fitting range

est.power<-rep(0,nb) # estimated power for each cutoff of the selection proportion
est.fdr<-rep(1,nb) # the estimated FDR

if (conservative) #conservative estimate for the null at the tail 
{
VP=vp*nb
fit.count.null[VP:nb]=fit.count.null[VP]
}

for (j in r:nb)
{
est.power[j]<-(sum(count.mix[j:nb])-sum(fit.count.null[j:nb])) 
est.fdr[j]<-sum(fit.count.null[j:nb])/sum(count.mix[j:nb])
}

if (min(est.fdr)>FDR) #if no cutoff gives FDR less than the desired level, give 
                      #the most close one. 
{
index1=which(est.fdr==min(est.fdr))
index2=min(index1)
print("Note: the FDR can not be controlled at the desired level for current input data")
}
else # find the optimal cutoff
{
index1<-which(est.fdr<FDR)
index2<-min(index1[index1>r])
}

#### result summary
result=list(index2/nb, est.fdr[index2],round(est.power[index2]),c(r/nb,vp), count.mix, fit.count.null)
names(result)=c('cut_off', "estimated_FDR", "estimated_power", "fitting_range", "empirical_mix", "estimated_null")
return(result)
}

#####################################################
###### 2. check the null estimate by plot ###########
#####################################################

BINCO.plot<-function(out.BINCO,show.range=NULL,show.cutoff=TRUE,...)
{
#### this function provides an overlay plot of the empirical mixture distribution of selection frequencies and the null distribution estimated by BINCO
#### out.BINCO is the outcome retured from BINCO function.
#### show.range is a vector of length=2, which defines the display range of the overlay plot. We recommand that the lower bound of this range should be greater than the lower bound of the fitting range used by BINCO.
#### show.cutoff determines whether a vertical line will be drawn at the valley point value calculated by BINCO

count.mix<-out.BINCO[[5]]
fit.count.null<-out.BINCO[[6]]
if (is.null(show.range))
{
show.range<-c(out.BINCO[[4]][1],1)
}
nb=length(count.mix)  
x.min<-show.range[1]*nb
x.max<-show.range[2]*nb
plot((x.min:x.max)/nb,count.mix[x.min:x.max],xlab="selection frequency", ylab="count of variables", main="Check the Fit (solid curve)",...)
lines((x.min:x.max)/nb,fit.count.null[x.min:x.max])
if ((show.cutoff))
{
cutoff<-out.BINCO[[1]]
abline(v=cutoff)
txt<-paste("BINCO cutoff=",cutoff,sep="")
x<-cutoff-0.1
y<-max(count.mix[x.min:x.max])
text(x,y,txt,col=2)
}
}

###########################################################################
################## Internal functions #####################################
###########################################################################


########################################################################
####### 1. kernal of the convoluted powered beta +binomial density #####
########################################################################

##### n and k are the parameters for binomial density
##### a, b, r are the parameters for the powered beta

bio_beta_power<-function(n,k,a,b,r,x){
fac<-choose(n,k)*gamma(a+b)/(gamma(a)*gamma(b))
temp.1<-x^(a+r*k-1)
temp.2<-(1-x^r)^(n-k)
temp.3<-(1-x)^(b-1)
result<-fac*temp.1*temp.2*temp.3
return(result)
}

###############################################################
####### 2. numerical intergration of f(x=k/n) #################
###############################################################

##### n and k are the parameters for binomial density
##### a, b, r are the parameters for the powered beta

bio_beta_power_int<-function(n,k,a,b,r){
result<-integrate(f=bio_beta_power,lower=1e-6,upper=0.95,n=n,k=k,a=a,b=b,r=r)$value
return(result)
}

###############################################################
####### 3. score function for fitting evaluation ##############
###############################################################

score<-function(x.v, nb, emp.all, x.index)  #the smaller, the better
{
   mar.c<-try(apply(matrix(1:nb),1, bio_beta_power_int,n=nb,a=x.v[1],b=x.v[2], r=x.v[3]),silent=TRUE)
   err<-inherits(mar.c, "try-error")
   if(err)
     return(NA)
   fac.c<-sum(emp.all[x.index])/sum(mar.c[x.index])  # estimate null
   mar.s<-fac.c*mar.c
   score<-sum(-emp.all[x.index]*log(mar.s[x.index])) # negative log likelihood
   return(score)
  }

###############################################################
####### 4. find the index of the entry in a vector ############
#######    that is closest to some value c         ############
###############################################################

##### v is a vector, c is a real number 
pick.close<-function(v, c)
{
d<-abs(v-c)
pick.index<-which(d==min(d))
return(pick.index)
}

###############################################################
####### 5. number of sign changes of a curve  #################
###############################################################
NSC<-function(der.v)
{
s=0
n=length(der.v)-1
for (i in 1:n)
{
if (der.v[i]*der.v[i+1] < 0)
{s<-s+1}
}
return(s)
}

#############################################
##### 6. valley point calculation ###########
#############################################

#### To calculate the valley score position, we first fit a smooth curve for the 
#### impirical density of selection frequencies using the R function
#### smooth.spline(df), where the df is determined such that the number of sign
#### changes of the smooth curve is 1. The valley point is at the position of 
#### the lowest of the curve. 

valley.score<-function(count.mix) 
#count.mix is the empirical count vector of selection frequencies
{
nb=length(count.mix)
half=nb/2
max1<-max(count.mix[1:half])
mu<-max(which(count.mix[1:half]==max1)) # mu is the start position where the 
                                        # empirical density begins to decrease.

index.h<-c(max(mu,20):nb) # The edges counts with small selection frequency 
                          # might be too large and make the smooth line fitting
                          # unstable. Here we only use the data where the 
                          # selection frequencies are no less than 20.

nsc<-rep(0,20) #number of sign changes

for (i in 1:20)
{
d=i+2
f<-smooth.spline(count.mix[index.h],df=d)$y
nsc[i]=NSC(diff(f))
}

z<-pick.close(nsc,1)
d<-z[length(z)/2+1]+2 #the poper df

f<-smooth.spline(count.mix[index.h],df=d)$y
index.vp<-min(min(which(diff(f)>0)),length(f))
vp<-index.h[index.vp]/100 #valley point value
mu1<-mu/nb #the lower bound of the fitting range
return(c(vp,mu1))
}

#######################################
###### 7. u-shape detection ###########
#######################################

##### Check three criterion, 
##### 1: valley point < threshold?
##### 2: Decreasing at the beginning?
##### 3: increasing at the tail?

u_shape_test<-function(count.mix, vpr=0.8)
{
#count.mix is the empirical count vector of selection frequencies, vpr is the 
#pre-set threshold for the valley point value (default is 0.8).

diagnosis=0 # default value, indicating the empirical distribution is u-shaped
nb<-length(count.mix)
shape.rough<-valley.score(count.mix)
vp<-shape.rough[1] #valley point
mu1<-shape.rough[2] #start point of the "decreasing" region
if(vp>min(vpr,0.95)) #check 1
{
diagnosis=1
return(c(diagnosis,shape.rough))
break
} 

VP=vp*nb
MU1<-mu1*nb
half1<-(VP+MU1)/2
s1<-sum(count.mix[MU1:half1])
s2<-sum(count.mix[half1:VP])
if (s1<s2) #check 2
{
diagnosis=2
return(c(diagnosis,shape.rough))
break
}
 
half2=(VP+nb)/2
s3<-sum(count.mix[VP:half2])
s4<-sum(count.mix[half2:nb])
if (s3>s4) #check 3
{
diagnosis=3
return(c(diagnosis,shape.rough))
break
}

return(c(diagnosis,shape.rough))
}


#######################################
###### 8. estimate the null ###########
#######################################

##### count.mix is the empirical density to fit
##### vp is the valley point value 

null.estimate<-function(count.mix,mu,vp,niv,mod)
{
####count.mix is the empirical counts distribution for selection frequencies
#### mu is the where the empirical density starts to decrease
#### vp is the valley point value
#### niv is the number of sets of initial values for parameter fitting
#### mod = F if we want to be more sure on that BINCO provides conservative selection
 
nb=length(count.mix) #number of bootstraps
n.grid<-nb
x<-(1:n.grid)/n.grid
count.all<-count.mix
emp.all<-count.all/sum(count.all)
r.min=mu
if (vp>0.6|mod) # for not too small vp, too influential data (corresponding to extremely large counts at the beginning) is not used. 
{
VP=vp*nb
index<-which(count.mix[1:VP]> 20*(count.mix[VP]+1))
index<-max(index)
index<-min(20,index) #the fitting range should not be too narrow
r.min<-index/100
}
r.max=vp

x.index<-(x>=r.min)&(x<=r.max)
#fit.index<-(x>=0.5)   #use null counts from this range to evaluate the fit (not calculable in reality)

fitting_score=rep(0,niv)
fitting_parameter=matrix(0,niv,3)
try.condition=0
print("start fitting...")
for (i in 1:niv)
{
while (try.condition==0)
{
try=nlminb(c(runif(1)*10,runif(1)*10,runif(1)*20), score, lower=c(1.01,0.1,1.1), upper=c(20,Inf,Inf),nb=nb, emp.all=emp.all, x.index=x.index)
try.condition=(!is.na(try$objective))*(sum(try$par>c(1,0,0))==3)
}
fitting_score[i]=try$objective
fitting_parameter[i,]=try$par
try.condition=0
message=paste("done ",round(i*100/niv),"%...fitting score=",round(fitting_score[i],4),sep="")
print(message)
}
index.parameter=min(which(fitting_score==min(fitting_score)))
###estimated null:
mar.opt<-apply(matrix(1:nb),1, bio_beta_power_int,n=nb,a=fitting_parameter[index.parameter,1],b=fitting_parameter[index.parameter,2],r=fitting_parameter[index.parameter,3])
fac.opt<-sum(emp.all[x.index])/sum(mar.opt[x.index])
mar.opt.s<-mar.opt*fac.opt
fit<-mar.opt.s #fitted density for null
r=r.min*nb
c<-count.mix[r]/emp.all[r] #the constant ratio of the count over its density
fit.count.null<-fit*c
result=list(NULL)
result[[1]]=fit.count.null
result[[2]]=r
return(result)
}

##################################################################
######## 9. calculate count based on freq. matrix ################
##################################################################

freq_to_count<-function(freq.m, nb)
{
#### freq.m is a pxp matrix recording the selection frequencies for all edges, e.g., freq.m[i.j] is the selection frequency of the edge connecting nodes i and j.
#### nb is the number of resamples used to generate freq.m
count.mix<-rep(0,nb)
for (i in 1:nb)
{
count.mix[i]<- sum(freq.m==(i/nb))/2 
}
return(count.mix)
}


