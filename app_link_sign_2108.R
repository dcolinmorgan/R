#### Load necessary packages and data ####
library(shiny)
library(networkD3)
library(network)
library(intergraph)
library(igraph)

#setwd("~/Dropbox/SciLifeLab/git/R/GSnetApp/")
load("lassodataBSUB2016-12-07full.rdata")
load("lassodataMYC2016-12-07full.rdata")
load("lscodataBSUB2016-12-07full.rdata")
load("lscodataMYC2016-12-07full.rdata")
load("tlscodataBSUB2016-12-07full.rdata")
load("tlscodataMYC2016-12-07full.rdata")

ddd<-list(lassodataMYC=lassodataMYC,lscodataMYC=lscodataMYC,tlscodataMYC=tlscodataMYC,lassodataBSUB=lassodataBSUB,lscodataBSUB=lscodataBSUB,tlscodataBSUB)
fff<-list(lassonameMYC=lassonameMYC,lsconameMYC=lsconameMYC,tlsconameMYC=tlsconameMYC,lassonameBSUB=lassonameBSUB,lsconameBSUB=lsconameBSUB,tlsconameBSUB)

#### Server ####
server <- function(input, output) {
    output$simplelassoMYC <- renderSimpleNetwork({
      wee<-paste(input$method,"data",input$data,sep="")
    datum<-ddd[[wee]]
    simpleNetwork(data.frame(lapply(datum[input$sparsity], "[", 2),lapply(datum[input$sparsity], "[", 1)))#,input=input$sparsity)
  })


  output$forcelasso <- renderForceNetwork({
    wee<-paste(input$method,"data",input$data,sep="")
    datum<-ddd[[wee]]
    
    edgeList<-datum[[input$sparsity]][1:6]
    colnames(edgeList) <- c("SourceName", "TargetName","Link","Link2","Sign", "Weight")
    
    gD<-simplify(graph.data.frame(edgeList,directed=TRUE))
    nodeList <- data.frame(ID = c(0:(igraph::vcount(gD) - 1)),nName = igraph::V(gD)$name)
    getNodeID <- function(x){which(x == igraph::V(gD)$name) - 1}
    
    edgeList <- plyr::ddply(edgeList, .variables = c("SourceName", "TargetName", "Weight"), 
                            function (x) data.frame(SourceID = getNodeID(x$SourceName), 
                                                    TargetID = getNodeID(x$TargetName)))
    nodeList <- cbind(nodeList, nodeDegree=igraph::degree(gD, v = igraph::V(gD), mode = "all"))
    betAll <- igraph::betweenness(gD, v = igraph::V(gD), directed = FALSE) / (((igraph::vcount(gD) - 1) * (igraph::vcount(gD)-2)) / 2)
    betAll.norm <- (betAll - min(betAll))/(max(betAll) - min(betAll))
    nodeList <- cbind(nodeList, nodeBetweenness=100*betAll.norm) # We are scaling the value by multiplying it by 100 for visualization purposes only (to create larger nodes)
    rm(betAll, betAll.norm)
    
    dsAll <- igraph::similarity.dice(gD, vids = igraph::V(gD), mode = "all")
    
    F1 <- function(x) {data.frame(diceSim = dsAll[x$SourceID +1, x$TargetID + 1])}
    edgeList <- plyr::ddply(edgeList, .variables=c("SourceName", "TargetName", "Weight", "SourceID", "TargetID"), 
                            function(x) data.frame(F1(x)))
    
    rm(dsAll, F1, getNodeID, gD)
    
    F2 <- colorRampPalette(c("#0000FF", "#FF0000"), bias = nrow(edgeList), space = "rgb", interpolate = "linear")
    colCodes <- F2(length(unique(edgeList$diceSim)))
    edges_col <- sapply(edgeList$Weight, function(x) colCodes[which(sort(unique(edgeList$Weight)) == x)])
    
    rm(colCodes, F2)
    ############################################################################################
    # Let's create a network
    # with a simple click action - make the circles bigger when clicked
    MyClickScript <- 
      '      d3.select(this).select("circle").transition()
                .duration(750)
                .attr("r", 30)'
    D3_network_LM <- networkD3::forceNetwork(Links = edgeList, # data frame that contains info about edges
                                             Nodes = nodeList, # data frame that contains info about nodes
                                             Source = "SourceID", # ID of source node 
                                             Target = "TargetID", # ID of target node
                                             Value = "Weight", # value from the edge list (data frame) that will be used to value/weight relationship amongst nodes
                                             NodeID = "nName", # value from the node list (data frame) that contains node description we want to use (e.g., node name)
                                             Nodesize = "nodeBetweenness",  # value from the node list (data frame) that contains value we want to use for a node size
                                             Group = "nodeDegree",  # value from the node list (data frame) that contains value we want to use for node color
                                             height = 500, # Size of the plot (vertical)
                                             width = 1000,  # Size of the plot (horizontal)
                                             fontSize = 15, # Font size
                                             linkDistance = networkD3::JS("function(d) { return 10*d.value; }"), # Function to determine distance between any two nodes, uses variables already defined in forceNetwork function (not variables from a data frame)
                                             linkWidth = networkD3::JS("function(d) { return d.value/5; }"),# Function to determine link/edge thickness, uses variables already defined in forceNetwork function (not variables from a data frame)
                                             opacity = 0.85, # opacity
                                             zoom = TRUE, # ability to zoom when click on the node
                                             # opacityNoHover = 0.1 # opacity of labels when static
                                             linkColour = edges_col, legend=TRUE, clickAction = MyClickScript
                                             ) # edge colors
    
  
    })

  output$text1 <- renderPrint({ 
    zee<-paste(input$method,"name",input$data,sep="")
    fff[[zee]][[input$sparsity]]
    #dd<-data.frame(datum[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text2 <- renderPrint({ 
    wee<-paste(input$method,"data",input$data,sep="")
    datum<-ddd[[wee]]
    dd<-data.frame(datum[input$sparsity])
    net1<-network(dd[1:2],directed=TRUE,loops=TRUE)
    # ee<-data.frame(datum[(input$sparsity)-1])
    # net2<-network(ee[1:2],directed=TRUE,loops=TRUE)
    # DD<-asIgraph(net1)
    # EE<-asIgraph(net2)
    # netcompare(net2,net1)
    # nodeList
    c(cat("size:",network.size(net1),"\n"),cat("links:",network.edgecount(net1),"\n"),cat("density:",network.density(net1),"\n"))
    })

  output$summary <- renderPrint({
    wee<-paste(input$method,"data",input$data,sep="")
    datum<-ddd[[wee]]
    
    edgeList<-datum[[input$sparsity]][1:6]
    colnames(edgeList) <- c("SourceName", "TargetName","Link","Link2","Sign", "Weight")
    
    gD<-simplify(graph.data.frame(edgeList,directed=TRUE))
    nodeList <- data.frame(ID = c(0:(igraph::vcount(gD) - 1)),nName = igraph::V(gD)$name)
    getNodeID <- function(x){which(x == igraph::V(gD)$name) - 1}
    
    edgeList <- plyr::ddply(edgeList, .variables = c("SourceName", "TargetName", "Weight"), 
                            function (x) data.frame(SourceID = getNodeID(x$SourceName), 
                                                    TargetID = getNodeID(x$TargetName)))
    nodeList <- cbind(nodeList, nodeDegree=igraph::degree(gD, v = igraph::V(gD), mode = "all"))
    betAll <- igraph::betweenness(gD, v = igraph::V(gD), directed = FALSE) / (((igraph::vcount(gD) - 1) * (igraph::vcount(gD)-2)) / 2)
    betAll.norm <- (betAll - min(betAll))/(max(betAll) - min(betAll))
    nodeList <- cbind(nodeList, nodeBetweenness=100*betAll.norm) # We are scaling the value by multiplying it by 100 for visualization purposes only (to create larger nodes)
    rm(betAll, betAll.norm)
    
    dsAll <- igraph::similarity.dice(gD, vids = igraph::V(gD), mode = "all")
    
    F1 <- function(x) {data.frame(diceSim = dsAll[x$SourceID +1, x$TargetID + 1])}
    edgeList <- plyr::ddply(edgeList, .variables=c("SourceName", "TargetName", "Weight", "SourceID", "TargetID"), 
                            function(x) data.frame(F1(x)))
    
    ###################
    
    weee<-paste(input$method,"data",input$data,sep="")
    datumm<-ddd[[wee]]
    
    edgeListt<-datum[[(input$sparsity)+1]][1:6]
    colnames(edgeListt) <- c("SourceName", "TargetName","Link","Link2","Sign", "Weight")
    
    gDD<-simplify(graph.data.frame(edgeListt,directed=TRUE))
    nodeListt <- data.frame(ID = c(0:(igraph::vcount(gDD) - 1)),nName = igraph::V(gDD)$name)
    getNodeIDD <- function(x){which(x == igraph::V(gDD)$name) - 1}
    
    edgeListt <- plyr::ddply(edgeListt, .variables = c("SourceName", "TargetName", "Weight"), 
                            function (x) data.frame(SourceIDD = getNodeIDD(x$SourceName), 
                                                    TargetIDD = getNodeIDD(x$TargetName)))
    nodeListt <- cbind(nodeListt, nodeDegree=igraph::degree(gDD, v = igraph::V(gDD), mode = "all"))
    betAll <- igraph::betweenness(gDD, v = igraph::V(gDD), directed = FALSE) / (((igraph::vcount(gD) - 1) * (igraph::vcount(gD)-2)) / 2)
    betAll.norm <- (betAll - min(betAll))/(max(betAll) - min(betAll))
    nodeListt <- cbind(nodeListt, nodeBetweenness=100*betAll.norm) # We are scaling the value by multiplying it by 100 for visualization purposes only (to create larger nodes)
    rm(betAll, betAll.norm)
    
    dsAll <- igraph::similarity.dice(gDD, vids = igraph::V(gDD), mode = "all")
    
    F1 <- function(x) {data.frame(diceSim = dsAll[x$SourceIDD +1, x$TargetIDD + 1])}
    edgeListt <- plyr::ddply(edgeListt, .variables=c("SourceName", "TargetName", "Weight", "SourceIDD", "TargetIDD"), 
                            function(x) data.frame(F1(x)))
    edgeListt
    # netcompare(network(edgeList[1:2],directed=TRUE,loops=TRUE),network(edgeListt[1:2],directed=TRUE,loops=TRUE))
    # all.equal(asIgraph(edgeList[1:2],directed=TRUE,loops=TRUE),asIgraph(edgeListt[1:2],directed=TRUE,loops=TRUE))
    
    })
  
}

#### UI ####
ui <- shinyUI(navbarPage("GeneSPIDERweb",
  
  # titlePanel("Inferred Network per Sparsity"),

    tabPanel("link", simpleNetworkOutput("simplelassoMYC")),
    tabPanel("sign", forceNetworkOutput("forcelasso")),
    tabPanel("summary", verbatimTextOutput("summary")),
  
  fluidRow(column(3,
        radioButtons("data", label="Dataset",
                     c("MYC"="MYC", "B.subtilis"="BSUB")),
        radioButtons("method", label="Method",
                     c("LASSO"="lasso", "LSCO"="lsco","TLSCO"="tlsco"))),
        column(3, radioButtons("type", "type",
                     c("Line"="4", "Sign"="6")),
        sliderInput("sparsity", "Sparsity",1, min = 1,max = length(lscodataMYC), step = 1)
      ), column(5,
               verbatimTextOutput("text1"), br(),
               verbatimTextOutput("text2"))
      )
  )
)
#### Run ####
shinyApp(ui = ui, server = server)