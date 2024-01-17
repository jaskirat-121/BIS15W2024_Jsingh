---
title: "Lab 2 Homework"
author: "Jaskirat Singh"
date: "2024-01-16"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. 

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

1. What is a vector in R?  

In R, a vector is a common way of organizing data. It is a way to store a list of items that are of the same type such as numeric or integers for example. 

2. What is a data matrix in R?  

A data matrix is a series of stacked vectors similar to a data table. They arrange the same data type in fixed number of rows and columns. 

3. Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of eight hot springs. Run this code chunk to create the vectors.  

```r
spring_1 <- c(36.25, 35.40, 35.30)
spring_2 <- c(35.15, 35.35, 33.35)
spring_3 <- c(30.70, 29.65, 29.20)
spring_4 <- c(39.70, 40.05, 38.65)
spring_5 <- c(31.85, 31.40, 29.30)
spring_6 <- c(30.20, 30.65, 29.75)
spring_7 <- c(32.90, 32.50, 32.80)
spring_8 <- c(36.80, 36.45, 33.15)
```

4. Build a data matrix that has the springs as rows and the columns as scientists.  


```r
hot_springs <- c(spring_1, spring_2, spring_3, spring_4, spring_5, spring_6, spring_7, spring_8)
hot_springs
```

```
##  [1] 36.25 35.40 35.30 35.15 35.35 33.35 30.70 29.65 29.20 39.70 40.05 38.65
## [13] 31.85 31.40 29.30 30.20 30.65 29.75 32.90 32.50 32.80 36.80 36.45 33.15
```

```r
hot_springs_temp_matrix <- matrix(hot_springs, nrow = 8, byrow = T)
hot_springs_temp_matrix
```

```
##       [,1]  [,2]  [,3]
## [1,] 36.25 35.40 35.30
## [2,] 35.15 35.35 33.35
## [3,] 30.70 29.65 29.20
## [4,] 39.70 40.05 38.65
## [5,] 31.85 31.40 29.30
## [6,] 30.20 30.65 29.75
## [7,] 32.90 32.50 32.80
## [8,] 36.80 36.45 33.15
```


```r
scientist <- c("Jill", "Steve", "Susan")
scientist
```

```
## [1] "Jill"  "Steve" "Susan"
```


```r
colnames(hot_springs_temp_matrix) <- scientist
hot_springs_temp_matrix
```

```
##       Jill Steve Susan
## [1,] 36.25 35.40 35.30
## [2,] 35.15 35.35 33.35
## [3,] 30.70 29.65 29.20
## [4,] 39.70 40.05 38.65
## [5,] 31.85 31.40 29.30
## [6,] 30.20 30.65 29.75
## [7,] 32.90 32.50 32.80
## [8,] 36.80 36.45 33.15
```

5. The names of the springs are 1.Bluebell Spring, 2.Opal Spring, 3.Riverside Spring, 4.Too Hot Spring, 5.Mystery Spring, 6.Emerald Spring, 7.Black Spring, 8.Pearl Spring. Name the rows and columns in the data matrix. Start by making two new vectors with the names, then use `colnames()` and `rownames()` to name the columns and rows.


```r
actual_location <- c("Bluebell_spring", "Opal_spring", "Riverside_spring", "Too_hot_spring", "Mystery_spring", "Emerald_spring", "Black_spring", "Pearl-spring")
```


```r
rownames(hot_springs_temp_matrix) <- actual_location
hot_springs_temp_matrix
```

```
##                   Jill Steve Susan
## Bluebell_spring  36.25 35.40 35.30
## Opal_spring      35.15 35.35 33.35
## Riverside_spring 30.70 29.65 29.20
## Too_hot_spring   39.70 40.05 38.65
## Mystery_spring   31.85 31.40 29.30
## Emerald_spring   30.20 30.65 29.75
## Black_spring     32.90 32.50 32.80
## Pearl-spring     36.80 36.45 33.15
```

6. Calculate the mean temperature of all eight springs.


```r
Bluebell_spring_mean <- hot_springs_temp_matrix[1, ]
Bluebell_spring_mean <- mean(Bluebell_spring_mean)
Opal_spring_mean <- hot_springs_temp_matrix[2, ]
Opal_spring_mean <- mean(Opal_spring_mean)
Riverside_spring_mean <- hot_springs_temp_matrix[3, ]
Riverside_spring_mean <- mean(Riverside_spring_mean)
Too_hot_spring_mean <- hot_springs_temp_matrix[4, ]
Too_hot_spring_mean <- mean(Too_hot_spring_mean)
Mystery_spring_mean <- hot_springs_temp_matrix[5, ]
Mystery_spring_mean <- mean(Mystery_spring_mean)
Emerald_spring_mean <- hot_springs_temp_matrix[6, ]
Emerald_spring_mean <- mean(Emerald_spring_mean)
Black_spring_mean <- hot_springs_temp_matrix[7, ]
Black_spring_mean <- mean(Black_spring_mean)
Pearl_spring_mean <- hot_springs_temp_matrix[8, ]
Pearl_spring_mean <- mean(Pearl_spring_mean)
```

7. Add this as a new column in the data matrix.  


```r
spring_means <- c(Bluebell_spring_mean, Opal_spring_mean, Riverside_spring_mean, Too_hot_spring_mean, Mystery_spring_mean, Emerald_spring_mean, Black_spring_mean, Pearl_spring_mean)
hot_springs_temp_matrix <- cbind(hot_springs_temp_matrix, spring_means)
hot_springs_temp_matrix
```

```
##                   Jill Steve Susan spring_means
## Bluebell_spring  36.25 35.40 35.30     35.65000
## Opal_spring      35.15 35.35 33.35     34.61667
## Riverside_spring 30.70 29.65 29.20     29.85000
## Too_hot_spring   39.70 40.05 38.65     39.46667
## Mystery_spring   31.85 31.40 29.30     30.85000
## Emerald_spring   30.20 30.65 29.75     30.20000
## Black_spring     32.90 32.50 32.80     32.73333
## Pearl-spring     36.80 36.45 33.15     35.46667
```


8. Show Susan's value for Opal Spring only.


```r
hot_springs_temp_matrix[2,3]
```

```
## [1] 33.35
```


9. Calculate the mean for Jill's column only.  


```r
Jill_mean <- hot_springs_temp_matrix[ ,1]
mean(Jill_mean)
```

```
## [1] 34.19375
```

10. Use the data matrix to perform one calculation or operation of your interest.


```r
#find the average temperature from all 8 springs combined
Overall_mean <- hot_springs_temp_matrix[ ,4]
mean(Overall_mean)
```

```
## [1] 33.60417
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
