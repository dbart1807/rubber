bgPlot <- function( bgFiles , regions , plotcolors=rainbow(length(bgFiles)), legendnames=basename(removeext(bgFiles)) ,  threads=getOption("threads",1L) , linetypes=1, linewidths=3, lspan=0 ) {

  numbgs=length(bgFiles)
  if(numbgs>length(linetypes)){linetypes=rep(linetypes,numbgs)}
  if(numbgs>length(linewidths)){linetypes=rep(linewidths,numbgs)}
  if(grepl("-",regions)){
    region <- gsub(",","",regions)
    region <- gsub(":","-",region)
    region <- strsplit(region,"-")
  }


  cmdString <- paste0(
    "echo -e '", region[[1]][1],"\\t",region[[1]][2],"\\t",region[[1]][3],"' ",
    "| bedtools intersect -u -a ", bgFiles, " -b stdin "
  )

  scores <- rage.run( cmdString, tsv=TRUE, threads=threads)

  xlims=c( min(unlist(lapply(scores,"[",2))), max(unlist(lapply(scores,"[",2))))
  ylims=c( min(unlist(lapply(scores,"[",4))), max(unlist(lapply(scores,"[",4))))

  plot(0,0,type='n', xlim=xlims, ylim=ylims)

  for(i in seq_len(numbgs)){

    xvals <- scores[[i]][,2]
    xvals2 <- scores[[i]][,3]
    yvals <- scores[[i]][,4]

    if(lspan>0){
      yvals <- loess(yvals~xvals,span=lspan)$y

    }


    lines(xvals,yvals,col=plotcolors[i], lty=linetypes[i], lwd=linewidths[i])


    #segments(xvals,yvals,xvals2, yvals, col=plotcolors[i], lty=linetypes[i], lwd=linewidths[i])
  }

  legend("topright",legend=legendnames, lwd=linewidths, cex=0.6, col=plotcolors, lty=linetypes)

  #return(scores)
}
