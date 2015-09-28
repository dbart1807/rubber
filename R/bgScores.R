#' Retreive scores in bedGraph files
#'
#' \code{bg.scores} returns a list of vectors containing the scores for intervals in a set of bedGraph files.
#'
#' @param bgFiles A character vector of paths to bedgraph files.
#' @param threads A positive integer specifying how many bams to process simultaneously.

bgScores <- function( bgFiles , threads=getOption("threads", 1L), sample=NULL, chrom=NULL ){

  numbeds <- length(bgFiles)

  if( !is.null(sample) & !is.null(chrom) ){stop("must set sample or chrom or neither, but not both")}


  if(!is.null(sample)){
    stopifnot(is.numeric(sample), length(sample)==1)
    cmdString <- paste("shuf -n",sample,bgFiles,"| awk '{print $4}'")
  } else if( !is.null(chrom)){
    stopifnot(length(chrom)==1)
    cmdString <- paste0("grep -P '^",chrom,"\\t' ",bgFiles," | awk '{print $4}'")
  } else{
    cmdString <- paste("awk '{print $4}'",bgFiles)
  }



  res <- rage.run( cmdString, threads, lines=TRUE)
  res <- lapply( res, as.numeric )
  names(res) <- basename(bgFiles)

  return(res)

}
