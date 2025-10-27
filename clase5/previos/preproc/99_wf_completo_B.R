library(tidyverse)
library(tidytext)
library(tidymodels)
library(textrecipes)
library(textclean)

## Funcion carga embedding
path_w2v <- "../../WordEmbeddings/Word2Vec/sbw_vectors.bin"
path_ft <- "../../WordEmbeddings/FastText/cc.es.300.bin"

load_embeddings <- function(path=NULL, type=c("w2v", "ft")){
        
        if (type=="w2v"){
                embedding <- word2vec::read.wordvectors(path, 
                                                        type = "bin", 
                                                        normalize = TRUE) %>%
                        as_tibble(rownames="word")
        }
        else if (type=="ft"){
                model <- fastTextR::ft_load(path)
                words <- fastTextR::ft_words(model)
                embedding <- fastTextR::ft_word_vectors(model,
                                                        words) %>%
                        as_tibble(rownames="word")
        }
        
        return(embedding)
}

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
set.seed(664)
reviews_split <- initial_split(reviews, strata = stars)

train <- training(reviews_split)
test <- testing(reviews_split)

## Seteo de validación cruzada
set.seed(234)
reviews_folds <- vfold_cv(train, v = 5)

## Recipes de tokenizacion y vectorizacion
min_t = 50
max_t = 20000

### TFIDF
reviews_rec_tfidf <-
        recipe(stars ~ review_body, data = train) %>%
        step_tokenize(review_body) %>%
        step_tokenfilter(review_body, min_times = min_t, max_times = max_t) %>%
        step_tf(review_body)

## Embedding (word2vec)
# Carga el modelo
embedding <- load_embeddings(path = path_w2v,
                             type = "w2v")        

## recipe
reviews_rec_embed <-
        recipe(stars ~ review_body, data = train) %>%
        step_tokenize(review_body) %>%
        step_tokenfilter(review_body, min_times = min_t, max_times = max_t) %>%
        step_word_embeddings(review_body, embeddings = embedding)

## Modelos a testear

lasso_spec <- logistic_reg(
        penalty = tune(),
        mixture = 1) %>%
        set_mode("classification") %>%
        set_engine("glmnet")
        
        
        
# logreg_spec <- logistic_reg() %>%
#         set_mode("classification") %>%
#         set_engine("glm")
 
# rf_spec <- rand_forest(
#         mtry = tune(),
#         trees = 800,
#         min_n = tune()
# ) %>%
#         set_mode("classification") %>%
#         set_engine("ranger")


## Creamos workflowset
wf_tfidf <- 
        workflow_set(
                preproc = list(tokenize = reviews_rec_tfidf), 
                models = list(lasso = lasso_spec
                              #rf = rf_spec
                              )
        ) %>%
        mutate(wflow_id = paste0("tfidf_", wflow_id))

wf_embed <- 
        workflow_set(
                preproc = list(tokenize = reviews_rec_embed), 
                models = list(lasso = lasso_spec
                              #rf = rf_spec
                              )
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
                save_workflow = FALSE
        )

grid_lasso <- tibble(penalty=seq(0,0.2, 0.01))

tictoc::tic()
grid_results <-
        all_workflows %>%
        workflow_map(
                seed = 852,
                resamples = reviews_folds,
                grid = grid_lasso,
                control = grid_ctrl
        )
tictoc::toc()
 
collect_metrics(grid_results) %>% 
        group_by(wflow_id, .metric) %>%
        filter(mean == max(mean))
       
## Evaluamos
autoplot(
        grid_results,
        rank_metric = "accuracy",  # <- how to order models
        metric = "accuracy",       # <- which metric to visualize
        select_best = TRUE     # <- one point per workflow
)