bedStructures <-
function( bedfile , promoter5 = c(-1000,0) , promoter3 = c(0,1000) , genebody = c(200,-200) , bedname = basename(removeext(bedfile) ) ) {
	bed<-read.tsv(bedfile)
	bed<-bed[order(bed$V1,bed$V2),]
	if(ncol(bed) < 6){stop("no strand information found")}
	pos<-which(bed$V6=="+")
	neg<-which(bed$V6=="-")
	posbed<-bed[pos,]
	negbed<-bed[neg,]
	utr5<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V2,V3=posbed$V7,stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V8,V3=negbed$V3,stringsAsFactors=F)
	)
	utr5<-utr5[which(utr5$V3-utr5$V2 > 0),]
	utr3<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V8,V3=posbed$V3,stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V2,V3=negbed$V7,stringsAsFactors=F)
	)
	utr3<-utr3[which(utr3$V3-utr3$V2 > 0),]
	prom5<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V2+promoter5[1],V3=posbed$V2+promoter5[2],stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V3-promoter5[2],V3=negbed$V3-promoter5[1],stringsAsFactors=F)
	)
	prom3<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V3+promoter3[1],V3=posbed$V3+promoter3[2],stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V2-promoter3[2],V3=negbed$V2-promoter3[1],stringsAsFactors=F)
	)
	orf<-data.frame(V1=bed$V1,V2=bed$V7,V3=bed$V8,stringsAsFactors=F)
	gene<-data.frame(V1=bed$V1,V2=bed$V2+genebody[1],V3=bed$V3+genebody[2],stringsAsFactors=F)
	gene<-gene[which(gene$V3-gene$V2 > 0),]

	utr5name  <- paste0(bedname,"_utr5.bed")
	utr3name  <- paste0(bedname,"_utr3.bed")
	prom5name <- paste0(bedname,"_prom5.bed")
	prom3name <- paste0(bedname,"_prom3.bed")
	gbname    <- paste0(bedname,"_genebody.bed")
	orfname   <- paste0(bedname,"_orf.bed")

	write.tsv(utr5,file=utr5name)
	write.tsv(utr3,file=utr3name)
	write.tsv(prom5,file=prom5name)
	write.tsv(prom3,file=prom3name)
	write.tsv(gene,file=gbname)
	write.tsv(orf,file=orfname)

	return(c(utr5name,utr3name,prom5name,prom3name,gbname,orfname))

}
