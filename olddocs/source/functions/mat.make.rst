###############
*mat.make*
###############
align genomic data at specific regions

**************************************************************************
description
**************************************************************************

``mat.make`` creates a matrix of quantitative genomic data ('scorefiles') aligned around a defined distance surrounding genomic intervals ('features'). An example would be a matrix of ChIP-seq read densities 2 kb surrounding TSSs, where each row corresponds to a single TSS, and each column correspond to a window relative to the TSS. This function provides a convenient way to store many different quantitative data focused on regions of interest, and the output matrices are used as inputs to other 'mat.' functions in RAGE, such as mat.heatmap and mat.plotaverages. Importantly, matrices of all 'scorefiles' created at a given 'feature', will have identical dimensions.

**************************************************************************
usage
**************************************************************************

::

  mat.make ( scorefiles, features, regionsize=2000 , windowsize=10 ,
  strand=FALSE , featurecenter=TRUE , start=2 , stop=3 , prunefeaturesto=NULL , narrowpeak=FALSE ,
  maskbed=NULL , bgfiller=0 , prunescores=FALSE , rpm=TRUE , scoremat=TRUE ,
  closest=NULL , cores="max", meta=FALSE, metaflank=1000 , suffix=NULL , fragmats=0 )

**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**scorefiles**                      character vector of file names of data to be stored in a matrix. Can be supplied in bedGraph, wiggle, or bigWig format. If interval data is provided (bed, bigBed, sam, bam, narrowPeak, or broadPeak) as a scorefile, mat.make will calculate and store interval densities.
**featurefiles**                    character vector of file names of genomic intervals to align data in 'scorefiles' to. Can be one of the following formats: bed, bigBed, narrowPeaks
**regionsize**                      positive integer of the distance (in bp) around features to store data. Default is 1000.
**windowsize**                      positive integer of the size (in bp) to bin data in nonoverlapping windows. For a given regionsize, increasing windowsize proportionally decreases the number of columns in matrix. windowsize must be a factor of regionsize. Defaults is 10.
===========================      ===============================================================================================================================================================================================================

|

===========================      ===============================================================================================================================================================================================================
Alignment Options                 Description
===========================      ===============================================================================================================================================================================================================
**strand**                          logical value. When TRUE, reverses scores in rows of minus-stranded features in the output matrix. default is FALSE.
**start**                           positive integer indicating the 'featurefile' column that specifies the 5' coordinate of the feature. Useful when usefeaturecenter=F and you want to align at the 3' end of features. When strand = TRUE, minus-stranded intervals are aligned by column defined by ‘stop’. Ignored when meta = TRUE or narrowPeak = TRUE. Default is 2.
**stop**                            positive integer indicating the 'featurefile' column that specifies the 3' coordinate of the feature. Useful when usefeaturecenter=F and strand = TRUE to align at the 3' end of strand-specific features. Ignored when meta = TRUE or narrowPeak = TRUE. Default is 3.
**featurecenter**                   logical value. When TRUE, aligns the center of matrix on the center of the intervals in featurefiles. Ignored when meta = TRUE or narrowPeak = TRUE. Defaults to FALSE.
**prunefeaturesto**                 character vector of length 1 specifying a bed file name of intervals to intersect featurefiles to before creating the matrix. Useful to prune features outside of regions of interest, such as microarray or sequence-capture regions. Default NULL.
**narrowpeak**                      logical value. When TRUE, if a featurefile is a narrowPeak file, aligns the center of the matrix on the peak summit defined by column 10 in narrowpeak file. Default is FALSE.
===========================      ===============================================================================================================================================================================================================

|

===========================      ===============================================================================================================================================================================================================
Score Options                     Description
===========================      ===============================================================================================================================================================================================================
**maskbed**                         character vector of length 1 specifying a bed file name who’s intervals are the only intervals which should have scores in the matrix, assigning NAs to all other regions. useful to prevent windows outside probed regions from artificially being assigned zeroes. examples include microarray/seqcap probe regions. Default NULL.
**bgfiller**                        character vector of length 1 specifying the value in a matrix to assign windows which have no overlapping scores in a quantitative scorefile. useful to prevent regions with no information from artificially being assigned zeroes. only used when a scorefile is a bedGraph, wig, or bigWig, Default is "0". "NA" is suggested when all informative data is in scorefile.
**prunescores**                     logical value. when TRUE, removes scores in scorefiles that do not overlap with regions included to be used in matrices. May speed up matrix creation for very large scorefiles. default is FALSE.
**rpm**                             logical value. when TRUE, and a scorefile is an interval file such as a bed, bigBed, sam, or bam file, adjusts the calculated coverage in the matrix to RPM defined by the number of lines in the scorefile (RPM = overlapping_reads * 1000000 / file_lines). default isFALSE.
**scoremat**                        logical value. when TRUE, creates score matrices. Set to FALSE to only create fragment-size matrices (fragmats). Defaults to TRUE.
===========================      ===============================================================================================================================================================================================================

