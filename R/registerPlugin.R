#' A pipe-friendly way to register a plugin for a Leaflet map
#'
#' @param map A Leaflet map, eg. the output of `leaflet::leaflet()`
#' @param plugin A plugin, eg. `leaflet.circlesector::circlePlugin`
#' @return The map with the plugin registered
#' @export
#' @family plugin
#' @examples
#' \dontrun{
#' library(leaflet.circlesector)  # loads pipe
#' leaflet::leaflet() %>%
#'    registerPlugin(circlePlugin())
#' }
registerPlugin <- function(map, plugin) {
    map$dependencies <- c(map$dependencies, list(plugin))
    map
}
