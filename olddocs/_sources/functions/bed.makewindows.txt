#################
*bed.makewindows*
#################
break up intervals into smaller windows

**************************************************************************
description
**************************************************************************

``bed.makewindows`` takes a set of intervals or a genome and breaks it up into smaller, equally-sized and equally-spaced windows.

**************************************************************************
usage
**************************************************************************

::

  bed.makewindows ( bedfile, windowsize=25, stepsize=windowsize, mergebed=TRUE, mergeflank=0, outname="default", genome=FALSE)


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**bedfile**                         string defining the bed file name or genome file to break up into windows.
**windowsize**                      positive integer specifying size of windows (in bp) to create from 'bedfile'.
**stepsize**                        positive integer specifying distances between intervals (in bp) of windows created.
**mergebed**                        logical value indicating whether to merge the bed file before creating windows. TRUE recommended if intervals in 'bedfile' are not collapsed into contiguous regions. TRUE recommended if you are not sure. Default is TRUE.
**mergeflank**                      positive integer specifying maximum gap size between adjacent intervals when merging 'bedfile'. Only used when mergebed == TRUE.
**outname**                         character strings indicating output bed file name. Default is "default", which uses the syntax [bedfile]_w[windowsize]s[stepsize].bed
**genome**                          logical value indicating if 'bedfile' is a genomefile
===========================      ===============================================================================================================================================================================================================



**************************************************************************
output
**************************************************************************
``bed.makewindows`` takes a set of intervals or a genome and breaks it up into smaller windows, generating a new bed file.


**************************************************************************
examples
**************************************************************************

break up a genome into nonoverlapping 100-bp windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > bed.makewindows ( "/path/to/genomefile" , windowsize = 100 , genome = TRUE )


break up seqcap regions into 100-bp windows at 10-bp step sizes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > bed.makewindows ( "seqcapregions.bed" , windowsize = 100 , stepsize = 10 , mergebed = TRUE )
