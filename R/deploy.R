
deploy<-function(message="no message"){
	library(rubber)
	res <- system(paste0("git -C /lustre/maize/home/dlv04c/software/r/rubber/ add /lustre/maize/home/dlv04c/software/r/rubber/ &&\
	git -C /lustre/maize/home/dlv04c/software/r/rubber/ commit -a -m '",message,"' &&\
	git -C /lustre/maize/home/dlv04c/software/r/rubber/ push"))
	library(devtools)
	detach("package:rubber",unload=T)
	install_github("dvera/rubber")
	library(rubber)
}
