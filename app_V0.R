#### Load necessary packages and data ####
library(shiny)
library(networkD3)
library(network)

#setwd("~/Dropbox/SciLifeLab/git/R/GSnetApp/")
load("lassodataBSUB2016-12-06.rdata")
load("lassodataMYC2016-12-06.rdata")
load("lscodataBSUB2016-12-06.rdata")
load("lscodataMYC2016-12-06.rdata")
load("tlscodataBSUB2016-12-06.rdata")
load("tlscodataMYC2016-12-06.rdata")
#### Server ####
server <- function(input, output) {
  output$simplelassoMYC <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(lassodataMYC[input$sparsity], "[", 1),lapply(lassodataMYC[input$sparsity], "[", 2)))#,input=input$sparsity)
  })
  output$simplelscoMYC <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(lscodataMYC[input$sparsity], "[", 1),lapply(lscodataMYC[input$sparsity], "[", 2)))#,input=input$sparsity)
  })
  output$simpletlscoMYC <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(tlscodataMYC[input$sparsity], "[", 1),lapply(tlscodataMYC[input$sparsity], "[", 2)))#,input=input$sparsity)
  })
  output$simplelassoBSUB <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(lassodataBSUB[input$sparsity], "[", 1),lapply(lassodataBSUB[input$sparsity], "[", 2)))#,input=input$sparsity)
  })
  output$simplelscoBSUB <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(lscodataBSUB[input$sparsity], "[", 1),lapply(lscodataBSUB[input$sparsity], "[", 2)))#,input=input$sparsity)
  })
  output$simpletlscoBSUB <- renderSimpleNetwork({
    # input = input$sparsity
    simpleNetwork(data.frame(lapply(tlscodataBSUB[input$sparsity], "[", 1),lapply(tlscodataBSUB[input$sparsity], "[", 2)))#,input=input$sparsity)
  })

  output$forcelasso <- renderForceNetwork({
    # input = input$sparsity
    names<-lapply(lassodataMYC[input$sparsity], "[", 1)
    group<-lapply(lassodataMYC[input$sparsity], "[", 5)
    #group<-group[1:length(names)]
    
    cc<-data.frame(lassodataMYC[input$sparsity])
    dd<-cbind(sapply(cc[1:2], match, unique(unlist(cc[1:2]))), cc[1:2])
    sources<-lapply(lassodataMYC[input$sparsity], "[", 1)#dd[1]
    targets<-lapply(lassodataMYC[input$sparsity], "[", 2)#dd[2]
    # names<-(dd[3])
    Nodes<-data.frame( name=names, group=group )
    values<-lapply(lassodataMYC[input$sparsity], "[", 6)
    Links<-data.frame(source=sources,target=targets,value=values)
    colnames(Links)<-c("sources","targets","values")
    colnames(Nodes)<-c("names","group")
    dd<-forceNetwork(Links = Links, Nodes = Nodes, 
                     Source = "sources", Target = "targets", 
                     Value = "values", NodeID = "names", 
                     Group = "group", width = 550, height = 400, zoom=TRUE,
                     opacity = 0.9)
  })
  output$forcelsco <- renderForceNetwork({
    # input = input$sparsity
    names<-(lapply(lscodataMYC[input], "[", 1))
    group<-lapply(lscodataMYC[input], "[", 5)
    #group<-group[1:length(names)]
    Nodes<-data.frame( name=names, group=group )
    sources<-lapply(lscodataMYC[input], "[", 1)
    targets<-lapply(lscodataMYC[input], "[", 2)
    values<-lapply(lscodataMYC[input], "[", 6)
    Links<-data.frame(source=sources,target=targets,value=values)
    colnames(Links)<-c("sources","targets","values")
    colnames(Nodes)<-c("names","group")
    dd<-forceNetwork(Links = Links, Nodes = Nodes, 
                     Source = "sources", Target = "targets", 
                     Value = "values", NodeID = "names", 
                     Group = "group", width = 550, height = 400, zoom=TRUE,
                     opacity = 0.9)
  })
  output$forcetlsco <- renderForceNetwork({
    # input = input$sparsity
    names<-(lapply(tlscodataMYC[input], "[", 1))
    group<-lapply(tlscodataMYC[input], "[", 5)
    #group<-group[1:length(names)]
    Nodes<-data.frame( name=names, group=group )
    sources<-lapply(tlscodataMYC[input], "[", 1)
    targets<-lapply(tlscodataMYC[input], "[", 2)
    values<-lapply(tlscodataMYC[input], "[", 6)
    Links<-data.frame(source=sources,target=targets,value=values)
    colnames(Links)<-c("sources","targets","values")
    colnames(Nodes)<-c("names","group")
    dd<-forceNetwork(Links = Links, Nodes = Nodes, 
                     Source = "sources", Target = "targets", 
                     Value = "values", NodeID = "names", 
                     Group = "group", width = 550, height = 400, zoom=TRUE,
                     opacity = 0.9)
  })
  output$text1 <- renderPrint({ MSfilenames[input$sparsity]
    #dd<-data.frame(lassodataMYC[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text2 <- renderPrint({MLfilenames[input$sparsity]
    #dd<-data.frame(lscodataMYC[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text3 <- renderPrint({MTfilenames[input$sparsity]
    #dd<-data.frame(lscodataMYC[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text4 <- renderPrint({BSfilenames[input$sparsity]
    #dd<-data.frame(lassodataBSUB[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text5 <- renderPrint({BLfilenames[input$sparsity]
    #dd<-data.frame(lscodataBSUB[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  output$text6 <- renderPrint({BTfilenames[input$sparsity]
    #dd<-data.frame(lscodataBSUB[input$sparsity])
    #(network(dd[1:2],directed=TRUE))
  })
  
}

#### UI ####
ui <- shinyUI(navbarPage("NetAnalysis",
  
  # titlePanel("Inferred Network per Sparsity"),

    tabPanel("MYC LASSO", simpleNetworkOutput("simplelassoMYC"), verbatimTextOutput("text1")),
    tabPanel("MYC LSCO", simpleNetworkOutput("simplelscoMYC"), verbatimTextOutput("text2")),
    navbarMenu("more",
    tabPanel("MYC TLSCO", simpleNetworkOutput("simpletlscoMYC"), verbatimTextOutput("text3")),
    tabPanel("B.subtilis LASSO", simpleNetworkOutput("simplelassoBSUB"), verbatimTextOutput("text4")),
    tabPanel("B.subtilis LSCO", simpleNetworkOutput("simplelscoBSUB"), verbatimTextOutput("text5")),
    tabPanel("B.subtilis TLSCO", simpleNetworkOutput("simpletlscoBSUB"), verbatimTextOutput("text6")) ,
    tabPanel("force lasso", forceNetworkOutput("forcelasso"), verbatimTextOutput("tex`t6")),
    tabPanel("force lsco", forceNetworkOutput("forcelsco"), verbatimTextOutput("tex't5")),
    tabPanel("force tlsco", forceNetworkOutput("forcetlsco"), verbatimTextOutput("tex't4")) ),

      sidebarPanel(
        radioButtons("data", "data",
                     c("MYC"="M", "B.sutilis"="B")),
        radioButtons("method", "Method",
                     c("LASSO"="L", "LSCO"="S","TLSCO"="T")),
        radioButtons("type", "type",
                     c("Line"="l", "Sign"="s")),
        sliderInput("sparsity", "Sparsity",1, min = 1,max = length(lscodataMYC), step = 1)
      
    )
  )
)
#### Run ####
shinyApp(ui = ui, server = server)