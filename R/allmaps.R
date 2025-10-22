#' Add an Allmaps warped map layer to a map
#'
#' This function adds a warped map layer using the Allmaps library to transform
#' historical maps onto the current map projection.
#'
#' @param map A map object created by the `mapboxgl()` or `maplibre()` functions.
#' @param id A unique ID for the warped map layer.
#' @param url A URL or list of URLs to IIIF annotations for georeferencing, or a list of annotation objects.
#' @param options A list of options for the warped map layer. See details for available options.
#'
#' @details
#' The options list can include:
#' \itemize{
#'   \item opacity - The opacity of the warped map (0-1)
#'   \item minzoom - Minimum zoom level at which the layer is visible
#'   \item maxzoom - Maximum zoom level at which the layer is visible
#'   \item bounds - An array of west, south, east, north coordinates to restrict rendering
#'   \item attribution - Attribution text to display
#' }
#'
#' @return The modified map object with the warped map layer added.
#' @export
#'
#' @examples
#' \dontrun{
#' library(mapgl)
#'
#' # Create a map
#' map <- maplibre() %>%
#'   set_view(lng = 4.9, lat = 52.4, zoom = 10)
#'
#' # Add a warped historical map
# ' map %>% add_allmaps_layer(
# '   id = "old-manhattan",
# '   url = "https://annotations.allmaps.org/images/d180902cb93d5bf2",
# '   options = list(
# '     opacity = 0.7,
# '     minzoom = 8,
# '     maxzoom = 18
# '   )
# ' )
#' }
add_allmaps_layer <- function(
  map,
  id,
  url,
  options = NULL
) {
  # Create the warped map layer configuration
  warped_map_layer <- list(
    id = id,
    options = options,
    url = if (is.list(url)) url else list(url)
  )

  # Add the warped map layer to the map's configuration
  map$x$warped_map_layer <- warped_map_layer

  return(map)
}
