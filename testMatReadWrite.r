library("rjson")
setwd("~/lib/matR")
json_data <- fromJSON(file="Tjarnberg-ID969708-D20151111-N10-E30-SNR10-IDY969708.json")

Aest=data.frame(json_data$obj_data$P)*data.frame(json_data$obj_data$Y)

write.table(Aest,"~/lib/matR/Rout.csv",sep = ",")
