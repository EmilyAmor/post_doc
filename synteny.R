library(genoPlotR)


dna_seg1 <- read_dna_seg_from_tab('../pxr1_cluster.csv')

is.dna_seg(dna_seg1)
annot1 <- annotation(x1=middle(dna_seg1), text=dna_seg1$prx, rot=45)

dna_seg4 <- read_dna_seg_from_tab('../pxr_cluster.tab.csv')


is.dna_seg(dna_seg4)
annot4 <- annotation(x1=middle(dna_seg4), text=dna_seg4$prx, rot=45)

dna_segs <- list(dna_seg1, dna_seg4)
annotats <- list(annot1, annot4)

prx1_vs_prx4 <- try(read_comparison_from_blast("blastn.txt", filt_high_evalue = 1e-6, filt_length = 100))

plot_gene_map(dna_segs ,comparisons=list(prx1_vs_prx4), gene_type="side_blocks",annotations=annotats, annotation_height=2, dna_seg_scale=TRUE, scale=FALSE, main = )

