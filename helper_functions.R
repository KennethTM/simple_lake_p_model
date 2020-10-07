###### HELPER FUNCTIONS ###### 
#Model reuires deSolve package, check for existence and install if missing

if(require(deSolve) == FALSE){
  install.packages('deSolve')
}

if(require(deSolve) == FALSE){
  print("Error: deSolve package is not installed on your machine")
  print("Ask for help!")
}

#Combine input data in list for the model
InputData <- c("PhytoLightLimitation" = list(PhytoLightLimitation), 
               "WaterTemperature" = list(WaterTemperature),
               "PhytoTempEffect" = list(PhytoTempEffect),
               "SedimentReleaseRate" = list(SedimentReleaseRate),
               "Light" = list(Light),
               "ZooTempEffect" = list(ZooTempEffect),
               "InletDischarge" = list(InletDischarge),
               "PhytoQuality" = list(PhytoQuality),
               "Inlet_P_Concentration" = list(Inlet_P_Concentration))

#Function to interpolate between monthly values of input data
GetData <- function(x, name, datalist=InputData){
  df=datalist[[name]]
  minT <- min(df[,1],na.rm=T)
  maxT <- max(df[,1],na.rm=T)
  if(x < minT | x > maxT){
    l <- lm(get(colnames(df)[2])~poly(get(colnames(df)[1]),3),data=df)
    do <- data.frame(x); colnames(do) <- colnames(df)[1]
    o <- predict(l,newdata=do)[[1]]	
  }else{
    t1 <- max(df[which(df[,1] <= x),1])
    t2 <- min(df[which(df[,1] >= x),1])
    if (t1 == t2) {
      o <- df[t1,2]
    }else{
      w1=1/abs(x-t1);w2=1/abs(x-t2)
      o <- ((df[which(df[,1] == t1),2]*w1)+(df[which(df[,1] == t2),2]*w2))/(w1+w2)
    }
  }
  return(o)
}

#Function to plot input data
PlotInputData <- function(list){
  par(mfrow=c(3, 3))
  lapply(list, function(x){plot(x, type = "b", main = names(x)[2])})
}

#Create interactive plot using plotly
interactive_plot <- function(output){
  if(require(plotly) == FALSE){
    install.packages('plotly')
  }
  
  if(require(plotly) == FALSE){
    print("Error: plotly package is not installed on your machine")
    print("Ask for help!")
    return(-1)
  }
  
  df <- data.frame(output)
  
  fig <- plot_ly(df, x = ~time, y = ~Phyto_P_Pool, name = 'Phyto_P_Pool', mode = 'lines', type = 'scatter') %>% 
    add_trace(y = ~Water_P_Pool, name = 'Water_P_Pool', mode = 'lines') %>% 
    add_trace(y = ~Sediment_P_Pool, name = 'Sediment_P_Pool', mode = 'lines') %>% 
    add_trace(y = ~Zoo_P_Pool, name = 'Zoo_P_Pool', mode = 'lines') %>% 
    layout(xaxis = list(title = "Time (months)"), yaxis =  list(title = "Lake P pools (kg P)"))
  
  fig
}