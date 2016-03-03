counts2matrix <-
function ( counts , bedfile , countCols , nameCol=1 , samplenames=NULL ){

	bed=tsvRead(bedfile)
	cnt=tsvRead(counts,col_names=T,comment="#")
	bedname <- basename(removeext(bedfile))
	bedcols<-ncol(bed)
	bedrows<-nrow(bed)
	#matgenes<-unlist(lapply(strsplit(row.names(mat),";") , "[" , 3 ))

	# if(b73){
	# 	matgenes<-remove.suffix(matgenes,"_T")
	# 	matgenes<-gsub("_FGT","_FG",matgenes)
	# }
	#

	namematch<-match(bed[,4],cnt[,nameCol])
	cnt <- cnt[namematch,]

	numsamples<-length(countCols)
	samplecols<-countCols

	if(is.null(samplenames)){ samplenames<-basename(colnames(cnt)[countCols]) }

	outnames <- paste0(samplenames,"_",bedname,".mat0")

	# name features
	if(bedcols<4){
		geneids<-seq_len(bedrows)
	} else{
			geneids<-bed[,4]
	}
	if(length(unique(geneids)) != bedrows){
		geneids<-paste(geneids,seq_len(bedrows),sep="-")
	}

	if(bedcols<6){
		strands<-bed[,6]
	} else{
		strands<-rep("+",bedrows)
	}


	if(bedcols>12){
		symbs<-bed[,13]
	} else{
		symbs<-geneids
	}

	matrownames <- paste(bed[,1],bed[,2],bed[,3],geneids,strands,symbs,sep=";")




	dump <- lapply(seq_len(numsamples),function(x){

		readcounts <- as.numeric(cnt[,6+x])
		rpkms<-rpkm.default(readcounts,cnt[,6])

		mat <- matrix(rpkms,nrow=nrow(bed),ncol=1)
		row.names(mat) <- matrownames
		write.mat(mat, file=outnames[x])
	})

	return(outnames)



}
