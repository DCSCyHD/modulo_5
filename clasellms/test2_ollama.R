library(ollamar)

messages <- list(
        list(role = "user", content = "
        A continuación vas a recibir un texto de una reseña de compra online.
             Quisiera que la clasifiques positiva o negativa usando las siguientes categorías:
                     
                     - Positiva: la reseña es positiva
                     - Negativa: la reseña es negativa
             
             Quisiera que expliques paso a paso tu razonamiento.
             
             La salida debería tener el siguiente formato:
                     
                     clasif: seguido de la clasificación | expl: seguido de la explicación
                     
                     Texto:
             ")
)

pull("deepseek-r1:1.5b")

rtas <- list()

tictoc::tic()
for (i in 1:nrow(df_list[1:10,])){
        id <- df_list$review_id[i]
        Sys.sleep(4.5)
        
        cat("Procesando comentario", i, "de", nrow(df_list), "\n")
        mess <- create_message(paste0(messages, df_list$review_body[i]))
        rta <- chat("deepseek-r1:1.5b", 
                    messages = mess
                    )
        (rta)
        rtas[[id]] <- rta
}
tictoc::toc()


resp <- chat("deepseek-r1:1.5b", messages)  # default returns httr2 response object
