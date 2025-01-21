#' Specific function to retrive KEGG Modules names using local database and https://bio2rdf.org/ resurces
#'
#' Retrieve KEGG modules IDs.
#' @param modules_IDs A KEGG code string (e.g., modules_IDs <- c("M00005", "M00045", "M00060")).
#' @return A data frame with KEGG modules IDs and names.
#' @export

GETKEGG_Module <- function(modules_IDs){
  # Ensure required libraries are available
  if (!requireNamespace("httr", quietly = TRUE)) stop("Package 'dplyr' is required.")
  if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package 'tibble' is required.")

  # Find the path of the KEGG_Modules.rds file inside the installed package
  file_path <- system.file("extdata", "KEGG_Modules.rds", package = "KEGGPackage")

  # Check if the file exists
  if (file_path == "") {
    stop("The KEGG_Modules.rds file could not be found in the package.")
  }

  # Import the KEGG_table
  KEGG_table <- readRDS(file_path)

  # Filtering local database with input KEGG modules
  retrived_modules <- KEGG_table[modules_IDs,]

  # Check if all input modules are present in the DB and retun the output if TRUE
  if (all(rownames(retrived_modules) == modules_IDs)){
    message("All KEGG modules are present in the local database ...")
    return(retrived_modules)
  }

  # Defining missed modules
  missed_modules <- modules_IDs[!(modules_IDs %in% rownames(retrived_modules))]

  # Preparing data for the call
  KEGG_df <- as.data.frame(matrix(nrow = length(missed_modules), ncol = 2), row.names = missed_modules)
  colnames(KEGG_df) <- c("KEGG.modules", "Description")
  KEGG_df$KEGG.modules <- missed_modules

  for (entry in missed_modules){
    link <- paste0("http://bio2rdf.org/kegg:", entry)
    response <- httr::GET(link)

    # Check if the request was successful
    if (httr::status_code(response) == 200) {
      # Extract content as text
      content_text <- httr::content(response, as = "text", encoding = "UTF-8")

      # Parse the JSON content
      parsed_content <- jsonlite::fromJSON(content_text)

      # Check if the JSON object is empty
      if (length(parsed_content) == 0) {
        message(paste("No data found for:", entry))
        next  # Skip to the next iteration without breaking the loop
      }

      # Extract specific information
      retrived_name <- parsed_content[[link]][["http://www.w3.org/2000/01/rdf-schema#label"]][["value"]]

      # generating retrived KEGG vector names
      KEGG_df[entry, "Description"] <- retrived_name

    } else {
      cat("Request failed with status:", status_code(response), "\n")
      return(NULL)
    }
  }

  KEGG_names <- rbind(retrived_modules, KEGG_df)
  KEGG_names <- KEGG_names[modules_IDs[modules_IDs %in% KEGG_names],]
  return(KEGG_names)
}

