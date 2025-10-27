# Módulo V

##### Escuela Interdisciplinaria de Altos Estudios Sociales

##### Universidad Nacional de San Martín

<img src="imgs/Z_logo-factor-data-solo.jpg" width="200" />

**Equipo docente:**  
- [Germán Rosati](https://gefero.github.io/)  
- [Tomás Maguire](https://ar.linkedin.com/in/tomasebm)  
- [Zacarías
Abuchanab](https://ar.linkedin.com/in/zacarias-abuchanab-b38999178)  
- [Joaquín Zajac](https://ar.linkedin.com/in/joaquin-zajac)

## Minería de Texto + webscraping

El trabajo empírico en las ciencias sociales se caracteriza por su gran
diversidad en el tipo de fuentes de información utilizadas: desde datos
altamente estructurados (cuya forma más clásica son las encuestas) hasta
datos de un grado menor de estructuración. En este último grupo, los
datos textuales, ya se trate de documentos, noticias, entrevistas, etc.-
ocupan un lugar central.

En las ciencias sociales argentinas el análisis de textos parece haber
estado centrado fundamentalmente en técnicas de “lectura profunda”, una
lectura manual, interpretativa, con gran detalle de corpus pequeños,
buscando entender todos los matices de cada documento. Es por ello que
este seminario propone como complemento una aproximación desde una
“lectura distante” centrada en corpus textuales más grandes y que
intenta aproximarse, mediante técnicas computacionales a un análisis de
tendencias y patrones generales.

### Librerías a utilizar

El taller se desarrollará en R y se hará un uso extensivo de las
siguientes librerías:

- `tidytext`
- `topicmodels`
- `stm`
- `textstem`
- `textclean`
- `word2vec`
- `gemini.R`
- `ollamar`

Pueden instalarse utilizando las siguientes instrucciones:

``` r
install.packages('tidytext')
install.packages('topicmodels')
install.packages('stm')
install.packages('textclean')
install.packages('textstem')
install.packages('word2vec')
install.packages('gemini.R')
install.packages('ollamar')
```

### Contenidos por clase

<u> *Los materiales están organizados por clase: Pueden descargarse la
totalidad de los materiales de cada una para trabajar en un único
archivo .zip* </u>

#### **Clase 1**

-   Temas de clase
    -   Introducción a R y al tidyverse y a tidytext.  
    -   ¿Cómo hacer de un corpus de texto crudo algo analizable mediante
        métodos cuantitativos?  
    -   Preprocesamiento de texto: stopwords, lemmas y stemming.

[![](imgs/Download.png)](clase1.zip)

#### **Clase 2** 

-   Temas de clase
    -   ¿Cómo vectorizar textos? Contando palabras y extrayendo
        conclusiones de un corpus.  
    -   Bag of Words. Term-frequency matrix: conteos crudos y
        ponderación TF-IDF.  
    -   Análisis de sentimientos sobre un corpus.

[![](imgs/Download.png)](clase2.zip)

#### **Clase 3** 

-   Temas de clase
    -   ¿Cómo detectar temas en corpus I?  
    -   Introducción al modelado de tópicos.  
    -   Latent Dirichlet Allocation (LDA) y un modelo para detectar
        tópicos diseñado para las ciencias sociales: Structural Topic
        Modeling. (STA)

[![](imgs/Download.png)](clase4.zip)

#### **Clase 4**

-   Temas de clase
    -   ¿Cómo vectorizar textos (recargado)? Una introducción a los
        métodos de word-embeddings (word2vec).  
    -   ¿Cómo se usa un modelo pre-entrenado? Usando word embeddings
        pre-entrenados como insumo.

[![](imgs/Download.png)](clase5.zip)

#### **Clase 5**

-   Temas de clase
    -   ¿Qué son los LLMs y cómo usarlos? Un primer ejercicio con
        modelos grandes de lenguaje

[![](imgs/Download.png)](clase6.zip)

#### **Clase 6** 

-   Temas de clase
    -   LLMs epidsodio 2. Usando modelos de lenguaje en forma local
    -   [Tutorial de uso de Google Colab - YouTube](https://www.youtube.com/playlist?list=PLbECkNOVKUKP401fJbWRe8r-z4L4-OvM8)
    -   [Slides Intro APIs - pdf](/clase6/DIPLO_TM_clase_6.pdf)
    -   [Explicación y práctica guiada - Notebook](https://colab.research.google.com/drive/18qGub-vI8ZzAqC5dH31Tky6ltyYe6VDf?usp=sharing)
    -   [Sitio oficial de Ollama](https://ollama.com/)
    -   [Sitio ollamar](https://hauselin.github.io/ollama-r/)

# Bibliografía y sitios de consulta

-   [Moretti, Franco (2015). Lectura distante. Buenos Aires: Fondo de
    Cultura
    Económica.](https://fce.com.ar/wp-content/uploads/2020/11/MorettiLD.pdf?srsltid=AfmBOoqOFUhz-FcuetukBTw_xDMd5MceJtlavWDae9v-SYeLM14SyR36)
-   [Roberts, Margaret; Stewart, Brandon y Tinlgey, Dustin (2016). “stm:
    R Package for Structural Topic
    Models”](https://cran.r-project.org/web/packages/stm/vignettes/stmVignette.pdf)
-   [Silge, Julia (2020). Text mining with R. A tidy approach.
    California: O’Reilly Media. Versión online gratis en
    ingles](https://www.tidytextmining.com/)
