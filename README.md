[![DOI](https://zenodo.org/badge/11594/chendaniely/libloadR.svg)](http://dx.doi.org/10.5281/zenodo.18115)
![release](https://img.shields.io/github/release/chendaniely/libloadR.svg)
![downloads](https://img.shields.io/github/downloads/chendaniely/libloadR/latest/total.svg)

# libloadR
R package that handles loading and installing multiple libraries from an R script file

## Problem
You are given an R script and it has many `library` loads.
You know you do not have all the libraries needed and there are too many libraries to re-type into a vector

## Solution
This package!

The `libload` function will take a R script file and find all the library (or require) calls.
It will then try to load each library, and automaticall run `install.packages` if you do not already have the library.

## How to download
I haven't gotten this cran ready (yet) but there are a few ways you can get the function

1.  using the `devtools` package and the `install_github('chendaniely/libloadR')` function to download and install
1.  `wget` the R script with `wget https://github.com/chendaniely/libloadR/raw/master/R/parse_r_script.R `
  and then `source` the `parse_r_script.R` file to get the `libload` function in your environment
1.  Downloading the script directly from github
  1.  go to: https://github.com/chendaniely/libloadR/blob/master/R/parse_r_script.R and then right clock 'raw' and
    'save as' the file somewhere on yoru computer and then within R `source` the file and use the `libload` function

## How to use

`libloadR::libload('path_to_r_script_file.R')`

## Personal Motivation
I had a R script with 18 libraries to load while attending a workshop on GIS in R by
[Emily Molfino](http://vbi.vt.edu/sdal/people/people-profile/Emily-Molfino).
I knew the majority of these packages were not installed on the server I was working on.
I also did not want to end up typing all the package names into a vector to then be passed into `install.packages`,
for some reason I felt R should just do all that for me...

## Thanks

Thanks [Aaron Schroeder](https://www.vbi.vt.edu/people/people-profile/Aaron-Schroeder) for the idea and name
