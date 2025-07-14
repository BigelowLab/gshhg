#' Retrieve tables of the filename encodings
#' 
#' These are derived from the SHAPEFILE.TXT file
#' 
#' GSHHS_shp: Shapefiles (polygons) derived from shorelines. These are named 
#' `GSHHS_<resolution>_L<level>.*`
#'   
#' WDBII_shp: Political boundaries and rivers (lines). These are named
#'  `WDBII_border_<resolution>_L<level>.*` and `WDBII_river_<resolution>_L<level>.*`
#' 
#' @export
#' @return named list of encoding tables
gshhg_encodings = function(){
    
  list(
    
    resolution = dplyr::tribble(
      ~code, ~name, ~description,
      "f", "full", "Full resolution. These contain the maximum resolution of this data and has not been decimated.",
      "h", "high", "High resolution. The Douglas-Peucker line reduction was used to reduce data size by ~80% relative to full.",
      "i", "intermediate", "Intermediate resolution. The Douglas-Peucker line reduction was used to reduce data size by ~80% relative to high.",
      "l", "low", "Low resolution. The Douglas-Peucker line reduction was used to reduce data size by ~80% relative to intermediate.",
      "c", "crude", "Crude resolution. The Douglas-Peucker line reduction was used to reduce data size by ~80% relative to low."),
  
    shoreline_level = dplyr::tribble(
      ~level, ~description,
      1, "Continental land masses and ocean islands, except Antarctica.",
      2, "Lakes",
      3, "Islands in lakes",
      4, "Ponds in islands within lakes",
      5, "Antarctica based on ice front boundary.",
      6, "Antarctica based on grounding line boundary."),
    
    border_level = dplyr::tribble(
      ~level, ~description,
      1,"National boundaries.",
      2,"Internal (state) boundaries for the 8 largest countries only.",
      3,"Maritime boundaries."),
    
    river_level = dplyr::tribble(
      ~level, ~description,
       1, "Double-lined rivers (river-lakes).",
       2, "Permanent major rivers.",
       3, "Additional major rivers.",
       4, "Additional rivers.",
       5, "Minor rivers.",
       6, "Intermittent rivers - major.",
       7, "Intermittent rivers - additional.",
       8, "Intermittent rivers - minor.",
       9, "Major canals.",
      10, "Minor canals.",
      11, "Irrigation canals.")
    
  ) # list
  
}