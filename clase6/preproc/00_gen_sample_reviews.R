library(tidyverse)

## Carga de datos
reviews <- read_csv('./clase8/data/amazon_reviews_train.csv') %>% 
        select(-"...1")

## Filtramos las neutrales
reviews <- reviews %>%
        select(review_id, review_body, stars, product_category) %>%
        filter(stars != 3)

## Recodificamos las positivas y negativas
reviews <- reviews %>%
        mutate(stars = case_when(
                stars <= 2 ~ 'Negativa',
                stars >= 4 ~ 'Postiva')
        )

## Muestreamos para achicar el dataset y que corra en memoria
set.seed(1637)
reviews <- reviews %>%
        group_by(stars) %>%
        sample_frac(0.125)

write_csv(reviews, './clase8/data/amazon_reviews_train_sample.csv')

