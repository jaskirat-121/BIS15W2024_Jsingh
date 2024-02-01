---
title: "dplyr Superhero"
date: "2024-01-31"
output:
  html_document: 
    theme: spacelab
    toc: true
    toc_float: true
    keep_md: true
---

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries

```r
library("tidyverse")
```

```
## Warning: package 'tidyverse' was built under R version 4.2.3
```

```
## Warning: package 'ggplot2' was built under R version 4.2.3
```

```
## Warning: package 'tibble' was built under R version 4.2.3
```

```
## Warning: package 'tidyr' was built under R version 4.2.3
```

```
## Warning: package 'readr' was built under R version 4.2.3
```

```
## Warning: package 'purrr' was built under R version 4.2.3
```

```
## Warning: package 'dplyr' was built under R version 4.2.3
```

```
## Warning: package 'stringr' was built under R version 4.2.3
```

```
## Warning: package 'forcats' was built under R version 4.2.3
```

```
## Warning: package 'lubridate' was built under R version 4.2.3
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.3     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.0
## ✔ ggplot2   3.4.3     ✔ tibble    3.2.1
## ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## Warning: package 'janitor' was built under R version 4.2.3
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info, Alignment)
```

```
##  Alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  


```r
superhero_info %>% 
  tabyl(Publisher)
```

```
##          Publisher   n     percent valid_percent
##        ABC Studios   4 0.005449591   0.005563282
##          DC Comics 215 0.292915531   0.299026426
##  Dark Horse Comics  18 0.024523161   0.025034771
##       George Lucas  14 0.019073569   0.019471488
##      Hanna-Barbera   1 0.001362398   0.001390821
##      HarperCollins   6 0.008174387   0.008344924
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##       Image Comics  14 0.019073569   0.019471488
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##      Marvel Comics 388 0.528610354   0.539638387
##          Microsoft   1 0.001362398   0.001390821
##       NBC - Heroes  19 0.025885559   0.026425591
##          Rebellion   1 0.001362398   0.001390821
##           Shueisha   4 0.005449591   0.005563282
##      Sony Pictures   2 0.002724796   0.002781641
##         South Park   1 0.001362398   0.001390821
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
##          Wildstorm   3 0.004087193   0.004172462
##               <NA>  15 0.020435967            NA
```

Marvel comics has the highest number of publisher. 


2. Notice that we have some neutral superheros! Who are they? List their names below.  


```r
neutral_name <- superhero_info %>% 
  filter(Alignment == "neutral")
neutral_name$name
```

```
##  [1] "Bizarro"         "Black Flash"     "Captain Cold"    "Copycat"        
##  [5] "Deadpool"        "Deathstroke"     "Etrigan"         "Galactus"       
##  [9] "Gladiator"       "Indigo"          "Juggernaut"      "Living Tribunal"
## [13] "Lobo"            "Man-Bat"         "One-Above-All"   "Raven"          
## [17] "Red Hood"        "Red Hulk"        "Robin VI"        "Sandman"        
## [21] "Sentry"          "Sinestro"        "The Comedian"    "Toad"
```


## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?


```r
superhero_info %>% 
  select(name,Alignment,Race)
```

```
## # A tibble: 734 × 3
##    name          Alignment Race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ℹ 724 more rows
```


## Not Human
4. List all of the superheros that are not human.


```r
not_human <- superhero_info %>% 
  filter(Race != "Human")
  not_human$name
