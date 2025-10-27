library(tidyverse)
library(rvest)

autores <- tibble(
        autor = character(),
        url = character()
)

for (i in 1:28){
        cat(paste0("Sitio ", i, " de ", 28, "... \n"))
        link <- paste0("https://www.anagrama-ed.es/autores?p=", i)
        print(link)
        html <- read_html(link)
        
        autor <- html %>%
                html_elements("span.bold") %>%
                html_text2()

        url <- html %>%
                html_elements("div.autor") %>%
                html_elements("a") %>%
                html_attr("href")

        url <- paste0("https://www.anagrama-ed.es", url)

        page_tibble <- cbind(autor, url) %>% as_tibble()

        autores <- autores %>% bind_rows(page_tibble)
}
