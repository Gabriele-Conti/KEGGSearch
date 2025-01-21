
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KEGGPackage

<!-- badges: start -->
<!-- badges: end -->

The goal of KEGGPackage is to provide useful function to quering the
KEGG databases using KEGG API

## Installation

You can install the development version of KEGGPackage from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Gabriele-Conti/KEGGSearch")
```

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
