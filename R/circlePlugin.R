#' Register htmlDependency for leaflet.circle-sector.js
#'
#' This method invokes `htmltools::htmlDependency` with preset arguments to
#' the dependency `Leaflet.Circle-sector`.
#' @export
#' @family plugin
circlePlugin <- function() {
  htmltools::htmlDependency(
    name = "Leaflet.Circle-sector",
    version = "1.6",
    src = system.file('Leaflet.Circle-sector-1.6', package = 'leaflet.circlesector'),
    script = "leaflet.circle-sector.js"
  )
}
