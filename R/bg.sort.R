bg.sort <-
function( bgfile ){
	library(tools)
	ext<-file_ext(bgfile)
	outname<-paste0(basename(removeext(bgfile)),"scoresort.",ext)
	system(paste("sort -T . -k4,4n",bgfile,"-o",outname))
	return(outname)
}
