###############
*bed.intersect*
###############
calculate overlap between two sets of intervals

**************************************************************************
description
**************************************************************************

``bed.intersect`` is a wrapper function for 'bedtools intersect', which calculates the overlap between two sets of genomic intervals.

**************************************************************************
usage
**************************************************************************

::

  bed.intersect ( a , b , extraargs = "-u" )


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**a**                               string defining file name of bed file A. Each feature in A is compared to B in search of overlaps.
**b**                               string defining file name of bed file B.
**extraargs**                       extra arguments to be used in bedtools intersect ( see http://bedtools.readthedocs.org/en/latest/content/tools/intersect.html )
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
bed.intersect by default (extraargs = "-u") will "write original A entry once if any overlaps found in B.
In other words, just report the fact at least one overlap was found in B." bed.intersect will return the file name of the resulting file, which will have the syntax [a-file]_x_[b-file].bed

**************************************************************************
examples
**************************************************************************

keep only DHS peaks that overlap with genes
""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > bed.intersect ( "DHS-peaks.bed" , "genes.bed" )
