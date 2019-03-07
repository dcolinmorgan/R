output$CytoscapeJS <-renderRcytoscapejs({
    if(input$raw==FALSE){
      wee<-paste(input$data,"dataMYCsign",sep="")
      datum<-ddd[[wee]]
      # datum<-lapply(datum, function(df){df[order(size(df,2)),]})
    }else{
      # }else if(input$demo4==TRUE){
      inFile <- input$file1
      if (is.null(inFile))
        return(NULL)
      datum <-lapply(rev(mixedsort(inFile$datapath)), read.csv, header=FALSE,sep = input$sep)
    }
    
    edgeData<-datum[[input$sparsity]][1:6]
    colnames(edgeData) <- c("sourceName", "targetName","link1","link2","link", "weight")
    if(input$self==FALSE){
      edgeData<-edgeData%>%filter_(~as.character(sourceName)!=as.character(targetName))####REMOVE SELF LINKS -- works on test network file
    }
    
    
    edgeData$edgeTargetShape<-edgeData$link1
    edgeData$edgeTargetShape<-gsub(-1,"tee",edgeData$edgeTargetShape)
    edgeData$edgeTargetShape<-gsub(1,"triangle",edgeData$edgeTargetShape)
    # edgeData$edgeSourceShape<-edgeData$edgeTargetShape
    
    edgeData$color<-edgeData$link1
    edgeData$color<-gsub(-1,"#FF0000",edgeData$color)
    edgeData$color<-gsub(1,"#0000FF",edgeData$color)
    
    gD<-simplify(graph.data.frame(edgeData,directed=TRUE))
    nodeData <- data.frame(id = c(0:(igraph::vcount(gD) - 1)),name = igraph::V(gD)$name)
    getNodeID <- function(x){which(x == igraph::V(gD)$name) - 1}
    
    edgeData <- plyr::ddply(edgeData, .variables = c("sourceName", "targetName", "weight","color","edgeTargetShape"),
                            function (x) data.frame(source = getNodeID(x$source),
                                                    target = getNodeID(x$target)))
    edgeData$targetShape<-edgeData$edgeTargetShape
    edgeData$targetShape<-edgeData$edgeTargetShape
    
    nodeData$shape <- "ellipse"
    # nodeData$selector<-"green"
    nodeData <- cbind(nodeData, nodeDegree=igraph::degree(gD, v = igraph::V(gD), mode = "all"))
    
    network <- createCytoscapeJsNetwork(nodeData, edgeData)
    rcytoscapejs(network$nodes, network$edges, layout=input$clay)
    
  })