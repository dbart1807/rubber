bedCenters <-
function( bedfile, buffer="10G" ){
	if(length(bedfile) > 1){stop("bedCenters can only take 1 file")}
	#MAKE FILE OF FRAGMENT CENTERS
	outname<-paste(basename(removeext(bedfile)),"_centers.bed",sep="")
	cat("calculating fragment centers\n")
	system(paste0("awk '{a=int(($2+$3)/2+0.5); $2=a; $3=a+1;print}' OFS='\t' ",bedfile," | sort -T . -S ",buffer," -k1,1 -k2,2n > ",outname))
	return(outname)
}
