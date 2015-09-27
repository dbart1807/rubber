read.bgs <- function ( bgfiles , makedf=TRUE , bgnames=basename(removeext(bgfiles)) , cores="max" ){

	library(parallel)

	numbgs<-length(bgfiles)

	if(cores=="max"){cores=detectCores()-1}

	if(cores>numbgs){cores<-numbgs}

	bgl<-mclapply(1:numbgs, function(x) as.numeric(readLines(pipe(paste("cut -f 4",bgfiles[x])))))

	if(length(unique(unlist(lapply(bgl,length)))) == 1){equallength=TRUE} else{equallength=FALSE}

	names(bgl) <- bgnames

	if(makedf & equallength){
		bgl<-as.data.frame(bgl)
	}

	return(bgl)

}
