
### Ejercicio
#Replicar el análisis de sentimento con el lexicon construido por el LIIA. Comparar los resultados.

#sentiment_words_liia <- sentiment_words_liia %>%
#        mutate(word =  stringi::stri_trans_general(str = word, 
#                                                   id = "Latin-ASCII"))

sentiment_words_liia <- read_csv('./clase2/data/sentiment_lexicon_liia.csv')

sentiment_words_liia <- sentiment_words_liia %>% 
        mutate(sentiment = case_when(
                round(mean_likeness) == 1 ~ 'negativo',
                round(mean_likeness) == 2 ~ 'neutral',
                round(mean_likeness) == 3 ~ 'positivo',
        ))

tidy_renzi_sent_liia <- tidy_renzi %>%
        inner_join(sentiment_words_liia) %>%
        group_by(tomo, entry_number, sentiment) %>%
        summarise(n=n()) %>%
        ungroup() %>%
        pivot_wider(names_from = sentiment,
                    values_from = n,
                    values_fill = 0) %>%
        mutate(sentiment = positivo-negativo)

tidy_renzi_sent_liia %>%
        ggplot(aes(x=entry_number, y=sentiment, color=tomo)) +
        geom_line(show.legend = TRUE) +
        #geom_smooth(aes(index, sentiment, color=tomo)) +
        labs(x='Entrada del diario',
             y= 'Sentimiento (palabras positivas-palabras negativas)',
             title='Análisis de sentimiento por palabras (lexicon Kaggle)') +
        theme_minimal() +
        scale_color_viridis_d() +
        theme(
                axis.title.x=element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank(),
                legend.position = 'bottom')


tidy_renzi_sent_liia_mean <- tidy_renzi %>%
        inner_join(sentiment_words_liia) %>%
        group_by(tomo, entry_number) %>%
        summarise(mean_like=mean(mean_likeness)) %>%
        ungroup() 

tidy_renzi_sent_liia_mean %>%
        ggplot(aes(x=entry_number, y=mean_like, color=tomo)) +
        geom_line(show.legend = TRUE) +
        #geom_smooth(aes(index, sentiment, color=tomo)) +
        labs(x='Entrada del diario',
             y= 'Sentimiento (palabras positivas-palabras negativas)',
             title='Análisis de sentimiento por palabras (lexicon Kaggle)') +
        theme_minimal() +
        scale_color_viridis_d() +
        theme(
                axis.title.x=element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank(),
                legend.position = 'bottom')
