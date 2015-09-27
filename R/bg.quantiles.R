bg.quantiles <-
function( bgs, quantiles=c(0,0.25,0.5,0.75,1), cores ="max" ){

  library(tools)
  library(parallel)

  numbgs<-length(bgs)

  if(cores=="max"){cores=detectCores()-1}
  if(cores > numbgs){cores=numbgs}


  bgnames<-basename(removeext(bgs))
  # exts<-file_ext(bgs)
  # outnames<-paste0(bgnames,"_iqrnorm.",exts)

  # count scores
  bglines <- unlist(mclapply(bgs, filelines, mc.cores=cores))
  ql <- lapply(1:numbgs,function(x) round(bglines[x]*quantiles))
  for(i in 1:numbgs){ql[[i]][ql[[i]]==0] <- 1}



  #bglist<-read.bgs(bgs)
  cmdString <- unlist(lapply(1:numbgs, function(x) {
    paste(
      "cut -f 4", bgs[x],
      "| sort -k1,1n | awk '{",
      paste("if (NR==",ql[[x]],"){print $0}", collapse=";"),
      "}'"
    )
  }))

  q <- mclapply(1:numbgs, function(x){
    as.numeric(readLines(pipe(cmdString[x])))
  }, mc.cores=cores )

  q <- data.matrix(as.data.frame(q))
  colnames(q) <- bgnames
  rownames(q) <- paste0("q",quantiles)

  return(q)
}
