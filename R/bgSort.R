bgSort <- function( bgfiles, threads=getOption("threads",1L) ){

	ext<-file_ext(bgfile)
	outnames<-paste0(basename(removeext(bgfiles)),"_scoresort.tmp")
	cmdString <- paste("sort -T . -k4,4n",bgfile,"-o",outnames)
	res <- rage.run(cmdString,threads=threads)
	return(outnames)

}
