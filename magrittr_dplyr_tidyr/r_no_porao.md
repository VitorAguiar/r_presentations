magrittr + dplyr + tidyr
========================================================
author: Vitor Aguiar

magrittr
========================================================
type: section

magrittr
=======================================================
title: false
type: sub-section

<big style="font-size:7em"> *%>%* </big>

[Ceci n'est pas une pipe](http://uploads7.wikiart.org/images/rene-magritte/the-treachery-of-images-this-is-not-a-pipe-1948%282%29.jpg)

magrittr operators
=======================================================

*%>%*  

*%T>%*  

*%$%*  

*%<>%*

pipe usage
======================================================


```r
f(x)

# is the same as:

x %>% f()

## with two arguments:
f(x, y)

# is the same as:
x %>% f(y)

## if you don't want the input to be used as 1st argument:
f(y, x)

# is the same as:
x %>% f(y, .)
```

dplyr
=======================================================
type: sub-section

(aka plyr for data frames)


dplyr verbs
=======================================================

filter

slice

group_by

arrange

select

summarise

mutate

demo
======================================================
title: false

We'll use the [gapminder](https://www.youtube.com/watch?v=jbkSRLYSojo) data for a demo


```r
library(gapminder)

str(gapminder)
```

```
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year     : num  1952 1957 1962 1967 1972 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ gdpPercap: num  779 821 853 836 740 ...
```

dplyr demo
======================================================
title: false


```r
library(dplyr)
```


```r
gapminder <- tbl_df(gapminder)

gapminder
```

```
Source: local data frame [1,704 x 6]

       country continent year lifeExp      pop gdpPercap
1  Afghanistan      Asia 1952  28.801  8425333  779.4453
2  Afghanistan      Asia 1957  30.332  9240934  820.8530
3  Afghanistan      Asia 1962  31.997 10267083  853.1007
4  Afghanistan      Asia 1967  34.020 11537966  836.1971
5  Afghanistan      Asia 1972  36.088 13079460  739.9811
6  Afghanistan      Asia 1977  38.438 14880372  786.1134
7  Afghanistan      Asia 1982  39.854 12881816  978.0114
8  Afghanistan      Asia 1987  40.822 13867957  852.3959
9  Afghanistan      Asia 1992  41.674 16317921  649.3414
10 Afghanistan      Asia 1997  41.763 22227415  635.3414
..         ...       ...  ...     ...      ...       ...
```

count
======================================================


```r
gapminder %>% count(country)
```

```
Source: local data frame [142 x 2]

       country  n
1  Afghanistan 12
2      Albania 12
3      Algeria 12
4       Angola 12
5    Argentina 12
6    Australia 12
7      Austria 12
8      Bahrain 12
9   Bangladesh 12
10     Belgium 12
..         ... ..
```

filter and select
======================================================


```r
gapminder %>%
  filter(country == "Brazil", year >= 1980) %>%
  select(year, pop, lifeExp, gdpPercap)
```

```
Source: local data frame [6 x 4]

  year       pop lifeExp gdpPercap
1 1982 128962939  63.336  7030.836
2 1987 142938076  65.205  7807.096
3 1992 155975974  67.057  6950.283
4 1997 168546719  69.388  7957.981
5 2002 179914212  71.006  8131.213
6 2007 190010647  72.390  9065.801
```

arrange
======================================================


```r
gapminder %>%
  arrange(lifeExp) %>%
  slice(1:10)
```

```
Source: local data frame [10 x 6]

        country continent year lifeExp     pop gdpPercap
1        Rwanda    Africa 1992  23.599 7290203  737.0686
2   Afghanistan      Asia 1952  28.801 8425333  779.4453
3        Gambia    Africa 1952  30.000  284320  485.2307
4        Angola    Africa 1952  30.015 4232095 3520.6103
5  Sierra Leone    Africa 1952  30.331 2143249  879.7877
6   Afghanistan      Asia 1957  30.332 9240934  820.8530
7      Cambodia      Asia 1977  31.220 6978607  524.9722
8    Mozambique    Africa 1952  31.286 6446316  468.5260
9  Sierra Leone    Africa 1957  31.570 2295678 1004.4844
10 Burkina Faso    Africa 1952  31.975 4469979  543.2552
```

arrange by multiple variables
======================================================


```r
gapminder %>%
  arrange(desc(pop), gdpPercap, lifeExp)
```

```
Source: local data frame [1,704 x 6]

   country continent year  lifeExp        pop gdpPercap
1    China      Asia 2007 72.96100 1318683096 4959.1149
2    China      Asia 2002 72.02800 1280400000 3119.2809
3    China      Asia 1997 70.42600 1230075000 2289.2341
4    China      Asia 1992 68.69000 1164970000 1655.7842
5    India      Asia 2007 64.69800 1110396331 2452.2104
6    China      Asia 1987 67.27400 1084035000 1378.9040
7    India      Asia 2002 62.87900 1034172547 1746.7695
8    China      Asia 1982 65.52500 1000281000  962.4214
9    India      Asia 1997 61.76500  959000000 1458.8174
10   China      Asia 1977 63.96736  943455000  741.2375
..     ...       ...  ...      ...        ...       ...
```

group_by + summarise
======================================================


```r
gapminder %>%
  group_by(continent) %>%
  summarise(avg_gdp = mean(gdpPercap))
```

```
Source: local data frame [5 x 2]

  continent   avg_gdp
1    Africa  2193.755
2  Americas  7136.110
3      Asia  7902.150
4    Europe 14469.476
5   Oceania 18621.609
```

group_by + summarise: multiple grouping variables
=====================================================


```r
gapminder %>%
  group_by(continent, year) %>%
  summarise(avg_gdp = mean(gdpPercap))
```

```
Source: local data frame [60 x 3]
Groups: continent

   continent year  avg_gdp
1     Africa 1952 1252.572
2     Africa 1957 1385.236
3     Africa 1962 1598.079
4     Africa 1967 2050.364
5     Africa 1972 2339.616
6     Africa 1977 2585.939
7     Africa 1982 2481.593
8     Africa 1987 2282.669
9     Africa 1992 2281.810
10    Africa 1997 2378.760
..       ...  ...      ...
```

summarise: multiple variables
=====================================================


```r
gapminder %>%
  group_by(continent) %>%
  summarise_each(funs(mean), lifeExp, gdpPercap, pop)
```

```
Source: local data frame [5 x 4]

  continent  lifeExp gdpPercap      pop
1    Africa 48.86533  2193.755  9916003
2  Americas 64.65874  7136.110 24504795
3      Asia 60.06490  7902.150 77038722
4    Europe 71.90369 14469.476 17169765
5   Oceania 74.32621 18621.609  8874672
```

summarise: mutiple functions & multiple variables
======================================================


```r
gapminder %>%
  group_by(continent) %>%
  summarise_each(funs(mean, sd), lifeExp, gdpPercap)
```

```
Source: local data frame [5 x 5]

  continent lifeExp_mean gdpPercap_mean lifeExp_sd gdpPercap_sd
1    Africa     48.86533       2193.755   9.150210     2827.930
2  Americas     64.65874       7136.110   9.345088     6396.764
3      Asia     60.06490       7902.150  11.864532    14045.373
4    Europe     71.90369      14469.476   5.433178     9355.213
5   Oceania     74.32621      18621.609   3.795611     6358.983
```

mutate
=====================================================


```r
gapminder %>% mutate(total_gdp = gdpPercap * pop)
```

```
Source: local data frame [1,704 x 7]

       country continent year lifeExp      pop gdpPercap   total_gdp
1  Afghanistan      Asia 1952  28.801  8425333  779.4453  6567086330
2  Afghanistan      Asia 1957  30.332  9240934  820.8530  7585448670
3  Afghanistan      Asia 1962  31.997 10267083  853.1007  8758855797
4  Afghanistan      Asia 1967  34.020 11537966  836.1971  9648014150
5  Afghanistan      Asia 1972  36.088 13079460  739.9811  9678553274
6  Afghanistan      Asia 1977  38.438 14880372  786.1134 11697659231
7  Afghanistan      Asia 1982  39.854 12881816  978.0114 12598563401
8  Afghanistan      Asia 1987  40.822 13867957  852.3959 11820990309
9  Afghanistan      Asia 1992  41.674 16317921  649.3414 10595901589
10 Afghanistan      Asia 1997  41.763 22227415  635.3414 14121995875
..         ...       ...  ...     ...      ...       ...         ...
```

mutate_each
====================================================


```r
gapminder %>% 
  mutate_each(funs(min_rank), lifeExp, gdpPercap, pop)
```

```
Source: local data frame [1,704 x 6]

       country continent year lifeExp  pop gdpPercap
1  Afghanistan      Asia 1952       2  943       227
2  Afghanistan      Asia 1957       6  999       255
3  Afghanistan      Asia 1962      11 1067       274
4  Afghanistan      Asia 1967      25 1129       262
5  Afghanistan      Asia 1972      45 1169       202
6  Afghanistan      Asia 1977      83 1208       231
7  Afghanistan      Asia 1982     115 1161       344
8  Afghanistan      Asia 1987     153 1181       273
9  Afghanistan      Asia 1992     173 1229       141
10 Afghanistan      Asia 1997     177 1317       134
..         ...       ...  ...     ...  ...       ...
```

data %>% plot
=====================================================


```r
library(ggplot2)

gapminder %>%
  mutate(total_gdp = gdpPercap * pop) %>% 
  group_by(continent, year) %>%
  summarise(total_gdp = sum(total_gdp)) %>%
  ggplot(data = ., aes(x = year, y = total_gdp, color = continent)) + 
    geom_line()
```

<img src="r_no_porao-figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />


tidyr
=======================================================
type: sub-section


Plant height data measured in 3 different months
=======================================================


```
Source: local data frame [20 x 4]

   individual 2015/01/01 2015/02/01 2015/03/01
1        5_SP   14.22933   15.75975   18.48201
2       16_SP   14.45462   14.78112   20.33305
3        8_SP   16.18649   15.06560   20.48783
4        7_SP   14.98208   14.12724   19.76832
5       13_SP   13.56391   14.41580   21.39035
6        4_SP   14.63515   16.13685   19.21934
7       18_SP   12.79774   15.85212   19.41728
8        6_SP   16.06800   16.17829   21.63142
9       12_SP   15.48879   15.91310   22.43958
10      15_SP   16.05907   16.50061   19.98071
11      14_MG   15.32373   17.34162   19.55093
12      11_MG   14.57310   18.13978   22.20221
13      10_MG   15.18629   17.00387   21.14213
14      19_MG   16.36968   14.63451   20.20894
15       9_MG   15.37158   14.98246   22.99897
16       2_MG   15.09442   16.02932   19.89372
17       1_MG   15.34408   15.08237   20.23197
18      17_MG   16.38847   14.92077   21.11207
19       3_MG   15.26179   16.55627   18.79709
20      20_MG   14.10760   15.99539   20.24941
```

tidyr verbs
=======================================================

gather 

spread

separate

unite

extract

gather: 'long' or 'narrow' format
======================================================


```r
library(magrittr)
library(tidyr)

plant_height %<>% gather(key=date, value=height, 2:4)

plant_height
```

```
Source: local data frame [60 x 3]

   individual       date   height
1        5_SP 2015/01/01 14.22933
2       16_SP 2015/01/01 14.45462
3        8_SP 2015/01/01 16.18649
4        7_SP 2015/01/01 14.98208
5       13_SP 2015/01/01 13.56391
6        4_SP 2015/01/01 14.63515
7       18_SP 2015/01/01 12.79774
8        6_SP 2015/01/01 16.06800
9       12_SP 2015/01/01 15.48879
10      15_SP 2015/01/01 16.05907
..        ...        ...      ...
```

spread
======================================================


```r
plant_height %>% spread(date, height)
```

```
Source: local data frame [20 x 4]

   individual 2015/01/01 2015/02/01 2015/03/01
1       10_MG   15.18629   17.00387   21.14213
2       11_MG   14.57310   18.13978   22.20221
3       12_SP   15.48879   15.91310   22.43958
4       13_SP   13.56391   14.41580   21.39035
5       14_MG   15.32373   17.34162   19.55093
6       15_SP   16.05907   16.50061   19.98071
7       16_SP   14.45462   14.78112   20.33305
8       17_MG   16.38847   14.92077   21.11207
9       18_SP   12.79774   15.85212   19.41728
10      19_MG   16.36968   14.63451   20.20894
11       1_MG   15.34408   15.08237   20.23197
12      20_MG   14.10760   15.99539   20.24941
13       2_MG   15.09442   16.02932   19.89372
14       3_MG   15.26179   16.55627   18.79709
15       4_SP   14.63515   16.13685   19.21934
16       5_SP   14.22933   15.75975   18.48201
17       6_SP   16.06800   16.17829   21.63142
18       7_SP   14.98208   14.12724   19.76832
19       8_SP   16.18649   15.06560   20.48783
20       9_MG   15.37158   14.98246   22.99897
```

separate
======================================================


```r
plant_height %<>% 
  separate(individual, into = c("id_number", "state")) %>%
  mutate(id_number = as.numeric(id_number)) %>%
  arrange(id_number, state)

plant_height
```

```
Source: local data frame [60 x 4]

   id_number state       date   height
1          1    MG 2015/01/01 15.34408
2          1    MG 2015/02/01 15.08237
3          1    MG 2015/03/01 20.23197
4          2    MG 2015/01/01 15.09442
5          2    MG 2015/02/01 16.02932
6          2    MG 2015/03/01 19.89372
7          3    MG 2015/01/01 15.26179
8          3    MG 2015/02/01 16.55627
9          3    MG 2015/03/01 18.79709
10         4    SP 2015/01/01 14.63515
..       ...   ...        ...      ...
```

extract
======================================================


```r
plant_height %<>% 
  extract(date, c("year", "month", "day"), "(\\d+)/(\\d+)/(\\d+)")

plant_height
```

```
Source: local data frame [60 x 6]

   id_number state year month day   height
1          1    MG 2015    01  01 15.34408
2          1    MG 2015    02  01 15.08237
3          1    MG 2015    03  01 20.23197
4          2    MG 2015    01  01 15.09442
5          2    MG 2015    02  01 16.02932
6          2    MG 2015    03  01 19.89372
7          3    MG 2015    01  01 15.26179
8          3    MG 2015    02  01 16.55627
9          3    MG 2015    03  01 18.79709
10         4    SP 2015    01  01 14.63515
..       ...   ...  ...   ... ...      ...
```

unite 
======================================================


```r
plant_height %>% unite(date, year:day, sep = "/")
```

```
Source: local data frame [60 x 4]

   id_number state       date   height
1          1    MG 2015/01/01 15.34408
2          1    MG 2015/02/01 15.08237
3          1    MG 2015/03/01 20.23197
4          2    MG 2015/01/01 15.09442
5          2    MG 2015/02/01 16.02932
6          2    MG 2015/03/01 19.89372
7          3    MG 2015/01/01 15.26179
8          3    MG 2015/02/01 16.55627
9          3    MG 2015/03/01 18.79709
10         4    SP 2015/01/01 14.63515
..       ...   ...        ...      ...
```

transpose data frame
======================================================


```r
plant_height %>% spread(id_number, height)
```

```
Source: local data frame [6 x 24]

  state year month day        1        2        3        4        5
1    MG 2015    01  01 15.34408 15.09442 15.26179       NA       NA
2    MG 2015    02  01 15.08237 16.02932 16.55627       NA       NA
3    MG 2015    03  01 20.23197 19.89372 18.79709       NA       NA
4    SP 2015    01  01       NA       NA       NA 14.63515 14.22933
5    SP 2015    02  01       NA       NA       NA 16.13685 15.75975
6    SP 2015    03  01       NA       NA       NA 19.21934 18.48201
Variables not shown: 6 (dbl), 7 (dbl), 8 (dbl), 9 (dbl), 10 (dbl), 11
  (dbl), 12 (dbl), 13 (dbl), 14 (dbl), 15 (dbl), 16 (dbl), 17 (dbl), 18
  (dbl), 19 (dbl), 20 (dbl)
```

Data wrangling cheat sheet
=======================================================
title: false

[Data manipulation cheat sheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