```

```
##   [1] "Abe Sapien"                "Abin Sur"                 
##   [3] "Abomination"               "Abraxas"                  
##   [5] "Ajax"                      "Alien"                    
##   [7] "Amazo"                     "Angel"                    
##   [9] "Angel Dust"                "Anti-Monitor"             
##  [11] "Anti-Venom"                "Apocalypse"               
##  [13] "Aqualad"                   "Aquaman"                  
##  [15] "Archangel"                 "Ardina"                   
##  [17] "Atlas"                     "Atlas"                    
##  [19] "Aurora"                    "Azazel"                   
##  [21] "Beast"                     "Beyonder"                 
##  [23] "Big Barda"                 "Bill Harken"              
##  [25] "Bionic Woman"              "Birdman"                  
##  [27] "Bishop"                    "Bizarro"                  
##  [29] "Black Bolt"                "Black Canary"             
##  [31] "Black Flash"               "Blackout"                 
##  [33] "Blackwulf"                 "Blade"                    
##  [35] "Blink"                     "Bloodhawk"                
##  [37] "Boba Fett"                 "Boom-Boom"                
##  [39] "Brainiac"                  "Brundlefly"               
##  [41] "Cable"                     "Cameron Hicks"            
##  [43] "Captain Atom"              "Captain Marvel"           
##  [45] "Captain Planet"            "Captain Universe"         
##  [47] "Carnage"                   "Century"                  
##  [49] "Cerebra"                   "Chamber"                  
##  [51] "Colossus"                  "Copycat"                  
##  [53] "Crystal"                   "Cyborg"                   
##  [55] "Cyborg Superman"           "Cyclops"                  
##  [57] "Darkseid"                  "Darkstar"                 
##  [59] "Darth Maul"                "Darth Vader"              
##  [61] "Data"                      "Dazzler"                  
##  [63] "Deadpool"                  "Deathlok"                 
##  [65] "Demogoblin"                "Doc Samson"               
##  [67] "Donatello"                 "Donna Troy"               
##  [69] "Doomsday"                  "Dr Manhattan"             
##  [71] "Drax the Destroyer"        "Etrigan"                  
##  [73] "Evil Deadpool"             "Evilhawk"                 
##  [75] "Exodus"                    "Faora"                    
##  [77] "Fin Fang Foom"             "Firestar"                 
##  [79] "Franklin Richards"         "Galactus"                 
##  [81] "Gambit"                    "Gamora"                   
##  [83] "Garbage Man"               "Gary Bell"                
##  [85] "General Zod"               "Ghost Rider"              
##  [87] "Gladiator"                 "Godzilla"                 
##  [89] "Goku"                      "Gorilla Grodd"            
##  [91] "Greedo"                    "Groot"                    
##  [93] "Guy Gardner"               "Havok"                    
##  [95] "Hela"                      "Hellboy"                  
##  [97] "Hercules"                  "Hulk"                     
##  [99] "Human Torch"               "Husk"                     
## [101] "Hybrid"                    "Hyperion"                 
## [103] "Iceman"                    "Indigo"                   
## [105] "Ink"                       "Invisible Woman"          
## [107] "Jar Jar Binks"             "Jean Grey"                
## [109] "Jubilee"                   "Junkpile"                 
## [111] "K-2SO"                     "Killer Croc"              
## [113] "Kilowog"                   "King Kong"                
## [115] "King Shark"                "Krypto"                   
## [117] "Lady Deathstrike"          "Legion"                   
## [119] "Leonardo"                  "Living Tribunal"          
## [121] "Lobo"                      "Loki"                     
## [123] "Magneto"                   "Man of Miracles"          
## [125] "Mantis"                    "Martian Manhunter"        
## [127] "Master Chief"              "Medusa"                   
## [129] "Mera"                      "Metallo"                  
## [131] "Michelangelo"              "Mister Fantastic"         
## [133] "Mister Knife"              "Mister Mxyzptlk"          
## [135] "Mister Sinister"           "MODOK"                    
## [137] "Mogo"                      "Mr Immortal"              
## [139] "Mystique"                  "Namor"                    
## [141] "Nebula"                    "Negasonic Teenage Warhead"
## [143] "Nina Theroux"              "Nova"                     
## [145] "Odin"                      "One-Above-All"            
## [147] "Onslaught"                 "Parademon"                
## [149] "Phoenix"                   "Plantman"                 
## [151] "Polaris"                   "Power Girl"               
## [153] "Power Man"                 "Predator"                 
## [155] "Professor X"               "Psylocke"                 
## [157] "Q"                         "Quicksilver"              
## [159] "Rachel Pirzad"             "Raphael"                  
## [161] "Red Hulk"                  "Red Tornado"              
## [163] "Rhino"                     "Rocket Raccoon"           
## [165] "Sabretooth"                "Sauron"                   
## [167] "Scarlet Spider II"         "Scarlet Witch"            
## [169] "Sebastian Shaw"            "Sentry"                   
## [171] "Shadow Lass"               "Shadowcat"                
## [173] "She-Thing"                 "Sif"                      
## [175] "Silver Surfer"             "Sinestro"                 
## [177] "Siren"                     "Snake-Eyes"               
## [179] "Solomon Grundy"            "Spawn"                    
## [181] "Spectre"                   "Spider-Carnage"           
## [183] "Spock"                     "Spyke"                    
## [185] "Star-Lord"                 "Starfire"                 
## [187] "Static"                    "Steppenwolf"              
## [189] "Storm"                     "Sunspot"                  
## [191] "Superboy-Prime"            "Supergirl"                
## [193] "Superman"                  "Swamp Thing"              
## [195] "Swarm"                     "T-1000"                   
## [197] "T-800"                     "T-850"                    
## [199] "T-X"                       "Thanos"                   
## [201] "Thing"                     "Thor"                     
## [203] "Thor Girl"                 "Toad"                     
## [205] "Toxin"                     "Toxin"                    
## [207] "Trigon"                    "Triton"                   
## [209] "Ultron"                    "Utgard-Loki"              
## [211] "Vegeta"                    "Venom"                    
## [213] "Venom III"                 "Venompool"                
## [215] "Vision"                    "Warpath"                  
## [217] "Wolverine"                 "Wonder Girl"              
## [219] "Wonder Woman"              "X-23"                     
## [221] "Ymir"                      "Yoda"
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".


