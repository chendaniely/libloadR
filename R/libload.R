#' Parses a file and returns the lines that load a library
#'
#' This function takes a file and will return the lines of the file that
#' match the given library_pattern
#'
#' @param file R script file
#' @param library_pattern regular expression to look for lines that load packages
#' @return library_lines lines of the file that load a package
.parse_r_script <- function(file,
                           library_pattern = '^\\s*(library|require)\\(\\S*?\\)'){
    lines <- readLines(file)
    # print(lines)
    library_lines <- grep(pattern = library_pattern, x = lines)
    library_lines <- lines[library_lines]
    return(library_lines)
}

#' Parses the name of the library to be loaded
#'
#' This function takes in the load commands from .parse_r_script and only
#' returns the package name
#'
#' @param load_command line of the file that loads a package
#' @return library_name returns the library name that was in the load_command
.parse_load <- function(load_command){
    open_paren <- regexpr(pattern = '\\(', text = load_command)[1]
    close_paren <- regexpr(pattern = '\\)', text = load_command)[1]
    substr(x = load_command, start = open_paren + 1, stop = close_paren - 1)
}

#' Load library if it exists, otherwise install the package
#'
#' This function will try to load a package name, if the package does not exist
#' it will install the package and then load it
#'
#' @param package_name package name to load
.load_and_or_install <- function(package_name){
    if (!require(package_name, character.only = TRUE)) {
        install.packages(package_name, dependencies = TRUE)
    }
    library(package_name, character.only = TRUE)
}

#' Load all libraries from an R script and install them as needed
#'
#' This function will take a R script, load any packages, and install packages
#' as needed
#'
#' @param file R script file to load
#' @param ... library_pattern to be passed into .parse_r_script
#'
#' @export
#'
#' @examples
#' \dontrun{
#' libload('r_script_file.R')
#' }
#'
libload <- function(file, ...){
    libraries <- .parse_r_script(file, ...)
    pkgs <- sapply(X = libraries, FUN = .parse_load)
    sapply(X = pkgs, FUN = .load_and_or_install)
}
