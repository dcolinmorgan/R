library(readr); library(reshape2);library(plyr);
data <- read_csv("~/Downloads/Survey 7%2F17 (Responses) - Sheet2.csv")
data2<-apply(data,2,function(x) as.numeric(as.factor(x)))
dd<-melt(data)

fit<- aov(value~Var2,data=dd)
fit2<- aov(value~Var2 + Var1,data=dd)

dd$Var2<-revalue(dd$Var2, c("POST_1"="POST","POST_2"="POST","POST_3"="POST","POST_4"="POST","PRE_1"="PRE","PRE_2"="PRE","PRE_3"="PRE","PRE_4"="PRE","PRE_5"="PRE","PRE_6"="PRE","PRE_7"="PRE","PRE_8"="PRE","PRE_9"="PRE","PRE_10"="PRE","PRE_11"="PRE","PRE_12"="PRE"))

t.test(dd$value~dd$Var2)

