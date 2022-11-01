![](/imgs/logo-factor-data-solo.jpg)

## Docentes

- [Germán Rosati](https://gefero.github.io/)
- [Tomás Maguire]()

# Presentación
El trabajo empírico en las ciencias sociales se caracteriza por su gran diversidad en el tipo de fuentes de información utilizadas: desde datos altamente estructurados (cuya forma más clásica son las encuestas) hasta datos de un grado menor de estructuración. En este último grupo, los datos textuales, ya se trate de documentos, noticias, entrevistas, etc.- ocupan un lugar central.

En las ciencias sociales argentinas el análisis de textos parece haber estado centrado fundamentalmente en técnicas de "lectura profunda", una lectura manual, interpretativa, con gran detalle de corpus pequeños, buscando entender todos los matices de cada documento. Es por ello que este seminario propone como complemento una aproximación desde una "lectura distante" centrada en corpus textuales más grandes y que intenta aproximarse, mediante técnicas computacionales a un análisis de tendencias y patrones generales.


# Contenidos y materiales
## Clase 1. Introducción a R y al tidyverse y a tidytext. ¿Cómo hacer de un corpus de texto crudo algo analizable mediante métodos cuantitativos? Preprocesamiento de texto: stopwords, lemmas y stemming. 

- [Slides - pdf](/clase1/DIPLO_TM_Clase_1.pdf)
- [Explicación y práctica - Notebook](/clase1/notebooks/clase_1.html)
- [Explicación y práctica - RMarkdown](/clase1/notebooks/clase_1.Rmd)
- [Práctica Independiente - RMarkdown](/clase1/notebooks/practica_clase_1.Rmd)
- [Práctica Independiente - Notebook](/clase1/notebooks/practica_clase_1.html)

Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)](clase1.zip)


## Clase 2. ¿Cómo vectorizar textos? Contando palabras y extrayendo conclusiones de un corpus. Bag of Words. Term-frequency matrix: conteos crudos y ponderación TF-IDF. Análisis de sentimientos sobre un corpus. 

- [Slides - pdf](/clase2/DIPLO_TM_Clase_2.pdf)
- [Sentiment Analysis - Explicación y práctica - Notebook](/clase2/notebooks/2_sentimient_analysis.html)
- [Sentiment Analysis - Explicación y práctica - RMarkdown](/clase2/notebooks/2_sentimient_analysis.Rmd)
- [TF-IDF - Explicación y práctica - Notebook](/clase2/notebooks/21_tfidf.html)
- [TF-IDF - Explicación y práctica - RMarkdown](/clase2/notebooks/21_tfidf.Rmd)


Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)]()


## Clase 3. Web Scraping

- [Slides - pdf](/clase3/DIPLO_TM_Clase_3.pdf)
- [Scraping - Explicación y práctica - Notebook](/clase3/notebooks/3_clase.nb.html)
- [Scraping - Explicación y práctica - RMarkdown](/clase3/notebooks/3_clase.Rmd)
- [APIS - Explicación y práctica - Notebook](/clase3/notebooks/APIs.nb.html)
- [APIS - Explicación y práctica - RMarkdown](/clase3/notebooks/APIs.Rmd)
- [Práctica independiente](/clase3/notebooks/3_practica_independiente.Rmd)

Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)]()

## Clase 4. ¿Cómo detectar temas en corpus I? Introducción al modelado de tópicos. Latent Dirichlet Allocation (LDA)

- [Slides - pdf](/clase4/DIPLO_TM_Clase_4.pdf)
- [Explicación y práctica - Notebook](/clase4/notebooks/4_topic_modeling_LDA.nb.html)
- [Explicación y práctica - RMarkdown](/clase4/notebooks/4_topic_modeling_LDA.Rmd)
- [Práctica independiente](/clase4/notebooks/4_practica_independiente.nb.html)

[![](imgs/Download.png)]()


## Clase 5. ¿Cómo detectar temas en corpus II? Un modelo para detectar tópicos diseñado para las ciencias sociales: Structural Topic Modeling.

- [Slides - pdf](/clase5/DIPLO_TM_Clase_5.pdf)
- [Explicación y práctica - Notebook](/clase5/notebooks/5_topic_modeling_STM.nb.html)
- [Explicación y práctica - RMarkdown](/clase5/notebooks/5_topic_modeling_STM.Rmd)

[![](imgs/Download.png)]()

## Clase 6. Cómo vectorizar textos (recargado)? Una introducción a los métodos de word-embeddings (word2vec). Cierre del módulo

- [Slides - pdf](/clase6/DIPLO_TM_Clase_6.pdf)
- [Explicación y práctica - Notebook](/clase6/notebooks/6_word2vec.nb.html)
- [Explicación y práctica - RMarkdown](/clase6/notebooks/6_word2vec.Rmd)

[![](imgs/Download.png)]()

# Librerías a utilizar
El taller se desarrollará en R y se hará un uso extensivo de las siguientes librerías:

- `tidytext`
- `topicmodels`
- `stm`
- `textstem`
- `textclean`
- `word2vec`

Pueden instalarse utili`zando las instrucciones:

```{r}
install.packages('tidytext')
install.packages('topicmodels')
install.packages('stm')
install.packages('textclean')
install.packages('textstem')
install.packages('word2vec')
```


# Bibliografía y sitios de consulta

- Moretti, Franco (2015). Lectura distante. Buenos Aires: Fondo de Cultura Económica.
- Roberts, Margaret; Stewart, Brandon y Tinlgey, Dustin (2016). “stm: R Package for Structural Topic Models”, disponible [aquí](https://cran.r-project.org/web/packages/stm/vignettes/stmVignette.pdf)
- Silge, Julia (2020). Text mining with R. A tidy approach. California: O’Reilly Media. [Versión online gratis en ingles](https://www.tidytextmining.com/) 


