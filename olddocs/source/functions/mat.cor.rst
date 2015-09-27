###############
*mat.cor*
###############
calculate the correlations among matrices

**************************************************************************
description
**************************************************************************

``mat.cor`` calculates the correlations among two or more matrices, examining and plotting their global (whole-matrix) relationships, and relationships at individual rows.

**************************************************************************
usage
**************************************************************************

::

  mat.cors ( mats, numgroups=3 , hcluster=FALSE , plotcolors=c("red","green","black") , legendnames = basename(removeext(mats)) )


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**mats**                            vector of matrix file names from which to calculate correlations.
**numgroups**                       number of groups to generate with k-means clustering of row-by-row correlations.
**hcluster**                        boolean specifying whether to k-means cluster row-by-row correlations among matrices. If TRUE, may take a long time to perform
**plotcolors**                      character vector specifying the colors used to generate color gradient for correlation heatmap from -1 to 1, respectively.
**legendnames**                     character vector specifying names to label 'mats' in plots. must be equal in length to 'mats'
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
``mat.cor`` generates a pdf of plots and a text file of correlations among the input matrices.


**************************************************************************
examples
**************************************************************************

calculate correlations among three matrices
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make a list of matrix file names

::

 > matrices <- c( "H3K36me3-signal_TSS.mat10" , "H3K27me3-signal_TSS.mat10" , "H3K9ac-signal_TSS.mat10" )

calculate correlations

::

 > mat.cor ( matrices )
