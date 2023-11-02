url <- "https://services.gis.konstanz.digital/geoportal/rest/services/Fachdaten/Parkplaetze_Parkleitsystem/MapServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
while (TRUE) {
    tmp <- tryCatch(jsonlite::fromJSON(url), error = function(e) data.frame())
    if (length(tmp) != 0) {
        df <- jsonlite::flatten(tmp$features)
        df$attributes.opening_h <- NULL
        df$attributes.fee_descr <- NULL
        df$time <- Sys.time()
        readr::write_csv(df, "parking.csv", append = file.exists("parking.csv"))
        cat("written at", as.character(Sys.time()), "\n")
    }
    Sys.sleep(5 * 60)
}
