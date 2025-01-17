#' Check params
#'
#' Retrieve KEGG pathway names for a specific organism.
#' @param param A character will be used as parameter in a function.
#' @param allowed_params Allowed characters used as parameter in a function.
#' @return Zero value if the param match the allowed_params, 1 if input are invalid, 2 if param does not match.
#' @export

check_param <- function(param, allowed_params) {
  # Ensure both inputs are valid
  if (!is.character(param) || length(param) != 1) {
    message(paste(param, "must be a single string.\nAllowed params are:", paste(allowed_params, collapse = ", ")))
    return(1)
  }
  # Check if the input is valid
  if (!param %in% allowed_params) {
    message(paste("Invalid param:", param,
                  "\nAllowed params are:", paste(allowed_params, collapse = ", ")))
    return(2)
  }
  # If valid, proceed with the function logic
  print(paste("Selected param:", param))
  return(0)
}

as.character()
