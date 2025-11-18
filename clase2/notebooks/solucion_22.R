library(tidyverse)
library(tidytext)

marx_engels <- read_csv('./clase1/data/marx_engels.csv')

marx_engels_tidy <- marx_engels %>%
        unnest_tokens(output = word, 
                      input = texto) %>%
        mutate(tipo = case_when(
                str_detect(titulo, 'Carta') ~ 'cartas',
                TRUE ~ tipo
        )) 

marx_engels_freqs <- marx_engels_tidy %>%
        group_by(tipo, word) %>%
        summarise(n = n()) %>%
        arrange(desc(n)) %>%
        ungroup()

total_words <- marx_engels_freqs %>% 
        group_by(tipo) %>% 
        summarize(total = sum(n))

marx_engels_freqs <- marx_engels_freqs %>%
        left_join(total_words) %>%
        bind_tf_idf(word, tipo, n)

marx_engels_freqs %>%
        group_by(tipo) %>%
        slice_max(tf_idf, n = 30) %>%
        ungroup() %>%
        ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = tipo)) +
        geom_col(show.legend = FALSE) +
        facet_wrap(~tipo, ncol = 2, scales = "free") +
        labs(x = "tf-idf", y = NULL) +
        theme_minimal()

