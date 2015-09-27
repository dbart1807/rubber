###############
*mat.ops*
###############
perform calculations on matrices

**************************************************************************
description
**************************************************************************

``mat.ops`` can generate a matrix based on basic operations with input matrices

**************************************************************************
usage
**************************************************************************

::

  mat.ops ( matlist1 , matlist2 = NULL , pattern=NULL , outnames = NULL , replacement=NULL , operation="subtract" )


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                       Description
===========================      ===============================================================================================================================================================================================================
 **matlist1**                       a character vector of matrix file names.
 **matlist2**                       a character vector of matrix file names.
 **operation**                      a string specifying what operation to perform. can be "log2", "log10", "antilog2", "antilog10", "ratio" , "log2ratio", "difference", or "mean" see 'output' for details.
 **pattern**                        a string specifying what to replace with 'replacement' in matlist1 file names for the output matrices. only used when performing operations between matlist1 and matlist2 and outnames == NULL.
 **replacement**                    a string specifying what to replace 'pattern' with in matlist1 file names for the output matrices. only used when performing operations between matlist1 and matlist2 and outnames == NULL.
 **outnames**                       a character vector specifying the output matrix file names from operations between matlist1 and matlist2. only used when performing operations between matlist1 and matlist2 and pattern == replacement == NULL.
===========================      ===============================================================================================================================================================================================================



**************************************************************************
output
**************************************************************************
``mat.ops`` will generate one or more matrices from input matrices. All matrices must have identical dimensions, and operations will be performed at each cell in the matrix. There are three modes of operations.

|

* matlist1 contains one matrix, and matlist2 is NULL. One of the following operations may be performed on the matrix:

  * log2
  * log10
  * antilog2
  * antilog10
  * inverse

* matlist1 contains two or more matrices, and matlist2 is NULL. A string must be defined for 'outnames', but not for 'pattern' and 'replacement'. The "mean" may be calculated across all matrices:

* matlist1 contains one or more matrices, and matlist2 contains the same number of matrices. Output matrices can be defined in 'outnames', or strings can be replaced in matlist1 with 'pattern' and 'replacement' arguments. For each matrix pair ( matlist1[1]/matlist2[1] , matlist1[2]/matlist2[2], etc ), one of the following operations may be performed, generating a matrix for each pair:

  * log2ratio
  * ratio
  * difference
  * mean


**************************************************************************
examples
**************************************************************************

log2 transform all the scores in a matrix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > mat.ops ( "H3K36me3_TSS.mat10 , operation = "log2" )



produce a matrix of the average of several matrices from three biological replicates
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make a list of matrix file names

::

 > replicate_mats <- c( "H3K36me3-rep1_TSS.mat10" , "H3K36me3-rep2_TSS.mat10" , "H3K36me3-rep3_TSS.mat10" )

calculate an average matrix from the replicate matrices

::

 > mat.ops ( replicate_mats , operation = "mean" , outnames = "H3K36me3-mean_TSS.mat10" )


calculate the log2 ratio of ChIP-seq matrices versus their corresponding input matrices
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

make a list of matrix file names for ChIP matrices

::

 > chip_mats <- c( "H3K36me3-IP_TSS.mat10" , "H3K27me3-IP_TSS.mat10" , "H3K9ac-IP_TSS.mat10" )


make a list of matrix file names for input matrices

::

 > input_mats <- c( "H3K36me3-input_TSS.mat10" , "H3K27me3-input_TSS.mat10" , "H3K9ac-input_TSS.mat10" )


calculate the log2 ratio of ChIP/input for each pair of matrices, reusing matlist1 names by replacing 'IP' with 'log2IPvsInput'.

::

 > mat.ops ( chip_mats , input_mats , operation = "log2" , pattern = "IP" , replacement = "log2IPvsInput" )

