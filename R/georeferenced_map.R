#' Add an Allmaps georeferenced map layer
#'
#' This function adds a georeferenced map from [Allmaps.org](https://allmaps.org/)
#' as a layer to the current map. For further information and more-thorough
#' documentation of the plugin, visit the
#' [@allmaps/maplibre website](https://github.com/allmaps/allmaps/tree/develop/packages/maplibre)
#'
#' @param map A map object created by the `maplibre()` functions.
#' @param url An Allmaps URL or list of URLs. (Required).
#' @param id An optional unique ID for the warped map layer. If NULL, it will
#'  default to "warped-map-layer".
#' @param opacity An optional numeric between 0 and 1. Controls the opacity of
#'  the warped map layer. If NULL, it will default to 1.
#' @param colorize An optional colorization to apply to the map. Must be a hex code.
#' @param remove_color An optional list containing options for color removal:
#'   * `color`: The hex code of the color to remove
#'   * `threshold`: Numeric threshold for color removal (0-1)
#'   * `hardness`: Hardness of the color removal effect (0-1)
#' @param saturation An optional numeric between 0 and 1. Adjusts the saturation
#'  of the warped map, where 0 is grayscale and 1 is full color. If NULL, it will
#'  default to 1.
#' @param before_id The name of the layer that this layer appears "before",
#'  allowing you to insert layers below other layers in your basemap (e.g. labels).
#'
#' @return The modified map object with the warped map layer added.
#' @export
#'
#' @seealso
#' * [maplibre()] for creating the base map
#' * [add_layer()] for adding other types of layers
#'
#'
#' @examples
#' \dontrun{
#' library(mapgl)
#'
#' # Add a georeferenced map with a unique ID, 75% opacity,
#' #   and colorized to blue
#' maplibre(center = c(-73.95, 40.75), zoom = 10) |>
#'   add_georeferenced_map(
#'     id = "old-manhattan",
#'     url = "https://annotations.allmaps.org/images/d180902cb93d5bf2",
#'     opacity = 0.75,
#'     colorize = "#0000FF"
#'   )
#' # Add a georeferenced map with background gray removed at custom threshold
#' #  and hardness levels, then converted to grayscale
#' maplibre(center = c(-73.95, 40.75), zoom = 10) |>
#'   add_georeferenced_map(
#'     url = "https://annotations.allmaps.org/images/d180902cb93d5bf2",
#'     remove_color = list(
#'       color = "#b7c3b8",
#'       threshold = 0.3,
#'       hardness = 0.5
#'     ),
#'     saturation = 0
#'   )
#' }
add_georeferenced_map <- function(
  map,
  url,
  id = NULL,
  opacity = NULL,
  colorize = NULL,
  remove_color = list(
    color = NULL,
    threshold = NULL,
    hardness = NULL
  ),
  saturation = NULL,
  before_id = NULL
) {
  # Create the warped map layer configuration
  georeferenced_map_config <- list(
    list(
      id = id,
      url = if (is.list(url)) url else list(url),
      opacity = opacity,
      colorize = colorize,
      remove_color = remove_color,
      saturation = saturation,
      before_id = before_id
    )
  )

  # Add the warped map layer to the map's configuration
  if (!is.null(map$x$georeferenced_map)) {
    map$x$georeferenced_map <- c(
      map$x$georeferenced_map,
      georeferenced_map_config
    )
  } else {
    map$x$georeferenced_map <- georeferenced_map_config
  }

  return(map)
}
