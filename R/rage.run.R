rage.run <- function( cmdString , threads=1 , intern=FALSE , tsv=FALSE , lines=FALSE , quiet=FALSE , considerJobs=getOption("considerJobs",TRUE) ){

  numStrings <- length(cmdString)
  numJobs <- max(unlist(lapply(strsplit(cmdString,split="|",fixed=T),length)))

  if(considerJobs){
    threads <- floor(threads/numJobs)
  }

  if( numStrings < threads ){ threads <- numStrings }

  if(threads<2){
    res<-lapply(1:length(cmdString), function(i){
      if(!quiet){print(cmdString[i])}

      if(intern){
        system(cmdString[i], intern=intern)
      } else if(tsv){
        cmdString.call <- pipe(cmdString[i],open="r")
        result <- read.delim(cmdString.call, header=FALSE, stringsAsFactors=FALSE)
        close(cmdString.call)
        return(result)
      } else if(lines){
        cmdString.call <- pipe(cmdString[i],open="r")
        result <- readLines(cmdString.call)
        close(cmdString.call)
        return(result)
      } else{
        system(cmdString[i])
      }

    })
  } else{
    res<-mclapply(1:length(cmdString), function(i){
      if( i <= threads ){ Sys.sleep(i/100) }
      if(!quiet){print(cmdString[i])}


      if(intern){
        system(cmdString[i], intern=intern)
      } else if(tsv){
        cmdString.call <- pipe(cmdString[i],open="r")
        result <- read.delim(cmdString.call, header=FALSE, stringsAsFactors=FALSE)
        close(cmdString.call)
        return(result)
      } else if(lines){
        cmdString.call <- pipe(cmdString[i],open="r")
        result <- readLines(cmdString.call)
        close(cmdString.call)
        return(result)
      } else{
        system(cmdString[i])
      }


    }, mc.cores=threads, mc.preschedule=FALSE)
  }

  return(res)

}
