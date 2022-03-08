gff<-fread("cro_ap_asm_v2.genes.gff3")
gff[,Gene_id:=gsub("ID=","", strsplit(V5, ";")[[1]][1]), by=1:nrow(gff)]
get.proms<-function(scaff, start, end, strand, gene_id){
	if (strand=="-") {
		from=end
		to=end+500
		system(paste("blastdbcmd -db cro_ap_asm.hpcc.v2_def.fasta -entry", scaff, "-range", paste(from, "-", to, sep=""), paste("| sed '1 s/^.*$/>", gene_id, "/g'", sep=""), ">>prom_negative_strand.fa", sep=" "))} else {
		from=ifelse((start-500)<=0, 1, start-500)
		to=start
		system(paste("blastdbcmd -db cro_ap_asm.hpcc.v2_def.fasta -entry", scaff, "-range", paste(from, "-", to, sep=""), paste("| sed '1 s/^.*$/>", gene_id, "/g'", sep=""), ">>prom_positive_strand.fa", sep=" "))}
}
gff[, get.proms(V1, V2, V3, V4, Gene_id), by=Gene_id]
