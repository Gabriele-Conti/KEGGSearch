
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KEGGSearch: Comprehensive KEGG Data Retrieval Using Multiple Sources

<!-- badges: start -->
<!-- badges: end -->

## Description

The KEGGSearch package provides an extensive toolkit for retrieving KEGG
(Kyoto Encyclopedia of Genes and Genomes) information from multiple
sources, enabling flexible and comprehensive access to biological
pathway and module data. It includes functions to query KEGG IDs via the
official KEGG REST API and alternative sources such as Bio2RDF, as well
as a manually curated dataset for enhanced coverage of KEGG modules. The
package facilitates efficient data extraction and integration for
bioinformatics analysis.

## Key Functions

- *KEGGList()* – Retrieves KEGG entity names (pathways, compounds, etc.)
  using the official KEGG REST API.
- *GETKEGGNames()* – Fetches KEGG entity names via the Bio2RDF API as an
  alternative data source.
- *GETKEGG_Module()* – Combines Bio2RDF data with a manually curated
  KEGG module table to enhance data availability.

This package is useful for researchers and bioinformaticians needing
reliable and extensive access to KEGG resources for biological analysis
and pathway enrichment studies.

## Installation

You can install the development version of KEGGSearch from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Gabriele-Conti/KEGGSearch")
```

Depends: dplyr, tibble, httr, jsonlite

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# import dependances
library(KEGGPackage)
library(dplyr)
library(tibble)
library(httr)
library(jsonlite)

## KEGGList basic example code
entry <- c("map01100", "map01110", "map01120")
result <- KEGGList(entry = entry, database = "pathway")
#> [1] "Selected param: pathway"
#> Querying: https://rest.kegg.jp/list/pathway
print(result)
#>         V1                                           V2
#> 1 map01100                           Metabolic pathways
#> 2 map01110        Biosynthesis of secondary metabolites
#> 3 map01120 Microbial metabolism in diverse environments

## GETKEGGNames basic example code
KEGG_IDs <- c("map01100", "map01110", "map01120")
result <- GETKEGGNames(KEGG_IDs)
print(result)
#>                                                                   Names
#> map01100                           Metabolic pathways\n [kegg:map01100]
#> map01110        Biosynthesis of secondary metabolites\n [kegg:map01110]
#> map01120 Microbial metabolism in diverse environments\n [kegg:map01120]

## KEGGList basic example code
modules_IDs <- c("M00005", "M00045", "M00060")
result <- GETKEGG_Module(modules_IDs)
#> All KEGG modules are present in the local database ...
print(result)
#>        KEGG.modules
#> M00005       M00005
#> M00045       M00045
#> M00060       M00060
#>                                                                  Description
#> M00005                                  PRPP biosynthesis, ribose 5P => PRPP
#> M00045 Histidine degradation, histidine => N-formiminoglutamate => glutamate
#> M00060              KDO2-lipid A biosynthesis, Raetz pathway, LpxL-LpxM type
```

## Citation

If you use this R package please cite this GitHub in your article:

    @Manual{,
      title = {KEGGSearch: Comprehensive KEGG Data Retrieval Using Multiple Sources},
      author = {Gabriele Conti},
      year = {2025},
      note = {R package version 0.0.1},
      url = {https://github.com/Gabriele-Conti/KEGGSearch.git},
    }

**Example** <br> Conti, G. (2025) KEGGSearch: Comprehensive KEGG Data
Retrieval Using Multiple Sources (v0.0.1). Available on Github:
<https://github.com/Gabriele-Conti/KEGGSearch><br/>
