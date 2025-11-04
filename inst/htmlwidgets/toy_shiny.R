library(shiny)
library(bslib)
library(mapgl)
library(sf)

nc <- st_read(system.file("shape/nc.shp", package = "sf"))

ui <- page_sidebar(
  title = "mapgl with Shiny",
  sidebar = sidebar(
    sliderInput("slider", "Opacity", value = 1, min = 0, max = 1)
  ),
  card(
    full_screen = TRUE,
    maplibreOutput("map")
  )
)

server <- function(input, output, session) {
  output$map <- renderMaplibre({
    maplibre(
      center = c(-73.93, 40.8),
      zoom = 10,
      style = carto_style("positron")
    ) |>
      mapgl::add_georeferenced_map(
        'https://annotations.allmaps.org/images/d180902cb93d5bf2'
      )
  })

  observeEvent(input$opacity, {
    maplibre_proxy("map") |>
      set_georeferenced_map_opacity(input$opacity)
  })
}

shinyApp(ui, server)
