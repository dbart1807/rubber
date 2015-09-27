###############
*bg.map*
###############
map bedGraph scores to genomic intervals

**************************************************************************
description
**************************************************************************

``bg.map`` generates a bedGraph file by performing calculations on bedGraph intervals within other genomic intervals. 
For each genomic interval in 'bedfile', ``bg.map`` will perform 'operation' on all overlapping scores in 'bgfile'.

**************************************************************************
usage
**************************************************************************

::

  bg.map ( bgfile, bedfile, operation="mean" , windowsize=25, stepsize=windowsize, filler=0 , printzero=TRUE )


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**bgfile**                         a string defining the bedGraph file name to perform calculations on
**bedfile**                        a string defining the file of intervals within which to perform calculations of the bedGraph intervals.
**operation**                      a string defining the operation to perform on bedGraph intervals overlapping each 'bedfile' interval. See http://bedtools.readthedocs.org/en/latest/content/tools/map.html for other operations.
**windowsize**                     positive integer indicating the size of windows (in bp) in 'bedfile'. Only needs to be defined if windowsize > stepsize.
**stepsize**                       positive integer indicating the distances between intervals (in bp) in 'bedfile'. Only needs to be defined if windowsize > stepsize.
**filler**                         a string or number defining the score to assign windows with no overlapping bedGraph intervals. Default is '0'.
**printzero**                      a boolean value indicating if windows with a value of calculated value of zero should be printed. Default is TRUE.
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
``bg.map`` generates a bedGraph file by performing calculations on bedGraph intervals within other genomic intervals. 
For each genomic interval in 'bedfile', ``bg.map`` will perform 'operation' on all overlapping scores in 'bgfile'. 
The output bedGraph will have identical intervals to 'bedfile', but with the calculated values in column 4.

**************************************************************************
examples
**************************************************************************

perform a sliding-window average of a bedGraph file with 100-bp windows at 10-bp step-sizes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make windows of your microarray data

::

 > w100s10 <- bed.makewindows ( "MNase-CHIP.bg" , windowsize = 100 , stepsize = 10 )

perform a sliding-window average

::

 > bg.map ( "MNase-CHIP.bg" , w100s10 , windowsize = 100 , stepsize = 10 )
