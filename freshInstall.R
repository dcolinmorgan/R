#create a function to check for installed packages and install them if they are not installed
install <- function(packages){
  new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(new.packages)) 
    install.packages(new.packages, dependencies = TRUE,lib="/anaconda3/lib/R/library")
  sapply(packages, require, character.only = TRUE)
}

# usage
required.packages <- c("ggplot2", "dplyr", "reshape2", "devtools", "shiny", "shinydashboard", "caret","igraph","randomForest","gbm","tm","forecast","knitr","Rcpp","stringr","lubridate","manipulate","Scale","sqldf","RMongo","foreign","googleVis","XML","roxygen2","parallel","car","igraph","plyr","rcytoscapejs","networkD3","network","reshape2","intergraph","plotly")
install(required.packages)

# required.packages <- c("Rcpp","httpuv","mime","jsonlite","digest","htmltools","xtable","R6","Cairo","shiny")
# install(required.packages)