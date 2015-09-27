###############
*bed.words*
###############
plot nucleotide words frequencies over the length of intervals

**************************************************************************
description
**************************************************************************

``bed.words`` plots the frequency of nucleotide words along intervals aligned by their 5' end or their midpoint. Currently only plots dinucleotide frequencies.

**************************************************************************
usage
**************************************************************************

::

  bed.words ( bedfiles, genomefa , pdfname , wordlengths = 2 , numbases=50, sizerange=c(1,Inf), numfrags=NULL, reference="center", symmetric=TRUE , cores="max", lspan=0, slop=0 , strand=FALSE )



**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**bedfiles**                        a vector of bed file names from which to draw nucleotide word frequencies.
**genomefa**                        path to a whole-genome fasta from which to obtain sequences from intervals. chromosome names in fasta and bed must match.
**pdfname**                         name of output pdf. must contain .pdf extension
**numbases**                        number of bases to examine in the 3' direction from the 5' end of the extracted sequences. Must be an even number.
**sizerange**                       numeric vector of length 2 specifying the minimum and maximum sizes of intervals to examine. Default is c(1,Inf), which causes all fragment sizes to be examined.
**numfrags**                        positive integer specifying the number of intervals to sample to calculate nucleotide word frequencies. Default is NULL, which causes all of intervals within constraints of 'sizerange' to be examined.
**reference**                       string defining if intervals should be aligned by their "center" or by their 5' "end". If "center", intervals will be aligned by their center and numbases/2 bp on each side of the midpoint will be examined.
**strand**                          boolean indicating if strand should be taken into account if available in bed file. Default is FALSE.
**slop**                            integer specifying how many bases to shift the 5' base to the 5' (positive integer) or 3' (negative integer) direction before extracting sequences. useful to examine regions flanking (positive) intervals in addition to the interval itself.
**lspan**                           loess span to use when smoothing nucleotide word frequency plots. Default is 0 (no smoothing).
**symmetric**                       boolean value inidicating if the plots shoudl be symmetrized by averaging each side. Default is TRUE.
**cores**                           positive integer specifying the number of files to examine simultaneously.
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
``bed.words`` will output a pdf of nucleotide word plots.

**************************************************************************
examples
**************************************************************************

generate dinucleotide frequency plots of 70 bp on each side of the midpoint of 140-150 bp intervals from two files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make a list of bed file names

::

 > beds <- c( "untreated-MNaseSeqFragments.bed" , "treated-MNaseSeqFragments.bed" )

generate dinucleotide frequency plots

::

 > bed.words ( beds , "/path/to/genome.fa" , "output.pdf" , numbases = 140 , sizerange = c(140,150) , reference = "center" )
