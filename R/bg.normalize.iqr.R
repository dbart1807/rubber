bg.normalize.iqr <-
function( bgs, mediancenter=FALSE, normalizeto=NULL, cores ="max" ){

  library(tools)
  library(parallel)

  numbgs<-length(bgs)

  if(cores=="max"){cores=detectCores()-1}
  if(cores > numbgs){cores=numbgs}


  bgnames<-basename(removeext(bgs))
  exts<-file_ext(bgs)
  outnames<-paste0(bgnames,"_iqrnorm.",exts)

  # count scores
  bglines <- unlist(mclapply(bgs, filelines, mc.cores=cores))
  q1l <- round(bglines/4)
  q2l <- q1l*2
  q3l <- q1l*3


  cat("calculating quartiles\n")
  q <- mclapply(1:numbgs, function(x){
    as.numeric(readLines(pipe(paste(
      "cut -f 4",bgs[x],
      "| sort -k1,1n | awk '{if (NR==",q1l[x],"){print $0}; if (NR==",q2l[x],"){print $0}; if(NR==",q3l[x],"){print $0; exit}}'"
    ))))
  }, mc.cores=cores )

  q1<-unlist(lapply(q,"[",1))
  q2<-unlist(lapply(q,"[",2))
  q3<-unlist(lapply(q,"[",3))
  iqrs<-q3-q1
  iqr <- mean(iqrs)
  if(!is.null(normalizeto) & is.numeric(normalizeto) ){ iqr=normalizeto }
  scalars <- iqr/iqrs

  cat("normalizing\n")
  exitstatus<-mclapply( 1:numbgs,function(x) {
    system(paste(
        "awk '{",
        if(mediancenter){"$4=$4-"},
        if(mediancenter){q2l[x]},
        if(mediancenter){";"},
        "$4=$4*",scalars[x],
        "; print $0}' OFS='\\t'",
        bgs[x],">",outnames[x]
      ))
    } , mc.cores=cores )


  return(outnames)
}
