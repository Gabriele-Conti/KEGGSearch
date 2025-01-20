#' Get KEGG names using https://bio2rdf.org/ resurces
#'
#' Retrieve KEGG ID names for a specific organism.
#' @param KEGG_IDs A KEGG code string (e.g., KEGG_IDs <- c("map01100", "map01110", "map01120")).
#' @return A data frame with IDs and names.
#' @export

GETKEGGNames <- function(KEGG_IDs){
  # Ensure required libraries are available
  if (!requireNamespace("httr", quietly = TRUE)) stop("Package 'dplyr' is required.")
  if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package 'tibble' is required.")

  KEGG_names <- as.data.frame(matrix(nrow = length(KEGG_IDs), ncol = 1), row.names = KEGG_IDs)
  colnames(KEGG_names) <- "Names"

  for (entry in KEGG_IDs){

    link <- paste0("http://bio2rdf.org/kegg:", entry)
    response <- httr::GET(link)

    # Check if the request was successful
    if (httr::status_code(response) == 200) {
      # Extract content as text
      content_text <- httr::content(response, as = "text", encoding = "UTF-8")

      # Parse the JSON content
      parsed_content <- jsonlite::fromJSON(content_text)

      # Extract specific information
      retrived_name <- parsed_content[[link]][["http://www.w3.org/2000/01/rdf-schema#label"]][["value"]]

      # generating retrived KEGG vector names
      KEGG_names[entry, "Names"] <- retrived_name

    } else {
      cat("Request failed with status:", status_code(response), "\n")
      return(NULL)
    }
  }
  return(KEGG_names)
}

