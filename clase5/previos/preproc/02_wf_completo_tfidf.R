library(tidyverse)
library(tidytext)
library(tidymodels)
library(textrecipes)
library(textclean)

## Carga de datos
reviews <- read_csv('./clase8/data/amazon_reviews_train_sample.csv') %>%
                select(-product_category)

## Limpieza y preprocesamiento de texto
reviews_idf <- reviews %>%
        mutate(review_body = str_replace_all(review_body, "'\\[.*?¿\\]\\%'", " ")) %>%
        mutate(review_body = str_replace_all(review_body, "[[:punct:]]", " ")) %>%
        mutate(review_body = tolower(review_body)) %>%
        mutate(review_body = str_replace_all(review_body, "[[:digit:]]+", "DIGITO")) %>%
        mutate(review_body = replace_non_ascii(review_body))


## Split
set.seed(664)
reviews_split_idf <- initial_split(reviews_idf, strata = stars)

train_idf <- training(reviews_split_idf)
test_idf <- testing(reviews_split_idf)

## Seteo de validación cruzada
set.seed(234)
idf_folds <- vfold_cv(train_idf, v = 5)

## Recipes de tokenizacion y vectorizacion
### TFIDF
reviews_rec_idf <- recipe(stars ~ ., data = train_idf) %>%
        update_role("review_id", new_role = "ID",) %>%
        step_tokenize(review_body) %>%
        step_tokenfilter(review_body, max_tokens=5000) %>%
        step_tfidf(review_body)

reviews_rec_idf %>% prep() %>% bake(train_idf)

lasso_spec <- logistic_reg(
        penalty = tune(),
        mixture = 1) %>%
        set_mode("classification") %>%
        set_engine("glmnet")

wf_idf <- workflow() %>% 
        add_recipe(reviews_rec_idf) %>%
        add_model(lasso_spec)

grid_lasso <- tibble(penalty=seq(0,0.2, 0.01))


tune_lasso <- tune_grid(
        wf_idf,
        idf_folds,
        grid = grid_lasso,
        control = control_resamples(save_pred = TRUE)
)


collect_metrics(tune_lasso)
show_best(tune_lasso, "roc_auc", n=2)

chosen_auc_idf <- tune_lasso %>%
        select_by_one_std_err(metric = "roc_auc", -penalty)

