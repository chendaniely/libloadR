#' Parses a file and returns the lines that load a library
parse_r_script <- function(file, library_pattern = '^\\s*(library|require)\\(\\S*?\\)'){
    lines <- readLines(file)
    # print(lines)
    library_lines <- grep(pattern = library_pattern, x = lines)
    library_lines <- lines[library_lines]
    return(library_lines)
}

#' Parses the name of the library to be loaded
parse_load <- function(load_command){
    open_paren <- regexpr(pattern = '\\(', text = load_command)[1]
    close_paren <- regexpr(pattern = '\\)$', text = load_command)[1]
    substr(x = load_command, start = open_paren + 1, stop = close_paren - 1)
}

#' Load library if it exists, otherwise install the package
load_and_or_install <- function(package_name){
    if (!require(package_name, character.only = TRUE)) {
        install.packages(package_name, dependencies = TRUE)
    }
    library(package_name, character.only = TRUE)
}

libload <- function(file, ...){
    libraries <- parse_r_script(file, ...)
    pkgs <- sapply(X = libraries, FUN = parse_load)
    sapply(X = pkgs, FUN = load_and_or_install)
}