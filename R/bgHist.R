#' Plot a histogram of scores sizes in bedGraph files
#'
#' \code{bg.hist} plots histograms, density functions, or CDFs of scores in bedGraph files.
#'
#' @param bgFiles A character vector of paths to bedgraph files.
#' @param threads A positive integer specifying how many bedGraph files to process simultaneously.

bgHist <-
function( bgfiles , threads=getOption("threads",1L), sample=NULL , chrom=NULL, ... ){

	scores <- bg.scores(bgfiles, threads=threads, sample=sample, chrom=chrom)

	rage.hist(scores, ... )

}