|

===========================      ===============================================================================================================================================================================================================
Misc. Options                     Description
===========================      ===============================================================================================================================================================================================================
**fragmats**                        numeric vector of scorefiles indices to create fragment-size matrices for creating v-plots. Defaults to NULL.
**closest**                         bed file name who’s intervals are used to assign names to rows in the matrix based on the nearest interval in featurefiles. Used for example to  assign the closest gene’s name to each transcription-factor binding site defined in featurefiles. Default NULL
**cores**                           positive integer. number of scorefiles to process simultaneously for each featurefile. Defaults to “max”, or all but one core.
**suffix**                          character vector of length 1 specifying a string to append to the featurename in the output files. useful if you are using options to specify different alignment types, such as the ends of genes (you may use suffix="TTS")
===========================      ===============================================================================================================================================================================================================

|

===========================      ===============================================================================================================================================================================================================
Metafeature Options               Description
===========================      ===============================================================================================================================================================================================================
**meta**                            Create a meta-matrix, a matrix that aligned features by their 5’ and 3’ ends by scaling all features to the same size, as defined by ‘regionsize’ (bp). When meta = TRUE, regionsize specified the size (in bp) of meta-features. Defaults to FALSE.
**metaflank**                       When meta = TRUE, determines the distance from the meta features (in bp) to define the matrix boundary. Defaults to 1000.
===========================      ===============================================================================================================================================================================================================


**************************************************************************
value
**************************************************************************
mat.make will create a direcory for each 'feature' you aligned data to, and matrices of 'scorefiles' aligned at each 'feature' will be stored together in each respective 'feature' directory. Directory names will be of the form of featurename_mat[windowsize]. Matrix names will be in the form of scorefile_featurefile.mat[windowsize]. mat.make returns a list of character vectors of relative paths to the resulting matrices, one for each 'feature'. For example, aligning H3K36me3.bw and H3K9ac.bg to TSS.bed and DHS.bed with 10-bp window sizes will result in the following directory structure:


::

  ├── TSS_mat10
  │   ├── H3K36me3_TSS.mat10
  │   ├── H3K9ac_TSS.mat10
  │   ├── TSS.bed
  ├── DHS_mat10
  │   ├── H3K36me3_DHS.mat10
  │   ├── H3K9ac_DHS.mat10
  │   ├── DHS.bed


and will return the following list:
::
  $TSS_mat10
  [1] "TSS_mat10/H3K36me3_TSS.mat10" "TSS_mat10/H3K9ac_TSS.mat10"

  $DHS_mat10
  [1] "DHS_mat10/H3K36me3_DHS.mat10" "DHS_mat10/H3K9ac_DHS.mat10"

When genomic intervals are used to generate scores, apart from calculating their density, mat.make can also create two-dimensional matrix listing the sizes of these intervals.
This type of matrix is useful with paired-end MNase-seq or DNase-seq data which can be used to create fragment size vs distance plots (V-plots, Henikoff et al., 2009).






**************************************************************************
examples
**************************************************************************

align signals at the midpoints of peak calls
""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make a list of data sets to store in matrices

::

 > scores <- c( "H3K36me3-signal.bw" , "MNase-seq.bg" )

make a list of peaks to align your data to

::

 > peaks <- c( "DHS-peaks.bed" , "ctcf-peaks.bed" )

make matrices of signals aligned at peaks. the defaults are to get 2 kb surrounding the midpoints of the features with a window size of 10 bp, translating to 200 windows/columns.

::

 > mat.make ( scores , peaks )



include only peaks that overlap with probes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

::

  > mat.make ( scores , peaks , strand = TRUE , prunefeaturesto = "sequence-capture-probes.bed")




include only peaks that overlap with probes and also omit scores in matrices for regions that are not represented by a probe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


::

  > mat.make ( scores , "genes.bed" , strand = TRUE , usefeaturecenter = FALSE , prunefeaturesto = "sequence-capture-probes.bed" , maskbed = "sequence-capture-probes.bed" )



make matrices of signals aligned at TSSs
""""""""""""""""""""""""""""""""""""""""""""""""""


::

  > mat.make ( scores , "genes.bed" , strand = TRUE , usefeaturecenter = FALSE )



align signals at the ends of genes
""""""""""""""""""""""""""""""""""""""""""""""""""


::

  > mat.make ( scores , "genes.bed" , strand = TRUE , usefeaturecenter = FALSE , start = 3 , stop = 2)



align signals at start codons
""""""""""""""""""""""""""""""""""""""""""""""""""


::

 > mat.make ( scores , "genes.bed" , strand = TRUE , usefeaturecenter = FALSE , start = 7 , stop = 8)
