library(gutenbergr)
library(tidytext)
library(tidyverse)
library(tm)

mf <- tibble(link = c("https://www.gutenberg.org/files/14765/14765-8.txt",
           "https://www.gutenberg.org/files/15066/15066-8.txt"),
           titulo=c("El gaucho MF", "La vuelta de MF")) %>%
        mutate(texto = map(.x=link, .f=read_lines))

mf$texto[1]<-str_flatten(mf$texto[[1]][128:3268], " ")
mf$texto[2]<-str_flatten(mf$texto[[2]][286:6930], " ")


mf <- mf %>%
        mutate(texto = stringi::stri_conv(unlist(texto), from="ISO-8859-1", to="utf8"))

## ELIMIMAR ACENTOS, NUMEROS 

mf <- mf %>%
        mutate(texto = iconv(texto, to="Latin-ASCII"))

mf <- mf %>%
        mutate(texto = str_squish(gsub('[0-9]+', '', texto)))


stop_words <- read_csv('https://raw.githubusercontent.com/Alir3z4/stop-words/master/spanish.txt', col_names=FALSE) %>%
        rename(word = X1) %>%
        mutate(word = stringi::stri_trans_general(word, "Latin-ASCII"))

stop_words <- stop_words %>%
        add_row(tibble(word=str_to_lower(as.roman(1:1000)))
)



mf <- mf %>%
        unnest_tokens(output = word, input=texto)

mf <- mf %>%
        anti_join(stop_words)

mf %>%
        count(word, sort=TRUE) %>%
        filter(n > 20) %>%
        mutate(word = reorder(word, n)) %>%
        ggplot(aes(n, word)) +
        geom_col() +
        labs(y = NULL)


freqs <- mf %>%
        mutate(word = str_extract(word, "[a-z']+")) %>% #Nos quedamos con las letras
        group_by(titulo, word) %>% #Agrupamos por tipo y word
        summarise(n = n()) %>%
        mutate(
                total = sum(n),
                prop = n/total*100
        ) %>%
        ungroup() %>%
        select(titulo, word, prop) %>%
        pivot_wider(names_from = titulo, values_from = prop) 

freqs %>%
        ggplot( aes(notas, libros)) +
        geom_jitter(alpha = 0.05, size = 2.5, width = 0.25, height = 0.25) +
        geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
        scale_x_log10() +
        scale_y_log10() +
        geom_abline(color = "red") +
        theme_minimal()

