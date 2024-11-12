library(tidyverse)
library(gemini.R)

api <- read_lines('./clasellms/gemini_key.txt')
setAPI(api)

# df <- read_csv('./clase6/data/amazon_reviews_train_sample.csv')
# 
# set.seed(876)
# df <- df[sample(1:nrow(df)), ] 
# df_list <- split(df, sample(1:16, nrow(df), replace=T))
# 
#df_list %>% write_rds('./clasellms/data/reviews_amazon_listsplit.rds')
df_list <- read_rds('./clasellms/data/reviews_amazon_listsplit.rds')

prompt <- "A continuación vas a recibir un texto de una reseña de compra online.
Quisiera que la clasifiques positiva o negativa usando las siguientes categorías:

- Positiva: la reseña es positiva
- Negativa: la reseña es negativa

Quisiera que expliques paso a paso tu razonamiento.

La salida debería tener el siguiente formato:

clasif: seguido de la clasificación | expl: seguido de la explicación

Texto: 
"

prompt2 <- "A continuación vas a recibir un texto de una reseña de compra online.
Quisiera que la clasifiques en una escala de números enterios entre 0 y 5, donde
0 es una reseña totalmente negativa y 5 una reseña totalmente positiva.

Quisiera que expliques paso a paso tu razonamiento.

La salida debería tener el siguiente formato:

clasif: seguido de la clasificación | expl: seguido de la explicación

Texto: 
"

it_list <- 0
for (l in df_list){
        it_list <- it_list + 1
        if (file.exists(paste0('./clasellms/data/', it_list, '_reviews_llms_prompt1.rds'))){
                next
        }else{
                
        it <- 0
        rtas <- list()
        tictoc::tic()
        for (i in 1:nrow(l)){
                it <- it + 1
                id <- l$review_id[i]
                Sys.sleep(4.5)
                
                cat("Procesando comentario", i, "de", nrow(l), "\n")
                rta <- gemini(paste0(prompt, l$review_body[i]))
                cat(rta)
                rtas[[id]] <- rta
                
                name <- paste0('./clasellms/data/', it_list, '_reviews_llms_prompt1.rds')
                        write_rds(rtas, name)
                }
        }
        tictoc::toc()
}


parse_clasif <- function(string){
        #clasif <- str_trim(str_replace(str_split(string, "\\|")[[1]][1], "clasif:", ""))
        #clasif <- str_trim(str_replace(str_split_1(string[1], "\\|")[1], "clasif: ", ""))
        clasif <- str_extract(string, "(?<=clasif: ).*?(?= \\|)")
        return(clasif)
}

parse_expl <- function(string){
        expl <- str_trim(str_replace_all(str_extract(string, "(?<=expl).*"), ":|'", ""))
        return(expl)
}

#rtas <- read_rds('./clasellms/data/900_reviews_llms.rds')

rm(rtas_df)

rtas_df <- rtas %>%
        enframe(name = "review_id", value = "resp") %>% 
        unnest(cols = c(resp)) %>% 
        mutate(llm_expl = parse_expl(resp),
               llm_stars = parse_clasif(resp))


rtas_df <- rtas_df %>%
        left_join(df)  %>%
        mutate(stars = case_when(
                stars == "Postiva" ~ "Positiva",
                TRUE ~ stars
        ))


mean(rtas_df$llm_stars == rtas_df$stars)
