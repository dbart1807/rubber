bgLoess <-
function( bgfiles, lspan=0.05, threads=getOption("threads",1L), omitY=FALSE ){

	# assumes sorted bg

	bgnames <- basename(removeext(bgfiles))
	numbgs <- length(bgfiles)
	outnames <- paste(bgnames,"_loess",gsub("\\.","-",lspan),".bg",sep="")
	chromthreads <- floor(threads/numbgs)
	if(chromthreads==0){chromthreads=1}

	dump <- mclapply(seq_len(numbgs), function(x){
		curbg <- read_tsv ( bgfiles[x], col_names=FALSE )
		if(omitY){curbg=curbg[-which(curbg[,1]=="chrY"),]}

		#curbg$V4[is.infinite(curbg$V4)]<-NA

		chroms    <- unique(curbg[,1])
		numchroms <- length(chroms)

		pointsperchrom <- as.numeric(table(curbg[,1]))
		pointratios    <-	pointsperchrom/pointsperchrom[1]
		scaledspans    <- lspan*pointratios

		smoothstats <- data.frame( chr=chroms , numPoints=pointsperchrom , scaledSpans=scaledspans)
		if(getOption("verbose")){print(paste("smoothing stats for",bgnames[x]));print(smoothstats)}
		all=split(curbg,curbg[,1])

		lscores<-mclapply(1:numchroms,function(i){
			cur <- all[[i]]
			cur[,4] <- tryCatch(
				{loess(cur[,4]~cur[,2],span=scaledspans[i])$fitted},
			 	error = function(err){
					print(paste("smoothing failed for file",bgnames[x],"chromosome",cur[1,1],":",err))
					return(cur[,4])
				}
			)
			return(cur)
		},mc.cores=chromthreads, mc.preschedule=FALSE)

		curbg<-do.call(rbind,lscores)
		write.tsv(curbg,file=outnames[x])
		rm(curbg)
		gc()

	}, mc.cores=threads, mc.preschedule=FALSE)

	return(outnames)

	#chroms<-mixedsort(chroms)
	#cat(bgname,": reference chromosome for span will be",chroms[1],"\n")
	#pointsperchrom<-unlist(lapply(1:numchroms, function(x) nrow(curbg[which(curbg$V1==chroms[x]),])))

	#})

	# lscores<-mclapply(1:numchroms, function(i){
	# 	curchrom<-curbg[which(curbg$V1==chroms[i]),]
	# 	if(i==1){clspan=lspan} else{clspan=lspan*(pointsperchrom[i]/pointsperchrom[1])}
	# 	goodpoints<-which(complete.cases(curchrom[,4]))
	# 	y<-curchrom[goodpoints,4]
	# 	x<-curchrom[goodpoints,2]
	# 	curchrom[goodpoints,4]<-loess(y~x,span=clspan)$fitted
	# 	curchrom
	# },mc.cores=cores,mc.preschedule=FALSE)
	#curbg<-curbg[order(curbg$V1,curbg$V2),]

}
