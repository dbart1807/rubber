'%ni%' <- Negate('%in%')

lsl<-function(){system("ls -l")}
lsltr<-function(){system("ls -ltr")}
lslSr<-function(){system("ls -lSr")}
lslt<-function(){system("ls -lt")}
lslS<-function(){system("ls -lS")}


cranex <- function(what) {
  url <- paste("https://github.com/search?l=r&q=%22", as.character(substitute(what)), "%22+user%3Acran+language%3AR&ref=searchresults&type=Code&utf8=%E2%9C%93", sep="", collapse="")
  print(url)
}

resizeWindow <- function(){
	if(.Platform$GUI=="X11"){
		.adjustWidth <- function(...){
			options(width=Sys.getenv("COLUMNS"))
			TRUE
		}
		.adjustWidthCallBack <- addTaskCallback(.adjustWidth)
	}
}



randomStrings<-function(n=1,len=12){
	unlist(lapply(1:n, function(x) return(paste(sample(c(rep(0:9,each=5),LETTERS,letters),len,replace=TRUE),collapse='')) ))
}

rerere<-function(message="no message"){
	library(rage)
	res <- system(paste0("git -C /lustre/maize/home/dlv04c/software/r/rage/ add /lustre/maize/home/dlv04c/software/r/rage/ &&\
	git -C /lustre/maize/home/dlv04c/software/r/rage/ commit -a -m '",message,"' &&\
	git -C /lustre/maize/home/dlv04c/software/r/rage/ push"))
	library(devtools)
	detach("package:rage",unload=T)
	install_github("dvera/rage")
	library(rage)
}
rere<-function(){
	#library(rage)
	#res <- system("git -C /lustre/maize/home/dlv04c/software/r/rage/ add /lustre/maize/home/dlv04c/software/r/rage/ &&\
	#git -C /lustre/maize/home/dlv04c/software/r/rage/ commit -a -m 'message' &&\
	#git -C /lustre/maize/home/dlv04c/software/r/rage/ push")
	#library(devtools)
	detach("package:rage",unload=T)
	#install_github("dvera/rage")
	library(rage)
}

shead <- function(filenames, n=10){
	cmdString <- paste("head -n",n,filenames)
  res <- rage.run(cmdString,lines=TRUE, quiet=TRUE)
	dump <- lapply(res,cat,sep="\n")
}
stail <- function(filenames, n=10){
	cmdString <- paste("tail -n",n,filenames)
  res <- rage.run(cmdString,lines=TRUE, quiet=TRUE)
	dump <- lapply(res,cat,sep="\n")
}
sless <- function(filename){
	system(paste("less",filename))
}
scats <- function(filenames, n=10){
	cmdString <- paste("cat",filenames)
  res <- rage.run(cmdString,lines=TRUE, quiet=TRUE)
	dump <- lapply(res,cat,sep="\n")
}



filelines <-
function( filenames, threads=getOption("threads",1L) , quiet=FALSE){
	cmdString <- paste("wc -l",filenames,"| awk '{print $1}'")
	res <- as.numeric( unlist( rage.run( cmdString, threads, intern=TRUE, quiet=quiet ) ) )
	return(res)
}
gunzip <- function( gzfiles, threads=getOption("threads",1L) ){
	numfiles<-length(gzfiles)
	outnames<-removeext(gzfiles)
	cmdString <- paste("gunzip",gzfiles)
	res <- rage.run( cmdString , threads )
	return(outnames)
}



# file finding
files2 <-
function( cmd ){
	files.call <- 	pipe(paste("ls -d",cmd))
	files <- readLines(files.call)
	return(files)
}
files <-
function( x,...){
	parts<-(unlist(strsplit(x,"/")))
	#cat("parts",parts,"\n")
	if(length(parts)>1){
		pth<-paste(parts[1:length(parts)-1],collapse="/")
	}
	else{
		pth="."
	}
	nm<-parts[length(parts)]
	if(length(parts)>1){
		list.files(pattern=glob2rx(nm),path=pth,full.names=TRUE, ... )
	}
	else{
		list.files(pattern=glob2rx(nm), ... )
	}
}
findfiles <-
function( string, path="." ){
	files.call <- pipe(paste("find ",path," -name '",string,"'",sep=""))
	files <- readLines( files.call )
	return(files)
}


