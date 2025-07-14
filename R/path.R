#' Set the gshhg data path
#'
#' @export
#' @param path the path that defines the location of ghssg data
#' @param filename the name the file to store the path as a single line of text
#' @return NULL invisibly
set_root_path <- function(path = "/mnt/s1/projects/ecocast/coredata/gshhg",
                          filename = "~/.gshhgdata"){
  cat(path, sep = "\n", file = filename)
  invisible(NULL)
}

#' Get the ghssg data path from a user specified file
#'
#' @export
#' @param filename the name the file to store the path as a single line of text
#' @return character data path
root_path <- function(filename = "~/.gshhgdata"){
  readLines(filename)
}



#' Retrieve the gshhg path
#'
#' @export
#' @param ... further arguments for \code{file.path()}
#' @param root the root path
#' @return character path description
gshhg_path <- function(..., root = root_path()) {
  file.path(root, ...)
}

#' Given a path - make it if it doesn't exist
#'
#' @export
#' @param path character, the path to check and/or create
#' @param recursive logical, create paths recursively?
#' @param ... other arguments for \code{dir.create}
#' @return the path
make_path <- function(path, recursive = TRUE, ...){
  ok <- dir.exists(path[1])
  if (!ok){
    ok <- dir.create(path, recursive = recursive, ...)
  }
  path
}


#' List the available versions
#' 
#' @export
#' @param path the root data path
#' @param ... other arguments for file.path
#' @return character vector of version IDs
list_versions = function(path = gshhg_path("versions"), ...){
  list.files(path)
}
