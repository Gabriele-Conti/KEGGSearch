#' Get KEGG names using KEGG API
#'
#' Retrieve KEGG pathway names for a specific organism.
#' @param entry A KEGG code string (e.g., entry <- c("map01100", "map01110", "map01120")).
#' @param database Define selected KEGG database to query.
#' @return A data frame with IDs and names.
#' @export
KEGGList <- function(entry, database) {
  # Ensure required libraries are available
  if (!requireNamespace("dplyr", quietly = TRUE)) stop("Package 'dplyr' is required.")
  if (!requireNamespace("tibble", quietly = TRUE)) stop("Package 'tibble' is required.")

  # Validate the database
  allowed_db <- c("pathway", "brite", "module", "ko", "vg", "vp", "ag", "genome",
                  "compound", "glycan", "reaction", "rclass", "enzyme", "network",
                  "variant", "disease", "drug", "dgroup", "organism")
  db_val <- check_param(database, allowed_db)

  if (db_val != 0) {
    if (db_val == 2) {
      message("Checking for a valid organism ID...")
      allowed_org <- read.table("https://rest.kegg.jp/list/organism", header = FALSE, sep = "\t",
                                quote = "", stringsAsFactors = FALSE, fill = TRUE)$V2
      if (!database %in% allowed_org) {
        stop("Invalid database or organism ID. Exiting.")
      }
    } else {
      stop("Invalid database. Exiting.")
    }
  }

  # Query the KEGG API
  link <- paste0("https://rest.kegg.jp/list/", database)
  message("Querying: ", link)
  data_table <- read.table(link, header = FALSE, sep = "\t", quote = "",
                           stringsAsFactors = FALSE, fill = TRUE)

  # Filter for matching entries
  matches_table <- data_table %>% dplyr::filter(V1 %in% entry)
  if (nrow(matches_table) == 0) {
    message("No matches found. Check `entry` format for the queried database: ", link)
    return(NULL)
  }

  return(matches_table)
}
