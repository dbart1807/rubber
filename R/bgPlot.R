bgPlot <- function( bgFiles , regions , plotcolors=rainbow(length(bgFiles)), legendnames=basename(removeext(bgFiles)) ,  threads=getOption("threads",1L) , linetypes=1, linewidths=3, lspan=0, flank=0 , ylabel="score" , xline=0 , maxplots=100 ) {

  numbgs=length(bgFiles)
  if(numbgs>length(linetypes)){linetypes=rep(linetypes,numbgs)}
  if(numbgs>length(linewidths)){linewidths=rep(linewidths,numbgs)}

  if(all(file.exists(regions))){
    region <- read_tsv(regions,col_names=FALSE)
  }
  else if(grepl("-",regions) & grepl(":",regions)){
    region <- gsub(",","",regions)
    region <- gsub(":","-",region)
    region <- strsplit(region,"-")
    region <- as.data.frame(t(as.data.frame(region,stringsAsFactors=F)),stringsAsFactors=F)
    region[,2] <- as.numeric(region[,2])
    region[,3] <- as.numeric(region[,3])
    #print(region)
  }

  numplots <- nrow(region)
  if(numplots>maxplots){numplots <- maxplots}

  for(r in seq_len(numplots)){
    #print(region[r,3])
    cmdString <- paste0(
      "echo -e '", region[r,1],"\\t",region[r,2]-flank,"\\t",region[r,3]+flank,"' ",
      "| bedtools intersect -u -a ", bgFiles, " -b stdin "
    )

    scores <- rage.run( cmdString, tsv=TRUE, threads=threads)

    xlims=c( min(unlist(lapply(scores,"[",2))), max(unlist(lapply(scores,"[",2))))
    ylims=c( min(unlist(lapply(scores,"[",4))), max(unlist(lapply(scores,"[",4))))

    plot(0,0,type='n', xlim=xlims, ylim=ylims, xlab=paste(region[r,1],"coordinate (bp)") , ylab=ylabel )
    if(is.numeric(xline)){abline(h=xline)}
    for(i in seq_len(numbgs)){

      xvals <-  scores[[i]][,2]
      xvals2 <- scores[[i]][,3]
      yvals <-  scores[[i]][,4]

      if(lspan>0){
        yvals <- loess(yvals~xvals,span=lspan)$y
      }
      lines(xvals,yvals,col=plotcolors[i], lty=linetypes[i], lwd=linewidths[i], type="s")
      if(flank !=0){abline(v=region[r,2:3])}
      #segments(xvals,yvals,xvals2, yvals, col=plotcolors[i], lty=linetypes[i], lwd=linewidths[i])
    }
    legend("topright",legend=legendnames, lwd=linewidths, cex=0.6, col=plotcolors, lty=linetypes)
  }

}
