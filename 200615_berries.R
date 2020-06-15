library(ggplot2)
library(reshape2)
#load data
a<-read.table("200615_berries_alkaloid", header=T, row.names=1)
head(a)
new.vector<-as.vector(a$sample_id)
a.melted<-melt(a)

#extract alkaloids

alk<-unique(a.melted[2])
typeof(alk)
alk.vector<-unlist(alk, use.names=FALSE)
typeof(alk.vector)

# give global significant alklaloids

for (i in alk.vector) {
  print (i)
  print (kruskal.test(value~sample_id, data=subset(a.melted, variable==i)))
  
}
colnames(a)
new.vector


# make boxplots

par(mar = rep(2, 4))
ls<-c('', 'ajmaline_327',	'vinorine_335',	'tabersonine_337',	'THA_353',	'strictosidine_531',	'reserpiline_413',	'rauwolscine_355',	'methoxyTHA1_383',	'methoxyTHA2_383','methoxyTHA3_383',	'vomilenine_perakinine_351',	'ajmalicine_353',	'isoreserperline_413',	'unknown2_355',	'unknown4_513',	'unknown5_531',	'unknown7_327')
ls[-c(1,1)]

for (i in ls[-c(1,2)])boxplot(a[,i]~new.vector, las=2, main=i)

#using ggplots
df<-read.table("200615_berries_alkaloid", header=T, row.names=1)
df.melt<-melt(df)
ggplot(df.melt, aes(x=sample_id, y=value)) + geom_boxplot()  + facet_wrap(~variable, scales="free_y") + theme_light() + theme(axis.text.x = element_text(angle=330, hjust=0, size=10))

p <-ggplot(df.melt, aes(x=sample_id, y=value, fill=sample_id)) + geom_boxplot()  + facet_wrap(~variable, scales="free_y") + theme_light()     
graph.final<- p + theme(strip.text = element_text(face = "bold", size = 13, color = "black")) + theme(axis.text=element_text(size=12, face = 'bold'), axis.text.x= element_text(size = 8, angle = 90), legend.key.size=unit(1, 'in'))

svg('200615_berry_alkaloids.svg', height=10, width=20)
graph.final  
dev.off()

pdf('200615_berry_alkaloids.pdf', height=10, width=20)
graph.final  
dev.off()

