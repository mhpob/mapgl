#' @export
add_allmaps_layer <- function(
  map,
  id,
  url,
  options = NULL
) {
  warped_map_layer <- list(
    id,
    options,
    url
  )
  map$x$warped_map_layer <- c(map$x$warped_map_layer, list(warped_map_layer))

  return(map)

  # paint <- list()
  # layout <- list()

  # if (!is.null(raster_brightness_max)) {
  #   paint[["raster-brightness-max"]] <- raster_brightness_max
  # }
  # if (!is.null(raster_brightness_min)) {
  #   paint[["raster-brightness-min"]] <- raster_brightness_min
  # }
  # if (!is.null(raster_contrast)) {
  #   paint[["raster-contrast"]] <- raster_contrast
  # }
  # if (!is.null(raster_fade_duration)) {
  #   paint[["raster-fade-duration"]] <- raster_fade_duration
  # }
  # if (!is.null(raster_hue_rotate)) {
  #   paint[["raster-hue-rotate"]] <- raster_hue_rotate
  # }
  # if (!is.null(raster_opacity)) {
  #   paint[["raster-opacity"]] <- raster_opacity
  # }
  # if (!is.null(raster_resampling)) {
  #   paint[["raster-resampling"]] <- raster_resampling
  # }
  # if (!is.null(raster_saturation)) {
  #   paint[["raster-saturation"]] <- raster_saturation
  # }

  # if (!is.null(visibility)) {
  #   layout[["visibility"]] <- visibility
  # }

  # map <- add_layer(
  #   map,
  #   id,
  #   "raster",
  #   source,
  #   source_layer,
  #   paint,
  #   layout,
  #   slot,
  #   min_zoom,
  #   max_zoom,
  #   before_id
  # )

  # return(map)
}
