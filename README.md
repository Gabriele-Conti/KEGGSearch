
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

## basic example code
entry <- c("map01100", "map01110", "map01120")
result <- KEGGList(entry = entry, database = "pathway")

#> [1] "Selected param: pathway"
#> Querying: https://rest.kegg.jp/list/pathway

print(result)

#>         V1                                           V2
#> 1 map01100                           Metabolic pathways
#> 2 map01110        Biosynthesis of secondary metabolites
#> 3 map01120 Microbial metabolism in diverse environments
```
