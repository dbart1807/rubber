bg.ks<- function( bgs , against=NULL , trim=c( 0.05, 0.95 , ... )){

  bglist=read.bgs(bgs)
  bglist=as.data.frame(lapply(bgl,sort))
  numscores=nrow(bglist)
  numfiles =ncol(bglist)

  if(is.null(against)){
    refscores <- rowMeans(bglist)
  } else{
    refscores <- bglist[,against]
  }

  if(trim[1]!=0){
    startrow=round(trim[1]*numscores)
  } else{ startrow=1}

  if(trim[2]!=1){
    endrow=round(trim[2]*numscores)
  } else{ end=numscores}

  bglist<-bglist[startrow:endrow,]
  stats<-unlist(lapply(1:numfiles,function(x) as.numeric(ks.test(bgl[,x],refscores)$statistic) ) )


}
