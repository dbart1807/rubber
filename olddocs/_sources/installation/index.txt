#################
*Installation*
#################

Currently, RAGE has only been tested with linux x86_64 architectures. Xcode is required for OS X installations, which is available from the App Store.

**************************************************************************
bedtools
**************************************************************************

bedtools > 2.19 is required for most functions in RAGE. Do not use older versions of bedtools.
Installation of bedtools with package managers may not install version 2.19, so it is recommended that you compile from source.
Instructions to compile from source are below, and official installation instructions can be found here: http://bedtools.readthedocs.org/en/latest/content/installation.html

|

Download the source code at https://github.com/arq5x/bedtools2/archive/master.zip and unzip. Then enter the directory at the command prompt and compile:

::

  cd /path/to/bedtools2-master
  make

OR get the source code from github and compile

::

  git clone http://github.com/arq5x/bedtools2.git
  cd bedtools2
  make


Then you MUST add bedtools bin directory to your $PATH. To do so, add the following line to your ~/.bashrc or ~/.bashprofile, replacing the pathname with the absolute path of the bedtools2 directory:

::
  
  export PATH=/path/to/bedtools2/bin:$PATH




**************************************************************************
UCSC kent source utilities
**************************************************************************
Several functions in RAGE depend on UCSC's kent source utilities. 

|

First, change to a directory you want to install the binaries.

::

  cd ~


To install on linux x86_64:

::

  mkdir ~/kent
  cd ~/kent
  wget -r -np -e robots=off -R 'html' http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/
  mv hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/* .
  rm -rf hgdownload.cse.ucsc.edu

To install on OSX x86_64:

::

  mkdir ~/kent
  cd ~/kent
  wget -r -np -e robots=off -R 'html' http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/
  mv hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/* .
  rm -rf hgdownload.cse.ucsc.edu


For either architecture, you need to then add the following line to ~/.bashrc or ~/.bashprofile, replacing the path name with the absolute path of the binaries:

::
  
  export PATH=/path/to/kent:$PATH


**************************************************************************
R package dependencies
**************************************************************************
The gplots and gtools packages must be installed before installing RAGE. To do so, open R and enter the following:

::

  > install.packages("gtools")
  > install.packages("gplots")

**************************************************************************
Installing the RAGE package in R
**************************************************************************
To install rage, first obtain the source tarball and then install with R CMD INSTALL:

::

  $ wget http://dvera.github.com/rage/rage_1.0.tar.gz
  $ R CMD INSTALL rage_1.0.tar.gz


