# Define server for application 

library(zoo)
library(ggplot2)

source("washoff_fun.R")


shinyServer(
  function(input, output) {
    
    output$plot = renderPlot({
      
      int.ts = input$file1
      
      if(is.null(input$file1))
        return(NULL)
      
      int.zoo=read.zoo(int.ts$datapath,sep = ",", header = TRUE,
                       index.column = 1,tz = "",
                       format = "%d/%m/%Y %H:%M")
      
      if (input$model == '1') {
        
        load.ts.exp=load.fun.exp(int.ts=int.zoo,P0=input$p,w=input$w,k=input$k)
        ins.load=load.ts.exp[[1]]
        cum.load=load.ts.exp[[2]]
        load.all=merge.zoo(int.zoo,ins.load,cum.load)
        colnames(load.all)=c("Intensity (mm/hr)", "Instantaneous load (kg)","Total load (kg)")
        load.ggpplot=fortify(load.all, data, melt = T)
        ggplot(load.ggpplot, aes(x = Index, y = Value, color= NULL)) + 
          geom_line()+
          facet_wrap(~Series,nrow=3,scales = "free_y")
        
        
      } else {
        load.ts.pow=load.fun.pow(int.ts=int.zoo,A=input$area,a=input$a,b=input$b)
        ins.load=load.ts.pow[[1]]
        cum.load=load.ts.pow[[2]]
        load.all=merge.zoo(int.zoo,ins.load,cum.load)
        colnames(load.all)=c("Intensity (mm/hr)", "Instantaneous load (kg)","Total load (kg)")
        load.ggpplot=fortify(load.all, data, melt = T)
        ggplot(load.ggpplot, aes(x = Index, y = Value, color= NULL)) + 
          geom_line()+
          facet_wrap(~Series,nrow=3,scales = "free_y")
        
        
      }
      
    })
  }
)