bed.removechrom <- function( bedFiles , chrom , threads=getOption("threads",1L) ){

  cmdString <- paste0(
    "sed -i -n '/^",chrom,"\t/!p' ",bedFiles
  )
  res <- rage.run(cmdString,threads)


}
