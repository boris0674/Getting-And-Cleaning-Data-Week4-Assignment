## First of all I put all the files we need for this assignment
## in a single directory that I set up as the working directory

## first file uploaded is the raw data of the training set

xtrain <- read.table(file="X_train.txt")

## checking the dimension of the dataframe created: the raw data now
## is starting to make a bit more sense, it is comprised of 7352 rows
## and 561 columns, 561 is the number of variables in the features.txt file:

dim(xtrain)

## I upload now the file with the activities (walking, laying etc.)
## matching each of the 561 variables observed

ytrain <- read.table(file="y_train.txt")

## again we see how the number of row is the same (7352):

dim(ytrain)

## I also upload the file with the individuals of the sample
## matching each activity and each of the 561 variables observed

subjecttrain <- read.table(file="subject_train.txt")

## again the same number of rows, 7352:

dim(subjecttrain)

## I create a database with these 3 file

trainingdataframe <- data.frame(subjecttrain, ytrain, xtrain)

## now we have 563 variables and 7352 rows, the first 2 identify the person and the activity
## notice how this dataframe is still pretty raw: no column names are there

dim(trainingdataframe)

## chekcing the first 3 rows and 5 columns to make sure the data is there

trainingdataframe[1:3, 1:5]

## now I repeat the same procedure for test data

xtest <- read.table(file="X_test.txt")

## same number of observed variables (561) and 2947 rows

dim(xtest)

ytest <- read.table(file="y_test.txt")

## number of rows match in this case too:

dim(ytest)

subjecttest <- read.table(file="subject_test.txt")

## here as well:

dim(subjecttest)

## again I create a raw dataframe with no column names,
## this time for the test data

testdataframe <- data.frame(subjecttest, ytest, xtest)

## 563 columns and 2947 rows:

dim(testdataframe)

## Now I upload the file with the variables name

features <- read.table(file="features.txt")

## it us uploaded as a no header dataframe with 2 columns ad 561 rows:
dim(features)

head(features)

## I turn it into a vector keeping only the 2nd column with the names:

features <- features$V2

## I'm curious to see what kind of vector is this:

class(features)

## Apparantly it's factors,
##I want this vector, to be used later in my dataframe, 
## to be made of characters

features <- as.character(features)

## Now it's time to assign names to the columns
## of the 2 dataframes I created before, trainingdataframe and testdataframe
## in order to do that i create  a character vector to assign names
## to the first two variables:

firsttwovariables <- c("subject", "activity")

## then I merge it with the features vector in order
## to create a vector called variables featuring 563 names

variables <- c(firsttwovariables, features)

## I assign this vector to the columns of my 2 dataframes
## with the colnames function

colnames(trainingdataframe) <- variables

## it seems to work for  trainingdataframe:

trainingdataframe[1:5,1:5]

## as well as for the testdataframe

colnames(testdataframe) <- variables

testdataframe[1:5,1:5]


## Now I use the cbind function to create a single dataframe 
## stacking the training data one on top

complete <- rbind(trainingdataframe, testdataframe)

## this data frame has now 10299 rows (7352+2947) and the same number of columns

dim(complete)

## names of columns are still there:

complete[1:5,1:5]

## now I want the data in the column "activity" to be comrehensible,
## instead of 1-2-3-4-5-6, I change those numbers into their original meaning
## as per explained in the activity_labels.txt file:

complete$activity[complete$activity==1] <- "walking"

complete$activity[complete$activity==2] <- "walkingUP"

complete$activity[complete$activity==3] <- "wakingDown"

complete$activity[complete$activity==4] <- "sitting"

complete$activity[complete$activity==5] <- "standing"

complete$activity[complete$activity==6] <- "laying"


## Now I use the grpl fuction to subset our datbase
## keeping only the mean and standard deviation columns
## and of course the first 2 variables with people id and activity

MeansandSTD <- complete[,grepl("mean|std|subject|activity", names(complete))]

## I check the dimensions and the list of names of our new object
## I get 79 columns all involving means and sd and the 2 initial columns
## and still a total of 10299 rows

names(MeansandSTD)

dim(MeansandSTD)

## Now I get the requested average using some functions in the dplyr package
## group_by to allow us to group our datbase into 180 groups
## each for 1 of the 6 activities and 1 of 30 people
## then sumarise_all to get the average for each of them
## I work these functions with the pipe operator

final_means_std <- MeansandSTD %>% group_by(activity, subject) %>%
summarise_all(funs(mean))


## I write this database into a table in a txt file

write.table(final_means_std, file="tidydata.txt", 
row.names=FALSE, col.names=TRUE)

## I read the table into R and check it: it seems fine and dandy:

table_of_means <- read.table(file="tidydata.txt", header=TRUE)

table_of_means[1:180,1:5]






