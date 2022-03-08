library(igraph)
library(GGally)
library(network)
library(sna)
library(data.table)
library(ggnetwork)

## blast results ###

blastres.best.miapathway2 = fread("blast_ids.csv", header=F)
blast.id = blastres.best.miapathway2
colnames(blast.id) = cbind("MIA", "%ID")

### MIA pathway ###
pathway =read.delim("MIA_pathway2", header=F)
colnames(pathway) = cbind("from", "to", "gene")


# 1) make pathway graph using MIA gene names as edges
# 2) color edge.labels according to blast ID%:
#   <70 green
#   => 70 orange
#   => 80 red

g = graph_from_data_frame(pathway, directed=T)

plot(g, edge.label=E(g)$gene, vertex.size=0, edge.arrow.size=0.1, layout=layout_nicely,
     edge.label.cex=1, vertex.label="", vertex.label.color="#56B4E9", edge.label.color="#0072B2")
#svg("MIA_pathway.svg", height=5, width=5)
dev.off()

#1st solution: prepare a vector
#think about using colorblind friendly colors! see eg http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
blast.id[, Color:=ifelse(`%ID`<70, "#f7dc6f", ifelse(`%ID`>80, "red", "#f39c12"))]
vec.col<-blast.id$Color
names(vec.col)<-blast.id$MIA
edge.color<-vec.col[E(g)$gene]

plot(g, edge.label=E(g)$gene, vertex.size=0, edge.arrow.size=0.1, layout=layout_nicely, edge.color=edge.color, edge.width=4,
     edge.label.cex=1, vertex.label="", vertex.label.color="#56B4E9", edge.label.color="#0072B2")

#2nd solution: using enzymatic reactions as vertices
pathway.dt<-data.table(pathway)
pathway.vertices<-do.call("rbind.data.frame", lapply(as.vector(pathway.dt$gene), function(x){
  to<-as.vector(pathway.dt[gene==x, to])
  do.call("rbind", lapply(to, function(y){
    toconnect<-as.vector(pathway.dt[from==y, gene])
    cbind("from"=rep(x, length(toconnect)), "to"=toconnect)
  }))
}))
edges.to.add<-cbind("from"=c("SGD", "T19H"), "to"=c("GS", "TS"))
pathway.vertices<-rbind(pathway.vertices[!is.na(pathway.vertices$to),], edges.to.add)
g2<-simplify(graph_from_data_frame(pathway.vertices, directed=T))
V(g2)$color<-vec.col[V(g2)$name]
V(g2)$color[is.na(V(g2)$color)]<-"#fdfefe" ##white
# svg("MIA_pathway.svg", height=5, width=5)
# plot(g2, vertex.size=10,  edge.arrow.size=0.1, vertex.label.dist=0, vertex.label.color="black", vertex.label.cex=0.5)
# dev.off()

#3rd solution use GGally

# g3<-data.table(ggnetwork(g2))
# g3<-merge(g3, blast.id, by.x="name", by.y="MIA", all.x=T)
# g3[is.na(`%ID`), `%ID`:=60] #updata ID coloumn by replacing %ID values of "NA" value with 60%
# ggplot(g3, aes(x, y, xend = xend, yend = yend)) +
#   geom_edges(color = "grey50",arrow = arrow(length = unit(10, "pt"), type = "closed")) +
#   geom_nodes(size = 10, aes(color = `%ID`)) +
#   geom_nodetext(aes(label = name), color = "grey80") +
#   theme_blank()


g4<-data.table(ggnetwork(g2))
g4<-merge(g4, blast.id, by.x="name", by.y="MIA", all.x=T)
#g4[is.na(`%ID`), `%ID`:=60] #updata ID coloumn by replacing %ID values of "NA" value with 60%
ggplot(g4, aes(x, y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50",arrow = arrow(length = unit(10, "pt"), type = "closed")) +
  geom_nodes(size = 10, aes(color = `%ID`)) +
  geom_nodetext(aes(label = name), color = "grey80") +
  theme_blank()

sp = ggplot(g4, aes(x, y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50",arrow = arrow(length = unit(10, "pt"), type = "closed")) +
  geom_nodes(size = 10, aes(color = `%ID`)) +
  geom_nodetext(aes(label = name), color = "black") +
  theme_blank()

sp + scale_color_gradient(low="yellow", high="red", na.value = NA)


