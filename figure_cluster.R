library(data.table)

library(genoPlotR)

dna_seg1 <- read_dna_seg_from_tab('pxr1_cluster.csv')
is.dna_seg(dna_seg1)

annot1 <- annotation(x1=middle(dna_seg), text=dna_seg$name, rot=45)
plot_gene_map(list(dna_seg1),
              annotations=list(annot1), 
              arrow_head_len=500, main="cro_v2_scaffold_99", dna_seg_scale=TRUE, 
              n_scale_ticks = 30)

dna_seg4 <- read_dna_seg_from_tab('pxr_cluster.tab.csv')
is.dna_seg(dna_seg4)

annot4 <- annotation(x1=middle(dna_seg4), text=dna_seg4$name, rot=45)

plot_gene_map(list(dna_seg4),
              annotations=list(annot4), 
              arrow_head_len=500, main="cro_v2_scaffold__87", dna_seg_scale=TRUE, 
              n_scale_ticks = 30)
