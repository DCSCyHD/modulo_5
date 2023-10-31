
### Ejercicio
Replicar el análisis de sentimento con el lexicon construido por el LIIA. Comparar los resultados.

sentiment_words_liia <- sentiment_words_liia %>%
        mutate(word =  stringi::stri_trans_general(str = word, 
                                                   id = "Latin-ASCII"))
tidy_renzi_sent_liia <- tidy_renzi %>%
        inner_join(sentiment_words_liia) %>%
        group_by(tomo, entry_number, sentiment) %>%
        summarise(n=n()) %>%
        ungroup() %>%
        pivot_wider(names_from = sentiment,
                    values_from = n,
                    values_fill = 0) %>%
        mutate(sentiment = positivo-negativo)

tidy_renzi_sent_liia
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
