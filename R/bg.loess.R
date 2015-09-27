bg.loess <-
function( bgfile, lspan=0.05, cores="max", omitY=FALSE ){
	library(parallel)
	library(gtools)
	if(cores=="max"){cores=detectCores()-1}
	bgname<-basename(removeext(bgfile))
	cat(bgname,": loading file\n")
	curbg<-read.tsv(bgfile)
	if(omitY){curbg=curbg[-which(curbg[,1]=="chrY"),]}
	curbg$V4[is.infinite(curbg$V4)]<-NA
	chroms<-unique(curbg$V1)
	#chroms<-mixedsort(chroms)
	cat(bgname,": reference chromosome for span will be",chroms[1],"\n")
	numchroms<-length(chroms)
	#pointsperchrom<-unlist(lapply(1:numchroms, function(x) nrow(curbg[which(curbg$V1==chroms[x]),])))
	pointsperchrom<-as.numeric(table(curbg[,1]))
	pointratios<-	pointsperchrom/pointsperchrom[1]

	outname<-paste(bgname,"_loess",gsub("\\.","-",lspan),".bg",sep="")
	cat(bgname,": smoothing chromosome data\n")

	all=split(curbg,curbg$V1)
	lscores<-mclapply(1:numchroms,function(i){
	#lscores<-lapply(1:numchroms,function(i){
		cur<-all[[i]]
		print(cur[1,1])
		cur[,4]<-loess(cur[,4]~cur[,2],span=lspan*pointratios[i])$fitted
		cur
	},mc.cores=cores)
	#})
	return(outname)

	# lscores<-mclapply(1:numchroms, function(i){
	# 	curchrom<-curbg[which(curbg$V1==chroms[i]),]
	# 	if(i==1){clspan=lspan} else{clspan=lspan*(pointsperchrom[i]/pointsperchrom[1])}
	# 	goodpoints<-which(complete.cases(curchrom[,4]))
	# 	y<-curchrom[goodpoints,4]
	# 	x<-curchrom[goodpoints,2]
	# 	curchrom[goodpoints,4]<-loess(y~x,span=clspan)$fitted
	# 	curchrom
	# },mc.cores=cores,mc.preschedule=FALSE)
	curbg<-do.call(rbind,lscores)
	#curbg<-curbg[order(curbg$V1,curbg$V2),]
	cat(bgname,": saving file\n")
	write.tsv(curbg,file=outname)
}
