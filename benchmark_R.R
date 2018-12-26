library("R.matlab");library("BINCO");library("rope");library(readr);
setwd("/media/radonn/7a9000fa-c6a6-4b42-832e-aa213d1101c5/dmorgan/DOWNLOADS/benchmark_R/data/")#Dropbox/SciLifeLab/PROJECTS/benchmark/R/test/")
temp = list.files(pattern="*.txt")

for (i in seq(from=1, to=length(temp), by=10)) { dataset <- read_delim(temp[i],"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)

  # exploregraph(unlist(dataset),3,3);
  data<-data.frame(unlist(dataset[1:45,]));
  data$P<-(unlist(dataset[1:45,]));data$Y<-unlist(dataset[46:90,]);data$E<-unlist(dataset[91:135,]);
  
  some_function_that_may_fail <- function(attempt) {
    out=BINCO(freq.m=data[2:3],nb=attempt)
    # try(writeLines(paste("\n Number of selected edges: ", sum(r$empirical_mix[pick]), "\n"," Estimated FDR: ", round(r$estimated_FDR, 3), "\n"," Estimated number of true edges: ", r$estimated_power, "\n")),TRUE)
    # try(write.csv(sum(r$empirical_mix[pick]),round(r$estimated_FDR, 3),r$estimated_power, "export.csv", row.names=FALSE, na="NA"))
      }
   r <- NULL
  attempt <- 50
  while( is.null(r) && attempt <= 125 ) {
    attempt <- attempt + 1
    try(
    r  <- some_function_that_may_fail(attempt)
        )
      } 
  nb=length(r$empirical_mix)
  r=BINCO(freq.m=data[2:3],nb=nb)
  pick=((1:nb)/nb)>=r$cut_off
  # BINCO.plot(r.BINCO=r)
  # dev.off()
  ggg=data.frame(r)
  write.table(c(temp[i],attempt,nb), '~/Dropbox/SciLifeLab/PROJECTS/benchmark/R/test.tsv'  , append= T, sep='\t' ,row.names=F,col.names=F)
  write.table(ggg, '~/Dropbox/SciLifeLab/PROJECTS/benchmark/R/test.tsv'  , append= T, sep='\t' ,row.names=F,col.names=T)
}

for (i in seq(from=1, to=length(temp), by=10)) { x <- read_delim(temp[attempt],"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
lambda <- seq(0.005, 0.5, 0.025)
B <- 100
n <- dim(x)[1]
p <- dim(x)[2]

W <- matrix(0, length(lambda), p*(p-1)/2)
for (i in 1:B) {
  bootstrap <- sample(n, n, replace=TRUE)
  for (j in 1:length(lambda)) {
    selection <- glasso::glasso(cov(x[bootstrap, ]), lambda[j])
    selection <- sign(abs(selection$wi) + t(abs(selection$wi)))
    selection <- selection[upper.tri(selection)]
    W[j, ] <- W[j, ] + selection
  }
}
result <- rope::explore(W, B)
}

some_function_that_may_fail <- function(attempt) {
  x <- read_delim(temp[attempt],"\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  lambda <- seq(0.005, 0.5, 0.025)
  B <- 100
  n <- dim(x)[1]
  p <- dim(x)[2]
  
  W <- matrix(0, length(lambda), p*(p-1)/2)
  for (i in 1:B) {
    bootstrap <- sample(n, n, replace=TRUE)
    for (j in 1:length(lambda)) {
      selection <- glasso::glasso(cov(x[bootstrap, ]), lambda[j])
      selection <- sign(abs(selection$wi) + t(abs(selection$wi)))
      selection <- selection[upper.tri(selection)]
      W[j, ] <- W[j, ] + selection
      result <- rope::explore(W, B)
    }
  }
  result <- rope::explore(W, B)
 }
r <- NULL
attempt <- 1
while( is.null(r) && attempt <= length(temp) ) {
  attempt <- attempt + 1
  try(
    r  <- some_function_that_may_fail(attempt)
  )
}
plot(result$pop.sep)