```r
good_guys <- superhero_info %>% 
    filter(Alignment == "good")
```


```r
bad_guys <- superhero_info %>% 
    filter(Alignment == "bad")
```


6. For the good guys, use the `tabyl` function to summarize their "race".


```r
good_guys %>% 
  tabyl(Race)
```

```
##               Race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```


7. Among the good guys, Who are the Vampires?


```r
vampire_good_guys <- good_guys %>% 
  filter(Race == "Vampire")
vampire_good_guys$name
```

```
## [1] "Angel" "Blade"
```


8. Among the bad guys, who are the male humans over 200 inches in height?


```r
tall_bad_guys <- bad_guys %>% 
  filter(Height >200)
tall_bad_guys$name
```

```
##  [1] "Abomination"    "Alien"          "Amazo"          "Apocalypse"    
##  [5] "Bane"           "Bloodaxe"       "Darkseid"       "Doctor Doom"   
##  [9] "Doctor Doom II" "Doomsday"       "Frenzy"         "Hela"          
## [13] "Killer Croc"    "Kingpin"        "Lizard"         "MODOK"         
## [17] "Omega Red"      "Onslaught"      "Predator"       "Sauron"        
## [21] "Scorpion"       "Solomon Grundy" "Thanos"         "Ultron"        
## [25] "Venom III"
```

9. Are there more good guys or bad guys with green hair? 

```r
table(good_guys$`Hair color`)
```

```
## 
##           Auburn            black            Black            blond 
##               10                3              108                2 
##            Blond             Blue            Brown    Brown / Black 
##               85                1               55                1 
##    Brown / White            Green             Grey           Indigo 
##                4                7                2                1 
##          Magenta          No Hair           Orange   Orange / White 
##                1               37                2                1 
##             Pink           Purple              Red      Red / White 
##                1                1               40                1 
##           Silver Strawberry Blond            White           Yellow 
##                3                4               10                2
```


```r
table(bad_guys$`Hair color`)
```

```
## 
##           Auburn            Black     Black / Blue            blond 
##                3               42                1                1 
##            Blond             Blue            Brown           Brownn 
##               11                1               27                1 
##             Gold            Green             Grey          No Hair 
##                1                1                3               35 
##           Purple              Red       Red / Grey     Red / Orange 
##                3                9                1                1 
## Strawberry Blond            White 
##                3               10
```
There are 7 good guys with green hair and only 1 bad guy with green hair meaning there are more green colored hair in the good guys group. 


10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.


```r
superhero_info %>% 
  filter(Weight <50) %>% 
  arrange((Weight))
```

```
## # A tibble: 19 × 10
##    name      Gender `Eye color` Race  `Hair color` Height Publisher `Skin color`
##    <chr>     <chr>  <chr>       <chr> <chr>         <dbl> <chr>     <chr>       
##  1 Iron Mon… Male   blue        <NA>  No Hair          NA Marvel C… <NA>        
##  2 Groot     Male   yellow      Flor… <NA>            701 Marvel C… <NA>        
##  3 Jack-Jack Male   blue        Human Brown            71 Dark Hor… <NA>        
##  4 Galactus  Male   black       Cosm… Black           876 Marvel C… <NA>        
##  5 Yoda      Male   brown       Yoda… White            66 George L… green       
##  6 Fin Fang… Male   red         Kaka… No Hair         975 Marvel C… green       
##  7 Howard t… Male   brown       <NA>  Yellow           79 Marvel C… <NA>        
##  8 Krypto    Male   blue        Kryp… White            64 DC Comics <NA>        
##  9 Rocket R… Male   brown       Anim… Brown           122 Marvel C… <NA>        
## 10 Dash      Male   blue        Human Blond           122 Dark Hor… <NA>        
## 11 Longshot  Male   blue        Human Blond           188 Marvel C… <NA>        
## 12 Robin V   Male   blue        Human Black           137 DC Comics <NA>        
## 13 Wiz Kid   <NA>   brown       <NA>  Black           140 Marvel C… <NA>        
## 14 Violet P… Female violet      Human Black           137 Dark Hor… <NA>        
## 15 Franklin… Male   blue        Muta… Blond           142 Marvel C… <NA>        
## 16 Swarm     Male   yellow      Muta… No Hair         196 Marvel C… yellow      
## 17 Hope Sum… Female green       <NA>  Red             168 Marvel C… <NA>        
## 18 Jolt      Female blue        <NA>  Black           165 Marvel C… <NA>        
## 19 Snowbird  Female white       <NA>  Blond           178 Marvel C… <NA>        
## # ℹ 2 more variables: Alignment <chr>, Weight <dbl>
```


