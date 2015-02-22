# run_analysis

Coursera Getting and Cleaning Data

There are two files together with this one:

1. run_analisys.r: Contains the r function run_analisys() that performs the following tasks:
	* Reads the eight files needed to perform the analysis requested
	* Selects the variables refered to means or standard deviations
	* Assigns labels to every set of data
	* Joins the two sets of date (means and standard deviations)
	* Joins the resulting dataset with Subject and Activity datasets
	* Merges the resulting dataset with the Activity labels file int order to get every activity description 
	* Exports arranged result to a txt file called "./UCI HAR Dataset/Tidy_data.txt"
	* Returns the same arranged dataset

2. CodeBook.md: Contains a description of every field that can be found in the file exported by the  funcion run_analisys.r.


Note: This script starts with the assumption that the Samsung data is available in the working directory in an unzipped UCI HAR Dataset folder 