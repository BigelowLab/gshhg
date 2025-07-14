#' Crop a gshhg sf object 
#' 
#' @export
#' @param x sf or sfc object
#' @param bb object from which an st_bbox can be extracted
#' @return cropped geometry object (attributes of input are dropped)
gsshg_crop = function(x, bb){
  orig = sf::sf_use_s2(FALSE)
  on.exit({
    sf::sf_use_s2(orig)
  })
  sf::st_geometry(x) |> 
    sf::st_make_valid() |> 
    sf::st_crop(bb)
}

#' Read gshhg data by group, resolution and level.  
#' 
#' See [`help_shapefiles`] for detailed explanations or 
#' [`gsshg_encodings`] for info on the encoding values.
#' 
#' @export
#' @param group chr one of "shoreline" (default), "border" or "river"
#' @param res chr one of f, h, i, l or c (full, high, intermediate, low, crude). 
#'   "f" is default.
#' @param level integer, for shoreline group 1-6, for border group 1-3 and for river group 1-11
#'   Defaults to 1.
#' @param bb NULL or something from which a bounding box can be found for clipping,
#'   if not NULL then attributes are dropped in favor of returning geometry only. 
#' @param version chr, the data version (default 2.3.7)
#' @param path chr, the gshhg data path
#' @return sf object
read_gshhg = function(
    group = c("shoreline" , "border", "river")[1],
    res = c("f", "h", "i", "l", "c")[1],
    level = 1,
    bb = NULL,
    version = "2.3.7",
    path = gshhg_path()){
  
  #' GSHHS_shp: Shapefiles (polygons) derived from shorelines. These are named 
  #' `GSHHS_<resolution>_L<level>.*`
  #'   
  #' WDBII_shp: Political boundaries and rivers (lines). These are named
  #'  `WDBII_border_<resolution>_L<level>.*` and `WDBII_river_<resolution>_L<level>.*`  
    
  pat = switch(tolower(group[1]),
    "shoreline" = "GSHHS_shp/%s/GSHHS_%s_L%i.shp",
    "border"    = "WDBII_shp/%s/WDBII_border_%s_L%i.shp",
    "river"     = "WDBII_shp/%s/WDBII_river_%s_L%i.shp",
    stop("group not known:", group[1]))
  filename = file.path(path, "versions", version[1],
                       sprintf(pat, res[1], res[1], level[1]))
  if (!file.exists(filename)){
    stop("file not found: ", filename)
  }
  x = sf::read_sf(filename)
  if (!is.null(bb)) x = gsshg_crop(x, bb)
  x
}


#' Read the "SHAPEFILE.TXT" for a given version
#' 
#' @export
#' @param version chr, the data version (default 2.3.7)
#' @param path chr the gshhg data path
#' @return chr vector of file data, one line per element
help_shapefiles = function(version = "2.3.7",
                           path = gshhg_path()){
  filename = file.path(path, "versions", version[1], "GSHHS_shp", "SHAPEFILES.TXT")
  if (!file.exists(filename)) stop("file not found: ", filename)
  readLines(filename)
}    
