library(tidyverse)
library(tidytext)
library(tidymodels)
library(textrecipes)
library(textclean)

## Funcion carga embedding
path_w2v <- "../../WordEmbeddings/Word2Vec/sbw_vectors.bin"
#path_ft <- "../../WordEmbeddings/FastText/cc.es.300.bin"

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
        #mutate(review_body = tolower(review_body)) %>%
        #mutate(review_body = replace_non_ascii(review_body))  %>%
        mutate(review_body = str_replace_all(review_body, "[[:digit:]]+", "DIGITO"))


## Cargo embedding
embedding <- load_embeddings(path = path_w2v,
                             type = "w2v")   

reviews_tidy <- reviews %>%
                unnest_tokens(word, review_body)

reviews_tidy <- reviews_tidy %>%
        left_join(embedding) %>%
        drop_na()

reviews_embed <- reviews_tidy %>%
        group_by(review_id, stars) %>%
        summarise(across(V1:V300, ~mean(.x, na.rm=TRUE)))

## Split
set.seed(664)
reviews_split <- initial_split(reviews_embed, strata = stars)

train_embed <- training(reviews_split)
test_embed <- testing(reviews_split)

lasso_spec <- logistic_reg(
        penalty = tune(),
        mixture = 1) %>%
        set_mode("classification") %>%
        set_engine("glmnet")

reviews_rec_embed <-
        recipe(stars ~ ., data = train_embed) %>%
        update_role("review_id", new_role = "ID")

wf_embed <- workflow() %>% 
        add_recipe(reviews_rec_embed) %>%
        add_model(lasso_spec)

grid_lasso <- tibble(penalty=seq(0,0.2, 0.01))

## Seteo de validación cruzada

set.seed(234)
embed_folds <- vfold_cv(train_embed, v = 5)

tune_lasso <- tune_grid(
        wf_embed,
        embed_folds,
        grid = grid_lasso,
        control = control_resamples(save_pred = TRUE)
)


fitted_lasso %>%
        extract_fit_parsnip() %>%
        tidy() %>%
        arrange(-estimate)

collect_metrics(tune_lasso)
show_best(tune_lasso, "roc_auc", n=2)

chosen_auc <- tune_lasso %>%
        select_by_one_std_err(metric = "roc_auc", -penalty)


final_lasso <- finalize_workflow(wf_embed, chosen_auc)
final_lasso

fitted_lasso <- fit(final_lasso, train_embed)
