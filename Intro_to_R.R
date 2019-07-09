#-----------------------------------
#          Introduction to R
#  Summer Training as Research Scholar
#          July 9, 2019
#-----------------------------------




###  R variables 


a <- 3
b = -5  # both assignment can be used, the first one is more traditional and preferred
A <- 7  # R is case sensitive

# Avoid using names c, t, cat, F, T, D as those are built-in functions/constants

#The variable name can contain letters, digits, underscores and dots and 
#start with the letter or dot.
#The variable name cannot contain dollar sign or other special characters.

str.var  <- "oxygen"               # character variable
num.var  <- 15.99                  # numerical variable
bool.var <- TRUE                   # boolean (or logical) variable
bool.var.1 <- F                    # logical values can be abbriviated


### R help 

# Access help file for the R function if the name of the function is known
?sd
help(sd)


# Search for help
??"standard deviation"
help.search("standard deviation")
help.search("analysis of variance")


###   R vectors

# Vector is an array of values of the same type:
# Vectors can be numeric, character or logical. 

# Function c() is used to create a vector from a list of values
num.vector <- c( 5, 7, 9, 11, 4, -1, 0)

# Numeric vectors can be defined in a number of ways:
vals1 <- c (2, -7, 5, 3, -1 )             # concatenation
vals2 <- 25:75                            # range of values
vals3 <- seq(from=0, to=3, by=0.5)        # sequence definition
vals4 <- rep(1, times=7)                  # repeat value
vals5 <- rnorm(5, mean=2, sd=1.5 )        # normally distributed values

# view the values of a variable
# you can also just print the name of the variable at the command prompt
print(vals2)



###   Vector operations in R


# Define 2 vectors ( first with "distance" values and one with "time valuse")
dist <- c(6, 10, 5, 8, 15, 9)
time <- c(0.5, 0.9, 0.4, 0.7, 1.2, 0.85)

# Compute velocity values for each dist-time pair:
velocity <- dist/time   # each element of the first vector will be divided by the element from the second vector with the same index
print(velocity)

# Define a vector with values of body temperature in Fahrenheit
ftemp <- c(97.8, 99.5, 97.9, 102.1, 98.4, 97.7)

# Convert ftem to a vector with values in Celsius
ctemp <- (ftemp - 32) / 9 * 5
print(ctemp)


### vector slicing (subsetting)

x <- c(36.6, 38.2, 36.4, 37.9, 41.0, 39.9, 36.8, 37.5)    # define a numeric vector
x[2]         # returns second element 
x[2:4]       # returns second through 4th elements inclusive
x[c(1,3,5)]  # returns 1st, 3rd and 5th elements
x[-2]        # returns all but 2nd element
x[c(TRUE, FALSE, TRUE, FALSE, FALSE,FALSE, TRUE, FALSE)]   # returns 1st, 3rd, and 7th elements

#compare each element of the vector with a value
x < 37.0

#return only those elements of the vector that satisfy a specific condition
x[ x < 37.0 ]    


# There are a number of functions that are useful to locate a value satidfying specific condition(s)

which.max(x)  # find the (first)maximum element and return its index
which.min(x)
which(x >= 37.0) # find the location of all the elements that satisfy a specific condition



### vector functions:

max(x),   min(x),   sum(x)
mean(x),  sd(), median(x),  range(x)
var(x)                            - simple variance
cor(x,y)                          - correlation between x and y
sort(x), rank(x), order(x)        - sorting
duplicated(x), unique(x)          - unique and repeating values
summary()


###   Missing Values  

x <- c(734, 145, NA, 456, NA)    # define a numeric vector
anyNA(x)              # are there any missing data


# To check which values are missing use is.na() function:
x == NA               # this does not work ! - missing value cannot be compared to anything
is.na(x)              # check if the element in the vector is missing
which(is.na(x))       # which elements are missing


# By default statistical functions will not compute if the data contain missing values:
mean(x)