# filename extraction / manipulation
getfullpaths <-
function( paths ){
	cmdString <- paste("readlink -f",paths)
	res <- rage.run(cmdString, intern=TRUE)
	return(res)
}
get.prefix <-
function( names,separator){
	for(i in 1:length(names)){
		names[i]<-unlist(lapply(strsplit(names[i],separator),"[",1))
	}
}
get.suffix <-
function( names,separator){
	for(i in 1:length(names)){
		stringvec<-unlist(strsplit(names[i],separator))
		names[i]<-stringvec[length(stringvec)]
	}
	names
}
removeheader <-
function( filename ){

	ext<-file_ext(filename)

	shortname<-basename(removeext(filename))

	outname<-paste(shortname,"_rh.",ext,sep="")

	status <- system(paste("tail -n +2",filename,">",outname))
	if (status==0){system(paste("mv",outname,filename))}

	outname<-basename(filename)

	return(outname)
}
remove.prefix <-
function( names, prefix){
	for(i in 1:length(names)){
		names[i]<-unlist(strsplit(names[i],prefix))[2]
	}
	names
}
remove.suffix <-
function( names,suffix){
	for(i in 1:length(names)){
		names[i]<-unlist(strsplit(names[i],suffix))[1]
	}
	names
}



read.tsv <-
function( tsv, ... ){
	read.table(tsv,stringsAsFactors=FALSE,sep="\t", ... )
}
removeext <-
function( filenames ){
	filenames<-as.character(filenames)
	for(i in 1:length(filenames)){
		namevector<-unlist(strsplit(filenames[i],"\\."))
		filenames[i]<-paste(namevector[1:(length(namevector)-1)],collapse=".")
	}
	filenames
}


write.tsv <-
function( tsv, colnames=FALSE, rownames=FALSE, ... ){
	write.table(tsv,sep="\t",quote=FALSE,col.names=colnames,row.names=rownames, ... )
}

# file naming
uniquefilename <-
function( filename ){
	library(tools)
	if(grepl("\\.",basename(filename))==TRUE){
		ext<-paste(".",file_ext(filename),sep="")
	} else{ ext="" }
	suffixes<-c("",paste("_",1:100,sep=""))
	filenames<-paste(removeext(filename),suffixes,ext,sep="")
	filename<-filenames[which(file.exists(filenames)==FALSE)[1]]
	return(filename)
}
renamefiles <-
function( filelist, pattern="", replacement=""){
	if(pattern==""){stop("YOU MUST SPECIFY 'pattern'\n")}
	filenames<-basename(filelist)
	dirnames<-dirname(filelist)
	outnames<-paste0(dirnames,"/",gsub(pattern,replacement,filenames))
	nametab<-data.frame("before"=filenames,"after"=outnames,stringsAsFactors=FALSE)
	print(nametab)
	for(i in 1:length(filelist)){
		cat("renaming ",filenames[i]," to ",outnames[i],"\n",sep="")
		system(paste("mv",filelist[i],outnames[i]))
	}
}
renamefiles2 <-
function( filelist, pattern="", replacement=""){
	if(pattern==""){stop("YOU MUST SPECIFY 'pattern'\n")}
	cmdString <- paste0 ("rename '",pattern,"' '",replacement,"' ",paste(filelist,collapse=" "))
	print(cmdString)
	system(cmdString)
}

# rotation functions
rotcol <-
function( vec){ vec[,rot(ncol(vec))] }
rotlist <-
function( l ){lapply(c(2:length(l),1),function(x) l[[x]] ) }
rot <-
function( x){(1:x %% x) +1}
rotrow <-
function( vec){ vec[rot(nrow(vec)),] }
rotvec <-
function( vec){ vec[rot(length(vec))] }
