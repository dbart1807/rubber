.. RAGE documentation master file, created by
   sphinx-quickstart on Sun Feb  9 09:20:10 2014.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to the RAGE documentation!
==================================

************
installation
************

.. toctree::
   :maxdepth: 1
   :glob:

   installation/*


*********
functions
*********

.. toctree::
   :maxdepth: 1
   :glob:

   functions/*

*************
workflows
*************

.. toctree::
   :maxdepth: 1
   :glob:

   workflows/*


..   generate an aggregate profile of scores aligned at a set of genomic features
..   generate a heatmap of scores aligned at a set of genomic features
..   generate a v-plot of paired-end MNase-seq data at a set of genomic features
..   generate a plot of nucleotide word frequencies at a set of genomic features
..   generate a plot of distances among a set of genomic features
..   calculate the correlations among data sets aligned at a set of genomic features
..   calculate the correlations among data sets from bedGraph or wiggle files
..   calculate the frequency of overlaps among sets of genomic features
..   generate line plots of a series of data sets aligned at a set of genomic features
..   plot a histogram of score distributions from bedGraph or wiggle files
..   plot a histogram of interval sizes from bed or bam files
..   smooth bedGraph or wiggle data with sliding window averages
..   smooth bedGraph or wiggle data with loess smoothing
..   smooth data in matrix-format with sliding window averages
..   smooth data in matrix-format with loess smoothing
..   create overlapping or nonoverlapping windows in a set of genomic intervals or across the entire genome
..   calculate sliding-window averages of bedGraph or wiggle data across the entire genome
..   calculate sliding-window read/feature densities across the entire genome
..   calculate feature/read densities at each base in a given set of intervals or genomewide
..   separate genomic intervals based on their size (bed.parselengths)
..   perform operations between matrices, such as subtracting one matrix of scores from another
..   identify regions of the genome that contain scores exceeding a specific threshold in a bedGraph or wiggle file
..   perform operations between bedGraph or wiggle data, such as subtracting one from another, or calculating the log2 ratio
..   convert a gff to a bedGraph
..   quantile normalize data in bedGraph format
..   quantile normalize data in matrix format
..   merge overlapping or nearby genomic features in a bed file
..   manipulate the coordinates of genomic intervals (bed.slop/utr/clip/recenter)
..   randomly sample lines from a file (bed.sample)
..   add colors to bed files (bed.color)
..   sort bed or bedGraph files (bed.sort)
..   identify the nearest features in one bed file to a set of intervals in another bed file (bed.closest)
..   shuffle the coordinates of a bed file
..   create and modify UCSC Genome Browser track hubs


