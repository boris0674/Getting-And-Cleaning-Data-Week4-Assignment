# Getting-And-Cleaning-Data-Week4-Assignment


**In this repo you can find several files required to complete the week 4 assignment for the Coursera Getting and Cleaning Data course**

 1. The files were first downloaded each into the working directory
 
 2. The data was then read into R 

 3. A script featured in the run_analys.R file was created with the requested     metrics
 
 4.  Finally the requested dataset was written into the tidydata.txt file and uploaded onto Github

**The Data** 

We used a dataset of observations collected with 2 sensors mounted on a
Samsung Galaxy S II smartphone. The experiment involved 30 participants.

Each of them had to repeat 6 different movements, data was collected along 3 different dimensions of the movements , denominated X, Y, Z.

The initial raw dataset was split into 2 groups: a training dataset and a test dataset.


**Purpose of the assignment**

In R we merged the training and test data together into a single database, on top of that each data was matched to its own specific individual and its
own specific activity. 

We then extracted a subset of columns for the variables involving means and standard deviations. **A new dataset was finally created, calculating the averages, for each individual and activity** for the new, smaller database, as requested by the assignment.


**A brief description of the code**

1- A new merged dataset had to be created from the training and test databases, we achieved that with the cbind function

2- The data had to be matched with each individual and each activity, creating a new dataframe

3- The activity column had to be renamed, that was achieved using the $ symbol to treat it as a separate vector

4- The grepl function allowed us to keep only the mean and std columns
plus of course the individual and activity column

5- Group_by and summarise_all were applied to get the final values
