bedStructures <-
function( bedfile , promoter5 = c(-1000,0) , promoter3 = c(0,1000) , bedname = basename(removeext(bedfile)), chromsizes ) {

	if(missing(chromsizes)){
		chromsizes<-getOption("chromsizes",NULL)
		if(is.null(chromsizes)){stop("must define file contain chromosome sizes")}
	}
	if(!file.exists(chromsizes)){
		stop("chromsizes file does not exist")
	}

	utr5name  <- paste0(bedname,"_utr5.bed")
	utr3name  <- paste0(bedname,"_utr3.bed")
	utrname   <- paste0(bedname,"_utr.bed")
	prom5name <- paste0(bedname,"_prom5.bed")
	prom3name <- paste0(bedname,"_prom3.bed")
	orfname   <- paste0(bedname,"_orf.bed")
	exonname  <- paste0(bedname,"_exons.bed")
	intergenicname <- paste0(bedname,"_intergenic.bed")
	genicname <- paste0(bedname,"_genic_tmp.bed")
	genicname2 <- paste0(bedname,"_genic.bed")
	intronname <- paste0(bedname,"_introns.bed")

	bed<-tsvRead(bedfile)

	bed<-bed[order(bed$V1,bed$V2,bed$V3),]

	if(ncol(bed) < 6){stop("no strand information found")}
	posbed<-bed[which(bed$V6=="+"),]
	negbed<-bed[which(bed$V6=="-"),]

	chroms = unique(bed[,1])
	sbed=split(bed,bed[,1])
	numchroms=length(sbed)

	exons <- do.call(rbind,lapply(1:numchroms,function(i){
		exonsizes <- lapply(strsplit(sbed[[i]][,11],","),as.numeric)
		exonstarts <- lapply(strsplit(sbed[[i]][,12],","),as.numeric)
		exonstarts2 <- unlist(lapply(1:length(exonsizes),function(x) exonstarts[[x]]+sbed[[i]][x,2] ))
		exonsizes2 <- unlist(exonsizes)
		exonstops <-  exonstarts2+exonsizes2
		exons <- data.frame(chrom=names(s)[[i]],start=exonstarts2,stop=exonstops)
		return(exons)
	}))

	tsvWrite(exons,file=exonname)
	bedSort(exonname)

	utr5<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V2,V3=posbed$V7,stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V8,V3=negbed$V3,stringsAsFactors=F)
	)
	utr5<-utr5[which(utr5$V3-utr5$V2 > 0),]
	tsvWrite(utr5,file=utr5name)
	bedSort(utr5name)

	utr3<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V8,V3=posbed$V3,stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V2,V3=negbed$V7,stringsAsFactors=F)
	)
	utr3<-utr3[which(utr3$V3-utr3$V2 > 0),]
	tsvWrite(utr3,file=utr3name)
	bedSort(utr3name)

	utrname <- bedCat(c(utr5name,utr3name),utrname)

	prom5<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V2+promoter5[1],V3=posbed$V2+promoter5[2],stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V3-promoter5[2],V3=negbed$V3-promoter5[1],stringsAsFactors=F)
	)
	prom5[which(prom5[,2]<0),2]<-0
	tsvWrite(prom5,file=prom5name)
	bedSort(prom5name)

	prom3<-rbind(
		data.frame(V1=posbed$V1,V2=posbed$V3+promoter3[1],V3=posbed$V3+promoter3[2],stringsAsFactors=F),
		data.frame(V1=negbed$V1,V2=negbed$V2-promoter3[2],V3=negbed$V2-promoter3[1],stringsAsFactors=F)
	)
	prom3[which(prom3[,2]<0),2]<-0
	tsvWrite(prom3,file=prom3name)
	bedSort(prom3name)

	intronname <- bedtoolsSubtract(bedfile,exonname,intronname)
	orfBoundaries <- bedtoolsSubtract(bedfile,utrname)
	unlink(orfBoundaries)
	orfname <- bedtoolsSubtract(orfBoundaries,intronname,orfname)

	genicname=bedCat(c(bedfile,prom5name,prom3name),genicname)
	cmdString <- paste("cut -f 1,2,3",genicname,">",genicname2)
	unlink(genicname)
	res <- cmdRun(cmdString)
	intergenicfile <- bedtoolsComplement(genicname2,chromsizes,intergenicname)
	unlink(genicname2)



	return(c(intergenicname,intronname,utr5name,utr3name,prom5name,prom3name,orfname))

}