# To view the arguments that need to be used to remove missing data, read help topic for the function:
?mean

#Perform computation removing missing data
mean(x, na.rm=TRUE)



###      R packages 

#To install package
install.packages("foreign")


# Once package is installed it can be loaded and used:

#Load R package
library(foreign)


###   Reading input files       

# There are many R functions to process files with various formats:
# Some come from base R:

# read.table()
# read.csv()
# read.delim()
# read.fwf()
# scan()
# and many others

# There are a few R packages which provide additional functionality to read files.

#Load R package "foreign"
library(foreign)

# Read data in Stata format
swissdata <- read.dta("http://rcs.bu.edu/classes/STaRS/swissfile.dta")

# Load R package sas7bdat (make sure it is installed! )
library(sas7bdat)

# Read data in SAS format
fhsdata <- read.sas7bdat( "http://rcs.bu.edu/classes/STaRS/fhs.sas7bdat" )



###   Exploring R dataframes    

```{r}
# Read regular csv file:
salt <- read.csv("http://rcs.bu.edu/classes/STaRS/intersalt.csv")


#This data contains median blood pressure, as a fuction of salt intake:

# b - numeric vector
# bp - mean diastolic blood pressure (mm Hg)
# sodium - mean sodium excretion (mmol/24h)
# country 


#Look at the first and last few records
head(salt)
tail(salt)

#Get the list of the columns
names(salt)

#Number of rows:
nrow(salt)

#Number of columns:
ncol(salt)

#Get the structure of the data:
str(salt)

#Get the summary of the data:
summary(salt)


### Numeric data exploratory analysis  


min(salt$bp)
max(salt$bp)
range(salt$bp)
summary(salt$bp)

#Sometimes it is helpful to visualize the data
boxplot( salt$bp  )   
plot(x = salt$sodium, 
     y = salt$bp, 
     xlab = "mean sodium excretion (mmol/24h)",
     ylab = "mean diastolic blood pressure (mm Hg)",
     main = "Diastolic Blood Presure vs Sodium excretion")



### Correlation

# This test is used to test the linear relationship of 2 continious variables
cor.test(salt$bp, salt$sodium)


#The Null Hypothesis : 
#      the true correlation between bp and sodium (blood pressure and salt intake) is 0 (they are independent) 
#The Alternative hypothesis:  
#      true correlation between bp and sodium is not equal to 0. 

#The p-value is less that 0.05 and the 95% CI does not contain 0, 
# so at the significance level of 0.05 we reject null hypothesis and 
# state that there is some (positive) correlation  (0.359) between these 2 variables. 


#  0 < |r| < .3 - weak correlation
# .3 < |r| < .7 - moderate correlation
#      |r| > .7 - strong correlation

# Important:

# The order of the variables in the test is not important
# Correlation provide evidence of association, not causation!
# Correlation values is always between -1 and 1 and does not change if the units of either or both variables change
# Correlation describes linear relationship
# Correlation is strongly affected by outliers (extreme observations)



### Linear Model
lm.res <- lm( bp ~ sodium, data = salt)
summary(lm.res)

# Here we estimated that relationship between the predictor (sodium) and response (bp) variables.
# The summary statistics here reports a number of things. p-value tells us if the model is statistically significant.
# In Linear Regression, the Null Hypothesis is that the coefficient associated with the variables are equal to zero. 
# Multiple R-squared value is equal to the square of the correlation value we calculated in the previous test.

# When the model fits the data;

# R-squared - The higher - the better ( > 0.7)
# F-statistics - The higher the better
# Std. Error - The closer to 0 - the better
# t-statistics - Should be 1.96 for 0.05 significance level


### Shapiro test

# This test is used to check if the sample follows a normal distribution
shapiro.test(salt$sodium)

# The null hypothesis: sample being tested is normally distributed.
# p value for this test is very small (8.758e-06), so we can reject the null hypothesis 
# and state that this sample does not follow a normal distribution.


#  Let's now take a look at the variable bp:
shapiro.test(salt$bp)

# Here the p value  is greater than 0.05 and at the significance level of 0.05 
# we cannot reject the null hypothesis.



### One Sample t-Test

# This test is used to test the mean of a sample from a normal distribution 
t.test(salt$bp, mu=70)

# The null hypothesis: The true mean is equal to 70
# The alternative hypothesis: true mean is not equal to 70
# Since p-value is small (1.703e-05) - less than 0.05, 95% percent CI does not contain the value 70, we can
# reject the NULL hypothesis.


### Two Sample t-TEST


# Let's load some other dataset. It comes with R. 
# This dataset shows the effect of two soporific drugs 
# (increase in hours of sleep compared to control) on 10 patients. 
# There are 3 variables:

# extra: (numeric) increase in hours of sleep
# group: (factor) categorical variable indicating which drug is given
# ID: (factor) patient ID
data(sleep)
head(sleep)
summary(sleep)


#To compare the means of 2 samples:

boxplot(extra ~ group, data = sleep)
t.test(extra ~ group, data = sleep)

# Here the Null Hypothesis is that the true difference between 2 groups is equal to 0
# And Alternative Hypothesis is that it does not equal to 0
# In this test the p-value is above significance level of 0.05 and 
# 95% CI contains 0, so we cannot reject the NULL hypothesis.

# Note, that t.test has a number of options, including alternative which can be set to 
# "two.sided", "less", "greater", depending which test you would like to perform. 
# Using option var.equal you can also specify if the variances 
# of the values in each group are equal or not. 


### One-way ANOVA test

# The one-way analysis of variance (ANOVA) test is an extension 
# of two-samples t.test for comparing means for datasets with more than 2 groups.

# Assumptions:

# The observations are obtained independently and randomly from 
# the population defined by the categorical variable
# The data of each category is normally distributed
# The populations have a common variance.

data("PlantGrowth")
head(PlantGrowth)
summary(PlantGrowth)
boxplot(weight~group, data=PlantGrowth)


# As visible from the side-by-side boxplots, there is some difference 
# in the weights of 3 groups, 
# but we cannot determine from the plot if this difference is significant.


aov.res <- aov(weight~group, data=PlantGrowth)
summary( aov.res )


# As we can see from the summary output the p-value is 0.0159 < 0.05 which indicates that 
# there is a statistically significant difference in weignt between these groups. 
# We can check the confidence intervals for the treatment parameters:
confint(aov.res)


# Important: In one-way ANOVA testsa small p-value indicates that 
# some of the group means are different, but it does not say which ones!

#For multiple pairwise-comparisions we use Tukey test:
TukeyHSD(aov.res)

# This result indicates that the significant difference in between 
# treatment 1 and treatment 2 with the adjusted p-value of 0.012.

# Chategorical Variables:


### Chi-Squred test of independence in R

# The chi-square test is used to analyze the frequency table ( or contengency table) 
# formed by two categorical variables. 
# It evaluates whether there is a significant association between 
# the categories of the two variables. 

treat <- read.csv("http://rcs.bu.edu/classes/STaRS/treatment.csv")
head(treat)
summary(treat)


# In the above dataset there are 2 categorical variables:

# treated - 0 or 1
# improved - 0 or 1

#We would like to test if there is an improvement after the treatment. 
# In other words if these 2 categorical variables are dependent.

# First let's take a look at the tables:

# Frequency table: "treated will be rows, "improved" - columns"
table(treat$treated, treat$improved)

# Proportion table
prop.table(table(treat$treated, treat$improved))


# We can visualize this contingency table with a mosaic plot:
tbl <- table(treat$treated, treat$improved)
mosaicplot( tbl, color = 2:3, las = 2, main = "Improvement vs. Treatment" )

# Compute chi-squred test
chisq.test (tbl)


# The Null Hypothesis is that treated and improved variables are independent.
# In the above test the p-value is 0.03083, so at the significance level of 
# 0.05 we can reject the null hypothesis

