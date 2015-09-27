bg.qnorm <-
function( bgfiles, normalizeto = 1:length(bgfiles) , cores="max" ){

	if(cores=="max"){cores=detectCores()-1}

	# check of files have identical coordinates in head and # of total lines
	# check if more than 1 file in bgfiles
	# make sure all files only have 4 columns

	numfiles<-length(bgfiles)
	bgnames<-basename(removeext(bgfiles))
	outbgnames<-paste0(bgnames,"_qnorm.bg")

	cat("sorting reference\n")
	bgref <- unlist(mclapply(bgfiles[normalizeto], bg.sort, mc.cores = cores ))
	if(length(normalizeto)>1){ bgref <- bg.ops(bgref, operation="mean", outnames = paste0("mean_",basename(bgref[1]))) }



	cat("normalizing data\n")
	dump<-mclapply(1:numfiles, function(x) {
		system(paste("sort -T . -k4,4n",bgfiles[x],"| paste -",bgref,"| awk '{print $1,$2,$3,$8}' OFS='\t' | sort -T . -k1,1 -k2,2n >",outbgnames[x]))
	},mc.cores=cores,mc.preschedule=F)

	return(outbgnames)



	# cat("loading files\n")
	# bglist<-mclapply(bgfiles,read.tsv,mc.cores=cores)
	# #if(unique(unlist(lapply(bglist,nrow))) > 1){comparable=FALSE}else{comparable=TRUE}
	# rankscores<-bglist[[1]][order(bglist[[1]][,4],na.last=F),4]
	# bglist<-mclapply(1:numfiles, function(x){
	# 	bglist[[x]][order(bglist[[x]][,4],na.last=F),4]<-rankscores
	# 	write.tsv(bglist[[x]],file=outbgnames[x])
	# },mc.cores=cores)
}
