library(tidyverse)
library(tidytext)
library(tidymodels)
library(textrecipes)
library(textclean)

## Carga de datos
reviews <- read_csv('./clase8/data/amazon_reviews_train_sample.csv')

## Limpieza y preprocesamiento de texto
reviews <- reviews %>%
        mutate(review_body = str_replace_all(review_body, "'\\[.*?¿\\]\\%'", " ")) %>%
        mutate(review_body = str_replace_all(review_body, "[[:punct:]]", " ")) %>%
        mutate(review_body = tolower(review_body)) %>%
        mutate(review_body = str_replace_all(review_body, "[[:digit:]]+", "DIGITO")) %>%
        mutate(review_body = replace_non_ascii(review_body))

## Split
reviews_split <- initial_split(reviews, strata = stars)

train <- training(reviews_split)
test <- testing(reviews_split)

## Seteo de validación cruzada
set.seed(234)
reviews_folds <- vfold_cv(train, v = 2)

## Recipes de tokenizacion y vectorizacion
### TFIDF
reviews_rec_tfidf <-
        recipe(stars ~ review_body, data = train) %>%
        step_tokenize(review_body) %>%
        step_tokenfilter(review_body, min_times = 50, max_times = 2000) %>%
        step_tfidf(review_body)

## Embedding (word2vec)
# Carga el modelo
library(word2vec)
embedding <- read.wordvectors("../../WordEmbeddings/Word2Vec/sbw_vectors.bin", 
                              type = "bin", normalize = TRUE) %>%
        as_tibble(rownames="word")

## recipe
reviews_rec_embed <-
        recipe(stars ~ review_body, data = train) %>%
        step_tokenize(review_body) %>%
        step_tokenfilter(review_body, min_times=50, max_times=2000) %>%
        step_word_embeddings(review_body, embeddings = embedding)

## Modelos a testear
logreg_spec <- logistic_reg() %>%
        set_mode("classification") %>%
        set_engine("glm")

rf_spec <- rand_forest(
        mtry = tune(),
        trees = 800,
        min_n = tune()
) %>%
        set_mode("classification") %>%
        set_engine("ranger")


## Creamos workflowset
wf_tfidf <- 
        workflow_set(
                preproc = list(tokenize = reviews_rec_tfidf), 
                models = list(logreg = logreg_spec, 
                              rf = rf_spec)
        ) %>%
        mutate(wflow_id = paste0("tfidf_", wflow_id))

wf_embed <- 
        workflow_set(
                preproc = list(tokenize = reviews_rec_embed), 
                models = list(logreg = logreg_spec, 
                              rf = rf_spec)
        ) %>%
        mutate(wflow_id = paste0("embed_", wflow_id))

## Unimos todo
all_workflows <- 
        bind_rows(wf_tfidf, wf_embed)

## Parámetros de control del training
grid_ctrl <-
        control_grid(
                save_pred = TRUE,
                parallel_over = "everything",
                save_workflow = TRUE
        )
tictoc::tic()

grid_results <-
        all_workflows %>%
        workflow_map(
                seed = 852,
                resamples = reviews_folds,
                grid = 10,
                control = grid_ctrl
        )
tictoc::toc()


## Evaluamos
autoplot(
        grid_results,
        rank_metric = "roc_auc",  # <- how to order models
        metric = "roc_auc",       # <- which metric to visualize
        select_best = TRUE     # <- one point per workflow
) +
        geom_text(aes(y = mean - 1/2, label = wflow_id), angle = 90, hjust = 1) +
        lims(y = c(3.5, 9.5)) +
        theme(legend.position = "none")

collect_metrics(grid_results)