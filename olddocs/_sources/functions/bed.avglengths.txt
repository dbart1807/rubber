###################
*bed.avglengths*
###################
calculates windowed mean fragment length

**************************************************************************
description
**************************************************************************

``bed.avglengths`` calculates mean fragment length for all non-overlapping windows.

**************************************************************************
usage
**************************************************************************

::

  bed.avglengths ( databedfile , targetfile , windowsize=1000000 , genome=TRUE , fraglenoutfile="default" , numfragoutfile="default")


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**databedfile**                        string defining bed file name of intervals to be parsed.
**targetfile**                     character vector of length 1 specifying the path to file specifying either chromosome sizes of the genome (if genome=TRUE) or a bed file of regions of interest if genome=FALSE (e.g. Sequence Capture regions).
**windowsize**                     size of windows (in bp) for fragment statistics to be calculated.
**genome**                         Boolean indicating whether to process the whole genome (TRUE), and targetfile indicates chromosomes, or specific regions of interest (FALSE), where targetfile is a bed file of regions.
**fraglenoutfile**                 Name of the file to write mean fragment length information.
**numfragoutfile**                 Name of the file to write number of fragments per window information.
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
``bed.avglengths`` generates bedgraph files of the mean fragment length and number of overlapping fragments with one line for each non-overlapping window of size provided by the user..

**************************************************************************
examples
**************************************************************************

Calculated mean fragment length per megabase
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > bed.avglengths ( "MNase-seq-fragments.bed" ,genomefile = "/path/to/genomefile/hg19_chrom.sizes", genome=TRUE , windowsize=1000000 )
