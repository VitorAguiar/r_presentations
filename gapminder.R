library(gapminder)
library(dplyr)

str(gapminder)

# Same: -----------------------------------------------------------------------#
gapminder %>%
  count(country)

gapminder %>%
  group_by(country) %>%
  summarise(n = n())

gapminder %>% 
  group_by(country) %>% 
  tally()
# -----------------------------------------------------------------------------#

gapminder %>%   
  filter(country == "Brazil") %>%
  lm(lifeExp ~ gdpPercap, data = .) %>%
  summary()

gapminder %>%
  filter(continent == "Americas", year == last(year)) %>%
  arrange(desc(gdpPercap))

gapminder %>%
  group_by(continent, year) %>%
  summarise(avg_gdp = mean(gdpPercap))

gapminder %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean), lifeExp, gdpPercap)

gapminder %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean, sd), lifeExp, gdpPercap)

gapminder %>%
  top_n(10, lifeExp)

list(brazil = gapminder %>% filter(country == "Brazil"), 
     chile = gapminder %>% filter(country == "Chile")) %>%
  bind_rows()

gapminder %>% 
  filter(continent == "Asia") %>%
  ggplot(aes(year, pop, color = country)) +
  geom_point(aes(size = pop)) +
  guides(size = FALSE)







