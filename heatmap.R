library(data.table)
library(pheatmap)

sample_annotation = read.table("sample_annotation.csv")
## with high adh
blastres = fread("rauwolfia.all.blastn")
blastres.best<-blastres[, .SD[which.max(V12)], by=V2]
blastres.best.transcripts.MIA = blastres.best[,1:2]
tpm = fread("all_samples_genome.tpm", dec=".")
merged.df = merge(tpm, blastres.best.transcripts.MIA)
ncol(merged.df)
setnames(merged.df,"V2","MIA")
setnames(merged.df,"V1","transcripts")
colnames(merged.df)
expr.mia = merged.df[,c(95,2:94,1)]
expr.mia$transcripts <- NULL
expr.mia <- expr.mia[expr.mia$MIA != "HDR", ]
expr.mia <- expr.mia[expr.mia$MIA != "PR", ]
### set up matrix ###
rnames2 <- expr.mia$MIA      
# assign labels in column 1 to "rnames"
mat_data <- data.matrix(expr.mia[,2:ncol(expr.mia)])  # transform columns (I have) into a matrix
rownames(mat_data) <- rnames2               # assign row names
class(mat_data)
pheatmap(mat_data)

a = merged.df[,c(95,2:94,1)]
expr.mia$transcripts <- NULL

### set up matrix ###
rnames2 <- expr.mia$MIA                          # assign labels in column 1 to "rnames"
mat_data <- data.matrix(expr.mia[,2:ncol(expr.mia)])  # transform columns (I have) into a matrix
rownames(mat_data) <- rnames2                  # assign row names
class(mat_data)
svg("all_samples.svg", height=10, width=20)
pheatmap(mat_data, annotation_col = sample_annotation, scale="row", center=TRUE )


dev.off()




# 
# cal_z_score <- function(x){
#   (x - mean(x)) / sd(x)
# }
# 
# data_subset_norm <- t(apply(mat_data, 1, cal_z_score))
# pheatmap(data_subset_norm)
