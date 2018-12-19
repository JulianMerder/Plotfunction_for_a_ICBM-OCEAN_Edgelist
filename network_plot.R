### Geomol Network Plot

## Original Code
#edg<-read.csv("Edgelist_C.csv",stringsAsFactors = F) # load your Geomol edgelist and run the function below with

plot_edgelist<-function(edgelist,selected_formula=NULL,color_by="C",cols=c("darkturquoise","midnightblue"),labelsize=20,staticlayout=F){
# load required R packages
if (!require("visNetwork")) {install.packages("visNetwork"); library(visNetwork)}
if (!require("RColorBrewer")) {install.packages("RColorBrewer"); library(RColorBrewer)}
if (!require("dplyr")) {install.packages("dplyr"); library(dplyr)}
  
# if variables are imported as factor, switch to character
edg[,3]<-as.character(edg[,3])
edg[,4]<-as.character(edg[,4])
edg[,5]<-as.character(edg[,5])
edg<-edg[drop = FALSE,edg[,1]!=edg[,2],]


#give colors to homologous series
edg[,3][edg[,3]=="CH2"]<-"blue"
edg[,3][edg[,3]=="CO2"]<-"green"
edg[,3][edg[,3]=="H2"]<-"black"
edg[,3][edg[,3]=="H2O"]<-"orange"
edg[,3][edg[,3]=="O"]<-"red"
edg[,3][edg[,3]=="isotope"]<-"grey"
edg[,3][!(edg[,3] %in% c("blue","green","black","orange", "red","grey"))]<-rgb(1,1,1,alpha=1)
#edg<-edg[edg[,3]!="white",]]

#set up legend
ledges <- data.frame(color = c("blue","green","black","orange", "red","grey"),
                     label = c("CH2", "CO2","H2","H2O","O","isotope"),font.size = c(20,20))
ledges<-ledges[ledges$color %in% edg[,3],]


#create color palette
rbbPal<-colorRampPalette(as.character(cols))
l<-sapply(c(edg[,4],edg[,5]),function(x){
  H<-unlist(strsplit(x,split=" "))
  H<-as.numeric(H[which(H==color_by)+1])
})
l<-l-(min(l)-1)

# set up nodes
nodes=data.frame(id=c(edg[,1],edg[,2]),label=c(as.character(edg[,4]),as.character(edg[,5])),color=as.character(rbbPal(max(l))[as.numeric(l)]))
nodes$color<-as.character(nodes$color)
nodes$label<-as.character(nodes$label)
nodes$font.size<-labelsize

#create legend
hedges<-data.frame(color = c(as.character(nodes$color[which.min(l)][1]),as.character(nodes$color[which.max(l)][1])),
                   label = c(paste0("low ",as.character(color_by)), paste0("high ",as.character(color_by))),shape=c("dot"),font.color=c("black","black"),font.size = c(25,25))

# if selected formula should be shown adjust node color and legend
selected_formula<-try(as.character(selected_formula))
if(is.character(selected_formula) & length(selected_formula) == 1){
if(selected_formula %in% nodes$label){
nodes$color[nodes$label==selected_formula]<-paste0("#FFA500")
hedges<-data.frame(color = c(as.character(nodes$color[which.min(l)][1]),as.character(nodes$color[which.max(l)][1]),"orange"),
                   label = c(paste0("low ",as.character(color_by)), paste0("high ",as.character(color_by)),"selected"),shape=c("dot"),font.color=c("black","black","black"),font.size = c(25,25,25))
}
}
nodes<-nodes[!duplicated(nodes$id),]

# set up edges
edges=data.frame(from=edg[,1],to=edg[,2],color=edg[,3])

# plot network static or with physics
if(!isTRUE(staticlayout)){
A<-visNetwork(nodes, edges)%>%
  visLegend(addEdges = ledges, useGroups = FALSE,addNodes = hedges)  %>% visPhysics(stabilization = F,timestep=0.3,forceAtlas2Based = list(avoidOverlap = 1)) %>%
  visEdges(smooth = FALSE)
}else {
  
  A<-visNetwork(nodes, edges)%>%
    visLegend(addEdges = ledges, useGroups = FALSE,addNodes = hedges)  %>% visIgraphLayout() %>%
    visEdges(smooth = FALSE)
  
  
}


return(A)
}
# run the function with : print(plot_edgelist(edgelist='name of your edgelist',selected_formula = NULL,color_by="O",cols=c("green","red"))) OR
# plot_edgelist(edgelist=edg,selected_formula = NULL,color_by="H",cols=c("green","purple","red"),labelsize=40,staticlayout=T)



