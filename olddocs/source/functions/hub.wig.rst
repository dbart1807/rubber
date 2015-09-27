###############
*hub.wig*
###############
add a wiggle track to a track hub

**************************************************************************
description
**************************************************************************

``hub.wig`` creates a data track of bigWig files on a UCSC genome browser track hub.

**************************************************************************
usage
**************************************************************************

::

  hub.wig ( trackfiles, hubloc , range = c(-50,50) , 
  parentname = NULL , multiwig = FALSE , composite = FALSE , 
  tracknames = basename(removeext(trackfiles)) , plotcolors = rainbow(length(trackfiles)) , altcolors = plotcolors )


**************************************************************************
arguments
**************************************************************************

===========================      ===============================================================================================================================================================================================================
 Main options                     Description
===========================      ===============================================================================================================================================================================================================
**trackfiles**                      character vector of file names of data to be stored in a matrix. Can be supplied in bedGraph, wiggle, or bigWig format. If interval data is provided (bed, bigBed, sam, bam, narrowPeak, or broadPeak) as a scorefile, mat.make will calculate and store interval densities.
**hubloc**                          string containing user, hostname, and path to genome folder within track hub, in the form of "user@hostname:path/to/genomedirectory"
**range**                           numeric vector of length 2 specifying the minimum and maximum values that will be displayed when manually defining view range. Should encompass actual data range and is fine to extend far beyond actual data values.
**parentname**                      string defining the name of the parent track to be displayed in the hub. Only used when multiwig == TRUE or composite == TRUE.
**multiwig**                        boolean value indicating if 'trackfiles' should be grouped in a parent track and allowing the tracks to be overlaid on top of each other. Must be FALSE if composite == TRUE.
**composite**                       boolean value indicating if 'trackfiles' should be grouped in a parent track. must be FALSE if multiwig == TRUE.
**tracknames**                      character vector with the same length as 'trackfiles' indicating the names to display for each 'trackfile' in the browser. Default is the file names of 'trackfiles'.
**plotcolors**                      character vector with the same length as 'trackfiles' indicating the colors used to display positive-value data in each 'trackfiles'. Default is to use colors along a rainbow gradient.
**altcolors**                       character vector with the same length as 'trackfiles' indicating the colors used to display negative-value data in each 'trackfiles'. Default is to use 'plotcolors'.
===========================      ===============================================================================================================================================================================================================


**************************************************************************
output
**************************************************************************
``hub.wig`` will create a data track of bigWig files on a UCSC genome browser track hub by performing two tasks. 
First, bigWigs are uploaded to the 'bbi' directory in the genome directory defined in 'hubloc'. 
Second, data defining the track are appended to the trackDb.txt file in the genome directory defined in 'hubloc'. 
Upon creating the track with ``hub.wig``, the track should be visible within several minutes on the genome browser with the track hub loaded. 
The track hub MUST already exist for this function to work. 
An empty hub is available at http://dvera.github.io/rage/data/mytrackhub.tar.gz . 
For more information, see https://genome.ucsc.edu/goldenPath/help/hgTrackHubHelp.html


**************************************************************************
examples
**************************************************************************

make a multiwig track from two bigWigs on a hub 
""""""""""""""""""""""""""""""""""""""""""""""""""

.. highlight:: r

make a list of data sets to create a track with

::

 > bigwigs <- c( "H3K36me3-signal.bw" , "MNase-seq.bw" )

upload them to the user home of dvera on epsilon.bio.fsu.edu where the genome directory is in ~/public_html/hubs/dlv/hg19

::

 > hub.wig ( bigwigs , "dvera@epsilon.bio.fsu.edu:public_html/hubs/dlv/hg19" , parentname = "H3K36me3_and_MNase-seq" , multiwig = TRUE )

