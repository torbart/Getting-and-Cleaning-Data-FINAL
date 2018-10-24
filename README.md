# Getting-and-Cleaning-Data-FINAL PROJECT
Tory Bartelloni

The script was created to match the criteria of the class project in the most simple way that I know how. There is some minor redundancy that can be found, but overall it is clean, short, and accomplishes the goals as I interpreted them.

I have detailed my rationale for each section of the script below. The sections named and described here are also marked in the script file using comments above the portion of the script it is "naming".

Section 1: Merge Training and Test Sets

Merging the data sets was a three step process. The working directory was the UCI HAR Dataset directory. From there I read in the three text files from each sub-directory (train and test) using the read.table function and merged them individually (read and merged the three training text files and then read and merged the three test text files). I merged them using the cbind function to combined them by columns because each file has the same number of observations (rows). 

Once both datasets were read and merged I used the rbind functions to merge them into one file as they had the matching number of columns and were merged in the same order so the columns in each dataset matched up.

I then read the features text file to get column names for all of the observations that were not the activity and subject IDs. using the colnames functions I then named all of the observations using the details of the features text file because the number of features matched the number of columns in the "x" files.


Section 2: Extract Only Measurements on the Mean and Standard Deviation for Each Measurement

In this section I essentially broke down the data frame created in the above sections multiple times, taking only the columns that had the terms "mean" or "std" (standard deviation) and then removed the columns that were not strict measurements (angles and mean frequencies). I also removed and saved the activity and subject ID columns and saved them separately in the environment to be used later.

First, I use the grep function within a data subset ([]) of the data frame created in the above section to search for columns with "mean" in the title and save those columns in an object. Second, I do the same to subset the original data set for all columns with "std". I then use a simple subset to save the subject and activity columns to be used later. Finally, I used the select function combined with the matches function to remove the columns that included the terms used above, but did not provide actual mean or standard deviation measurements of the attributes in the study.


Section 3: Use Descriptive Activity Names to Name the Activities in the Data Set

I leveraged the activity_labels text file in the directory to extract the names and correlating number in the activity column (which was identified as the "y" file for each (test/training) data set due to the span of numbers (1-6). I did this in six separate steps, using the gsub function to replace each number in the object that I created in section two above. Once this object was created I merged the larger data set with both the renamed activities and the subjects (used cbind to connect the object columns to match rows).


Section 4: Appropriately Label the Data Set with Descriptive Variable Names

For this section I leveraged the README and features_info files from the dataset. Based on the features information I segmented the measurements into two categories - Time measurements and Frequency measurements. Therefore, what I ended up with was two "sections" of labels, one labeled Time and one labeled Frequency. Each measurement from Body Acceleration to Body Gyro Jerk was taken from three axes so we have three columns (X, Y, Z axes) for each of these measurement (this is duplicated with the Frequency calculations). We also had individual measurements for Magnitude of the three axes together (also duplicated time and frequency). Lastly, I left the five individual mean measuremtns as this would give a good summary picture.

I then created descriptive, labeled names for each, saved the list in a CSV file, read the CSV into R and applied the list to column names using the colnames function. Lastly, I added the Subject and Activity names to the appropriate columns.


Section 5: Create a Second, Independent Data Set, that is Tidy, with the Average of Each Variable for Each Activity and Each Subject

I started by grouping the data set created above by both Subject and Activity (in that order). Once grouped I used the summarize_all function to calculate the mean for each grouping. Once summarized I used as.data.frame to put it together in an easy to read format.

Thank you for your help with reviewing this assignment! I am interested to see what feedback I get!

