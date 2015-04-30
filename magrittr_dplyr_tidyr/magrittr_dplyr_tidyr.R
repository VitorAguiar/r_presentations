library(magrittr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(gapminder)

# gapminder data
str(gapminder)

# wrap data as a tbl_df
gapminder <- tbl_df(gapminder)

gapminder

# count
gapminder %>% count(country)

# filter & select
gapminder %>%
  filter(country == "Brazil", year >= 1980) %>%
  select(year, pop, lifeExp, gdpPercap)

# arrange
gapminder %>%
  arrange(lifeExp) %>%
  slice(1:10)

gapminder %>%
  arrange(desc(pop), gdpPercap, lifeExp)

# group & summarise
gapminder %>%
  group_by(continent) %>%
  summarise(avg_gdp = mean(gdpPercap))

# summarise multiple variables
gapminder %>%
  group_by(continent) %>%
  summarise_each(funs(mean), lifeExp, gdpPercap, pop)

# summarise with multiple functions and variables
gapminder %>%
  group_by(continent) %>%
  summarise_each(funs(mean, sd), lifeExp, gdpPercap)

# mutate
gapminder %>% mutate(total_gdp = gdpPercap * pop)

# transform multiple variables
gapminder %>% 
  mutate_each(funs(min_rank), lifeExp, gdpPercap, pop)

# pipe data to plot
gapminder %>%
  mutate(total_gdp = gdpPercap * pop) %>% 
  group_by(continent, year) %>%
  summarise(total_gdp = sum(total_gdp)) %>%
  ggplot(data = ., aes(x = year, y = total_gdp, color = continent)) + geom_line()


# Plant height
plant_height <- data_frame(individual = paste(sample(1:20), 
                                              c(rep("SP", 10), rep("MG", 10)),
                                              sep = "_"),
                           "2015/01/01" = rnorm(20, 15, sd = 1),
                           "2015/02/01" = rnorm(20, 16, sd = 1.2),
                           "2015/03/01" = rnorm(20, 21, sd = 1.5))

plant_height

# tidy data: 'long' or 'narrow' data
plant_height %<>% gather(key=date, value=height, 2:4)

plant_height

# back to wide format
plant_height %>% spread(date, height)

# separate
plant_height %<>% 
  separate(individual, into = c("id_number", "state")) %>%
  mutate(id_number = as.numeric(id_number)) %>%
  arrange(id_number, state)

plant_height

# extract
plant_height %<>% 
  extract(date, c("year", "month", "day"), "(\\d+)/(\\d+)/(\\d+)")

plant_height

# unite
plant_height %>% unite(date, year:day, sep = "/")

# transpode data
plant_height %>% spread(id_number, height)