11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    


```r
update_superhero_table <- superhero_info %>% 
  mutate(height_weight_ratio = Height/Weight) 
```


12. Who has the highest height to weight ratio?  


```r
update_superhero_table %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 11
##    name      Gender `Eye color` Race  `Hair color` Height Publisher `Skin color`
##    <chr>     <chr>  <chr>       <chr> <chr>         <dbl> <chr>     <chr>       
##  1 Groot     Male   yellow      Flor… <NA>            701 Marvel C… <NA>        
##  2 Galactus  Male   black       Cosm… Black           876 Marvel C… <NA>        
##  3 Fin Fang… Male   red         Kaka… No Hair         975 Marvel C… green       
##  4 Longshot  Male   blue        Human Blond           188 Marvel C… <NA>        
##  5 Jack-Jack Male   blue        Human Brown            71 Dark Hor… <NA>        
##  6 Rocket R… Male   brown       Anim… Brown           122 Marvel C… <NA>        
##  7 Dash      Male   blue        Human Blond           122 Dark Hor… <NA>        
##  8 Howard t… Male   brown       <NA>  Yellow           79 Marvel C… <NA>        
##  9 Swarm     Male   yellow      Muta… No Hair         196 Marvel C… yellow      
## 10 Yoda      Male   brown       Yoda… White            66 George L… green       
## # ℹ 724 more rows
## # ℹ 3 more variables: Alignment <chr>, Weight <dbl>, height_weight_ratio <dbl>
```

Groot has the largest height to weight ratio with a height of 701.0 and weight of 4 giving a ratio of 175.25

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  


```r
glimpse(superhero_powers)
```

```
## Rows: 667
## Columns: 168
## $ hero_names                     <chr> "3-D Man", "A-Bomb", "Abe Sapien", "Abi…
## $ Agility                        <lgl> TRUE, FALSE, TRUE, FALSE, FALSE, FALSE,…
## $ `Accelerated Healing`          <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, …
## $ `Lantern Power Ring`           <lgl> FALSE, FALSE, FALSE, TRUE, FALSE, FALSE…
## $ `Dimensional Awareness`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Cold Resistance`              <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Durability                     <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE,…
## $ Stealth                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Absorption`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Flight                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Danger Sense`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Underwater breathing`         <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Marksmanship                   <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Weapons Master`               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Power Augmentation`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Attributes`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Longevity                      <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE,…
## $ Intelligence                   <lgl> FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, …
## $ `Super Strength`               <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TR…
## $ Cryokinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Telepathy                      <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Energy Armor`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Blasts`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Duplication                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Size Changing`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Density Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Stamina                        <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, F…
## $ `Astral Travel`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Audio Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Dexterity                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnitrix                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Super Speed`                  <lgl> TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, …
## $ Possession                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Oriented Powers`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Weapon-based Powers`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Electrokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Darkforce Manipulation`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Death Touch`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Teleportation                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Enhanced Senses`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Telekinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Beams`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Magic                          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ Hyperkinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Jump                           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Clairvoyance                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Dimensional Travel`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Power Sense`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Shapeshifting                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Peak Human Condition`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Immortality                    <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, TRUE,…
## $ Camouflage                     <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE…
## $ `Element Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Phasing                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Astral Projection`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Electrical Transport`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Fire Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Projection                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Summoning                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Memory`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Reflexes                       <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Invulnerability                <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, TRUE,…
## $ `Energy Constructs`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Force Fields`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Self-Sustenance`              <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE…
## $ `Anti-Gravity`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Empathy                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Nullifier`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radiation Control`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Psionic Powers`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Elasticity                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Substance Secretion`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Elemental Transmogrification` <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Technopath/Cyberpath`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Photographic Reflexes`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Seismic Power`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Animation                      <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE…
## $ Precognition                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Fire Resistance`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Absorption`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Hearing`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Nova Force`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Insanity                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Hypnokinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Control`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Natural Armor`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Intangibility                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Sight`               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Molecular Manipulation`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Heat Generation`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Adaptation                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Gliding                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Suit`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Blast`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Probability Manipulation`     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Gravity Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Regeneration                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Light Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Echolocation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Levitation                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Toxin and Disease Control`    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Banish                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Manipulation`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Heat Resistance`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Natural Weapons`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Time Travel`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Smell`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Illusions                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Thirstokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Hair Manipulation`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Illumination                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnipotent                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Cloaking                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Changing Armor`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Cosmic`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ Biokinesis                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Water Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radiation Immunity`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Telescopic`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Toxin and Disease Resistance` <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Spatial Awareness`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Resistance`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Telepathy Resistance`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Molecular Combustion`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnilingualism                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Portal Creation`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Magnetism                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Control Resistance`      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Plant Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Sonar                          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Sonic Scream`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Time Manipulation`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Touch`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Magic Resistance`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Invisibility                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Sub-Mariner`                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Radiation Absorption`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Intuitive aptitude`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Microscopic`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Melting                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Wind Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Super Breath`                 <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE…
## $ Wallcrawling                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Night`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Infrared`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Grim Reaping`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Matter Absorption`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `The Force`                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Resurrection                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Terrakinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Heat`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Vitakinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radar Sense`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Qwardian Power Ring`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Weather Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - X-Ray`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Thermal`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Web Creation`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Reality Warping`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Odin Force`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Symbiote Costume`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Speed Force`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Phoenix Force`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Molecular Dissipation`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Cryo`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnipresent                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omniscient                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
```


13. How many superheros have a combination of agility, stealth, super_strength, stamina?


```r
filtered_powers <- superhero_powers %>% 
  select(hero_names,Agility, Stealth, `Super Strength`, Stamina) %>% 
  filter(Agility == TRUE & Stealth == TRUE & `Super Strength` ==  TRUE & Stamina == TRUE)
