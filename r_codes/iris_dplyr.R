library(dplyr)
head(iris)

# select
select(iris, Sepal.Length, Species)

iris %>%
  select(Sepal.Length, Speicies)

# filter
filter(iris, Sepal.Length > 7)

iris %>%
  filter(Sepal.Length > 7)

# mutate
mutate(iris, length = Sepal.Length + Petal.Length)

iris %>%
  mutate(length = Sepal.Length + Petal.Length)

mutate(iris, length = mean(Sepal.Length + Petal.Length))

iris %>%
  mutate(length = mean(Sepal.Length + Petal.Length))

# arrange
arrange(iris, Sepal.Length)
arrange(iris, desc(Sepal.Length))
arrange(iris, desc(Sepal.Length), desc(Petal.Length))

iris %>%
  arrange(desc(Sepal.Length), desc(Petal.Length))

# group_by + summarise
summarise(group_by(iris, Species), mean(Sepal.Length), mean(Petal.Length))

iris %>%
  group_by(Species) %>%
  summarise(mean(Sepal.Length), mean(Petal.Length))
