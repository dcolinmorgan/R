library(readr)
library(poweRlaw)
cells<- read_csv("~/Downloads/L1000_jaccard - Sheet9.csv")
aa<-cells$PC3
aa <- aa[!is.na(aa)]
aa<-log10(aa)
aa <- aa[0!=(aa)]

m_bl = conpl$new((aa))
est = estimate_xmin(m_bl)
m_bl$setXmin(est)

plot(m_bl,main="PC3 degree frequency distribution",xlab="out-degree (log10)", ylab="frequency (log)")

lines(m_bl, col=2, lwd=2)

m_bl_ln = conlnorm$new(aa)
est2 = estimate_xmin(m_bl_ln)
m_bl_ln$setXmin(est2)

# lines(m_bl_ln, col=3, lwd=2)
# zz=eval(round(m_bl$pars,2))
text(.5,0.1,bquote(P(k)==k^-.(round(m_bl_ln$xmin,2))),col="red")

# text(1,0.1,paste("P(k)=k^",round(m_bl$pars,2)),col="green")
# text(1,0.01,paste("discrete log-normal fit=",round(m_bl_ln$pars,2)[1],"+",round(m_bl_ln$pars,2)[2]),col="red")