filtered_powers$hero_names
```

```
##  [1] "Alex Mercer"       "Angel"             "Ant-Man II"       
##  [4] "Aquaman"           "Batman"            "Black Flash"      
##  [7] "Black Manta"       "Brundlefly"        "Buffy"            
## [10] "Cable"             "Captain Britain"   "Cheetah III"      
## [13] "Darth Maul"        "Gamora"            "Harley Quinn"     
## [16] "Hybrid"            "King Kong"         "Lady Deathstrike" 
## [19] "Legion"            "Martian Manhunter" "Mystique"         
## [22] "Naruto Uzumaki"    "Odin"              "Orion"            
## [25] "Sabretooth"        "Silk"              "Spawn"            
## [28] "Spectre"           "Spider-Girl"       "Spider-Gwen"      
## [31] "Spider-Man"        "Steppenwolf"       "T-1000"           
## [34] "T-X"               "Toxin"             "Ultron"           
## [37] "Venompool"         "Vixen"             "Wolverine"        
## [40] "X-23"
```
There are a total of 40 superheros with all those powers. 

## Your Favorite
14. Pick your favorite superhero and let's see their powers!  


```r
superhero_powers %>% 
  filter(hero_names == "Iron Man") %>% 
  select_if(all)
```

```
## Warning in .p(column, ...): coercing argument of type 'character' to logical
```

```
## # A tibble: 1 × 21
##   `Accelerated Healing` Durability `Energy Absorption` Flight
##   <lgl>                 <lgl>      <lgl>               <lgl> 
## 1 TRUE                  TRUE       TRUE                TRUE  
## # ℹ 17 more variables: `Underwater breathing` <lgl>, Marksmanship <lgl>,
## #   `Super Strength` <lgl>, `Energy Blasts` <lgl>, Stamina <lgl>,
## #   `Super Speed` <lgl>, `Weapon-based Powers` <lgl>, `Energy Beams` <lgl>,
## #   Reflexes <lgl>, `Force Fields` <lgl>, `Power Suit` <lgl>,
## #   `Radiation Immunity` <lgl>, `Vision - Telescopic` <lgl>, Magnetism <lgl>,
## #   Invisibility <lgl>, `Vision - Night` <lgl>, `Vision - Thermal` <lgl>
```


15. Can you find your hero in the superhero_info data? Show their info! 


```r
superhero_info %>% 
  filter(name == "Iron Man")
```

```
## # A tibble: 1 × 10
##   name     Gender `Eye color` Race  `Hair color` Height Publisher   `Skin color`
##   <chr>    <chr>  <chr>       <chr> <chr>         <dbl> <chr>       <chr>       
## 1 Iron Man Male   blue        Human Black           198 Marvel Com… <NA>        
## # ℹ 2 more variables: Alignment <chr>, Weight <dbl>
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
