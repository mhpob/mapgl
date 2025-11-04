library(mapgl)
library(htmlwidgets)

## try markers
## Map is accessible using "el.map" !!!
mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  htmlwidgets::onRender(
    "function(el, x) {
      const myMap = el.map;

      new maplibregl.Marker()
      .setLngLat([-71.04, 42.36])
      .addTo(myMap);
    }"
  )


## try layers
mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  htmlwidgets::onRender(
    "function(el, x) {

    el.map.on('load', async () => {
      el.map.addSource('points-source', {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': [
              {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [-71.04, 42.36]
                }
              }
            ]
          }
        });

        el.map.addLayer({
          'id': 'point-layer',
          'source': 'points-source',
          'type': 'circle',
          'paint': {
              'circle-radius': 8,
              'circle-color': '#007cbf'
          }
        });
    })
    }"
  )


allmaps_plugin <- htmltools::htmlDependency(
  name = "allmaps",
  version = "1.0.034",
  # src = c(
  # href = 'https://cdn.jsdelivr.net/npm/@allmaps/maplibre@1.0.0-beta.34/dist/bundled/allmaps-maplibre-4.0.umd.js'
  # ),
  src = file.path(getwd(), 'inst/htmlwidgets/lib/allmaps'),
  script = 'allmaps-maplibre-4.0.umd.js'
)

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  map
}


## notes:
##  - map can be accessed by el.map
##  - to debug: have the map open in a web browser rather than the IDE Viewer
##      - use the browser's developer tools to find what is erroring
##  - need the FULL system path for sources
mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  registerPlugin(allmaps_plugin) |>
  htmlwidgets::onRender(
    "function(el, x) {
      el.map.on('load', async () =>{
        el.map.addSource('points-source', {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': [
              {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [-71.04, 42.36]
                }
              }
            ]
          }
        });

        el.map.addLayer({
          'id': 'point-layer',
          'source': 'points-source',
          'type': 'circle',
          'paint': {
              'circle-radius': 8,
              'circle-color': '#007cbf'
          }
        });

        const warpedMapLayer = new Allmaps.WarpedMapLayer('ID1');
        const annotationURL = 'https://annotations.allmaps.org/images/73def4ccb56259d3';

        el.map.addLayer(warpedMapLayer);
        el.map.moveLayer('ID1');
        warpedMapLayer.addGeoreferenceAnnotationByUrl(annotationURL);
      })
  }"
  )

mapgl::compare(
  mapgl::mapboxgl(center = c(-73.93, 40.80), zoom = 10),
  mapgl::maplibre(center = c(-73.93, 40.80), zoom = 10) |>
    mapgl::add_georeferenced_map(
      'https://annotations.allmaps.org/images/d180902cb93d5bf2',
      opacity = 0.7
    )
)
