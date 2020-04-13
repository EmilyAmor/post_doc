library(data.table)

library(genoPlotR)



dna_seg1 <- read_dna_seg_from_tab('pxr1_cluster.csv')
is.dna_seg(dna_seg1)

annot1 <- annotation(x1=middle(dna_seg1), text=dna_seg1$name, rot=45)


dna_seg4 <- read_dna_seg_from_tab('pxr_cluster.tab.csv')
is.dna_seg(dna_seg4)


annot4 <- annotation(x1=middle(dna_seg4), text=dna_seg4$name, rot=45)

par(mfrow=c(2,1))
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
plot_gene_map(list(dna_seg1),
              annotations=list(annot1), 
              arrow_head_len=500, dna_seg_scale=TRUE, 
              n_scale_ticks = 30)



plot_gene_map(list(dna_seg4),
              annotations=list(annot4), 
              arrow_head_len=500, dna_seg_scale=TRUE, 
              n_scale_ticks = 30)

pushViewport(viewport(layout=grid.layout(2,1, heights=unit(c(1,1.3,0.8), rep("null", 3))), name="overall_vp"))

pushViewport(viewport(layout.pos.row=1, name="panelA"))

plot_gene_map(dna_segs ,comparisons=list(prx1_vs_prx4),annotations=annotats, annotation_height=1, dna_seg_scale=TRUE, scale=FALSE, main="A", main_pos="left", plot_new=FALSE)
upViewport()





seqs <- list(dna_seg1, dna_seg4)

annots<-list(annot1, annot4)


plot_gene_map(seqs, annotations= annots, 
              arrow_head_len=500, dna_seg_scale=TRUE, 
              n_scale_ticks = 30)
