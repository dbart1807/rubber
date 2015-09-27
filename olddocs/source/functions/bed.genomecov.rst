###############
*bed.genomecov*
###############
compute genomewide feature coverage

**************************************************************************
description
**************************************************************************

``bed.genomecov`` is a wrapper script for 'bedtools genomecov', which computes genomewide coverage of genomic intervals, such as aligned reads.

**************************************************************************
usage
**************************************************************************

::

  bed.genomecov( intervalfile, genomefile , covmode = "-bg" , scalar = "rpm", bam = FALSE )

**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**intervalfile**                    character vector of length 1 specifying the path to the interval file name to calculate genome coverage of. By default, a bed file is expected, unless bam=TRUE.
**genomefile**                      character vector of length 1 specifying the path to genome file specifying the chromosome sizes of the genome.
**covmode**                         character vector of length 1 specifying the output format. Default is "-bg". See details.
**scalar**                          number to multiply coverage by. Default is "rpm", which multiplies the coverage to report intervals per million. 
**bam**                             a logical value indicating if the input interval file is a bam file. default is FALSE (input is a bed file)
===========================      ===============================================================================================================================================================================================================

**************************************************************************
output
**************************************************************************
``bed.genomecov`` will output a bedGraph file of the coverage of intervals at each base pair in the entire genome.
By default (covmode = "-bg"), contiguous regions with the same coverage will be collapsed into the same bedGraph interval. 


**************************************************************************
examples
**************************************************************************

calculate genomewide coverage in reads per million of intervals in a bed file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

	> bed.genomecov ( "H3K36me3-reads.bed" , genomefile = "/path/to/genomefile" )
	[1] "H3K36me3-reads.bg"	
 

calculate genomewide coverage of intervals in a bed file reporting absolute coverage
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

 > bed.genomecov ( "H3K36me3-reads.bed" , genomefile = "/path/to/genomefile" , scalar = 1 )


calculate genomewide coverage of intervals in a bam file 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

::

> bed.genomecov ( "H3K36me3-reads.bam" , genomefile = "/path/to/genomefile" , bam = TRUE )


