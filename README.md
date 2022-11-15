![](/imgs/logo-factor-data-solo.jpg)

## Docentes

- [Germán Rosati](https://gefero.github.io/)
- [Tomás Maguire]()

# Presentación
El trabajo empírico en las ciencias sociales se caracteriza por su gran diversidad en el tipo de fuentes de información utilizadas: desde datos altamente estructurados (cuya forma más clásica son las encuestas) hasta datos de un grado menor de estructuración. En este último grupo, los datos textuales, ya se trate de documentos, noticias, entrevistas, etc.- ocupan un lugar central.

En las ciencias sociales argentinas el análisis de textos parece haber estado centrado fundamentalmente en técnicas de "lectura profunda", una lectura manual, interpretativa, con gran detalle de corpus pequeños, buscando entender todos los matices de cada documento. Es por ello que este seminario propone como complemento una aproximación desde una "lectura distante" centrada en corpus textuales más grandes y que intenta aproximarse, mediante técnicas computacionales a un análisis de tendencias y patrones generales.


# Contenidos y materiales
## Clase 1. Introducción a R y al tidyverse y a tidytext. ¿Cómo hacer de un corpus de texto crudo algo analizable mediante métodos cuantitativos? Preprocesamiento de texto: stopwords, lemmas y stemming. 

- [Slides - pdf](/clase1/DIPLO_M5_Clase_1.pdf)
- [Explicación y práctica guiada - Notebook](/clase1/notebooks/clase_1.html)
- [Explicación y práctica guiada - RMarkdown](/clase1/notebooks/clase_1.Rmd)
- [Práctica Independiente - RMarkdown](/clase1/notebooks/practica_clase_1.Rmd)
- [Práctica Independiente - Notebook](/clase1/notebooks/practica_clase_1.html)

Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)](clase1.zip)


## Clase 2. ¿Cómo vectorizar textos? Contando palabras y extrayendo conclusiones de un corpus. Bag of Words. Term-frequency matrix: conteos crudos y ponderación TF-IDF. Análisis de sentimientos sobre un corpus. 
- [Slides - pdf](/clase2/DIPLO_M5_Clase_2.pdf)
- [Explicación y práctica parte 1 guiada - Notebook](/clase2/notebooks/21_sentiment_analysis.html)
- [Explicación y práctica parte 1 guiada - RMarkdown](/clase2/notebooks/21_sentiment_analysis.Rmd)
- [Explicación y práctica parte 2 guiada - RMarkdown](/clase2/notebooks/22_tfidf.Rmd)
- [Explicación y práctica parte 2 guiada - Notebook](/clase2/notebooks/22_tfidf.html)

Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)](clase2.zip)


## Clase 3. Web Scraping + APIs. ¿Cómo descargamos información de un sitio estático?
- [Slides - pdf](/clase3/Diplo_M5_Clase_3.pdf)
- [Explicación y práctica guiada Scraping - Notebook](/clase3/notebooks/clase_3_scraping.html)
- [Explicación y práctica guiada APIS - Notebook](/clase3/notebooks/clase_3_APIs.html)
- [Explicación y práctica guiada Scraping - RMarkdown](/clase3/notebooks/clase_3_scraping.Rmd)
- [Explicación y práctica guiada APIS - RMarkdown](/clase3/notebooks/clase_3_APIs.Rmd)
- [Pŕactica independiente - Notebook](/clase3/notebooks/clase_3_practica_independiente.html)
- [Pŕactica independiente - RMarkdown](/clase3/notebooks/clase_3_practica_independiente.Rmd)

Pueden descargarse la totalidad de los materiales del repositorio para trabajar en un único archivo .zip

[![](imgs/Download.png)](clase3.zip)


## Clase 4. ¿Cómo detectar temas en corpus I? Introducción al modelado de tópicos. Latent Dirichlet Allocation (LDA)


## Clase 5. ¿Cómo detectar temas en corpus II? Un modelo para detectar tópicos diseñado para las ciencias sociales: Structural Topic Modeling.


## Clase 6. Cómo vectorizar textos (recargado)? Una introducción a los métodos de word-embeddings (word2vec). Cierre del módulo


# Librerías a utilizar
El taller se desarrollará en R y se hará un uso extensivo de las siguientes librerías:

- `tidytext`
- `topicmodels`
- `stm`
- `textstem`
- `textclean`
- `word2vec`

Pueden instalarse utilizando las instrucciones:

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


