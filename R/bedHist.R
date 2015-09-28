#' Plot a histogram of interval sizes in bed files
#'
#' \code{bedHist} plots histograms, density functions, or CDFs of interval sizes in bed files.
#'
#' @param bedFiles A character vector of paths to bed files.
#' @param threads A positive integer specifying how many beds to process simultaneously.

bedHist <-
function( bedFiles , sample=NULL , threads=getOption("threads",1L), ... ){
	options(scipen=99999)
	scores <- bed.sizes(bedFiles, threads=threads, sample=sample, threads=threads)

	rageHist(scores, threads=threads, ... )

}
