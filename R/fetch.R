#' Fetch a version and store in the root data path
#' 
#' @export
#' @param url chr the URL to the version to download
#' @param path chr, the destination path
#' @param cleanup logical, if TRUE clean up the intermediary download files
#' @return 0 for success and non-zero otherwise
fetch_version = function(url = 'https://www.ngdc.noaa.gov/mgg/shorelines/data/gshhg/latest/gshhg-shp-2.3.7.zip',
                         path = gshhg_path(),
                         cleanup = TRUE){
  bname = basename(url[1])
  bname = gsub(".zip", "", basename(url[1]), fixed = TRUE)
  v = strsplit(bname,"-", fixed = TRUE)[[1]][3]
  dstpath = file.path(path, "versions", v) |>
    make_path()
  tmppath = file.path(path,"temp") |>
    make_path()
  tmpfile = file.path(tmppath, basename(url))
  ok = download.file(url[1], tmpfile, mode = "wb")
  if (ok == 0)  files = archive::archive_extract(tmpfile,  dir = dstpath)
  if (cleanup)  unlink(tmpfile)
  ok
}