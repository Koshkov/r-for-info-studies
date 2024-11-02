# R 101

# Variables and Vectors  
########################

name<-"John Doe"    # String variable
grade<-93.2         # Numeric variable

names<-c("Jim","Jane","Joe") # Vector of names separated by commas

# A vector stores items in a list. Each item has an index
# 1   | 2    | 3
# Jim | Jane | Joe

# You can access individual items in `names` by calling their index
names[1] # Prints "Jim"
names[3] # Prints "Joe"

# Data frames
#############

# Create a simple data frame with student names
# and number grades.
# 
# We will represent the following tabular data
# in an R data.frame
#
# Student        | Grade
# ---------------|------
# Jane Doe       | 92.0
# John Smith     | 88.1 
# Max Mustermann | 82.0
#
# Note: Vectors must be the same length!!!
student_grades<-data.frame(
    Student=c("Jane Doe","John Smith","Max Mustermann"),
    Grade=c(92.0,88.1,82.0)
)

# Accessing values in a data frame 
##################################

student_grades          # Print full data frame 
student_grades$Grade    # Access "Grade" column vector
student_grades$Grade[1] # Get first entry in "Grade"

# Descriptive Statistics
########################

mean(student_grades$Grade) # Get average grade
min(student_grades$Grade)  # Get min grade
max(student_grades$Grade)  # Get max grade

summary(student_grades$Grade) # Do it all at once!
