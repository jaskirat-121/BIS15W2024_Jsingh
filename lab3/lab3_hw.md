---
title: "Lab 3 Homework"
author: "Jaskirat Singh"
date: "2024-01-20"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

### Mammals Sleep  
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R. The name of the data is `msleep`.  

```r
msleep <- msleep
```

2. Store these data into a new data frame `sleep`.  

```r
sleep <- data.frame(msleep)
```

3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

```r
dim(sleep)
```

```
## [1] 83 11
```
The dimensions of this data frame are 83 rows(observations) by 11 columns(variables).

4. Are there any NAs in the data? How did you determine this? Please show your code.  

```r
anyNA(sleep)
```

```
## [1] TRUE
```
There are NAs in the data. Running the above command gives a result of TRUE meaning NA are present in the sleep data frame. 

5. Show a list of the column names is this data frame.

```r
colnames(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

6. How many herbivores are represented in the data?  

```r
table(sleep$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```
There are 32 herbivores represented in the data. 

7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 19kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
small <- filter(sleep, bodywt <= 19)
large <- filter(sleep, bodywt >= 200)
```

8. What is the mean weight for both the small and large mammals?

```r
large_weight <- large[ ,11]
mean(large_weight)
```

```
## [1] 1747.071
```


```r
small_weight <- small[ ,11]
mean(small_weight)
```

```
## [1] 1.797847
```

9. Using a similar approach as above, do large or small animals sleep longer on average?  


```r
small_sleep <- small[ ,6]
mean(small_sleep)
```

```
## [1] 11.78644
```

```r
large_sleep <- large[ ,6]
mean(large_sleep)
```

```
## [1] 3.3
```
On average small animals sleep longer. 

10. Which animal is the sleepiest among the entire dataframe?

```r
max(sleep$sleep_total)
```

```
## [1] 19.9
```

```r
filter(sleep, sleep_total==19.9)
```

```
##               name  genus    vore      order conservation sleep_total sleep_rem
## 1 Little brown bat Myotis insecti Chiroptera         <NA>        19.9         2
##   sleep_cycle awake brainwt bodywt
## 1         0.2   4.1 0.00025   0.01
```
In the entire data frame the sleepiest animal is the Little Brown Bat. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
