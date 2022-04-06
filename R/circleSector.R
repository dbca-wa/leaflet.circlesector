#' Add Circle sectors to a Leaflet map from a dataframe using start and end
#' angles
#'
#' This methor wraps the `setAngles` method of
#' [Leaflet.Circle-sector](https://github.com/kluizeberg/Leaflet.Circle-sector),
#' a Leaflet plugin extending
#' [L.Circle](https://leafletjs.com/index.html#circle).
#'
#'
#' @param map A leaflet map
#' @param data A data frame where each row represents on circle sector and
#'   columns for lat, lon, min, mid, max.
#' @param lat The column name as string holding the Latitude of the circle mid
#'   point on the map in WGS 84 decimal degrees. Default: "lat".
#' @param lon The column name as string holding the Longitude of the circle mid
#'   point on the map in WGS 84 decimal degrees. Default: "lon".
#' @param start_angle The column name as string holding the startAngle of the sector
#'   in decimal degrees, counted clockwise from North. Default: "start_angle".
#' @param end_angle The column name as string holding the endAngle of the sector
#'   in decimal degrees, counted clockwise from North. Default: "end_angle".
#' @param radius The column name as string holding the radius of the circle in
#'   metres. Default: "radius".
#' @param weight The column name as string holding the weight of the circle.
#'   Default: "weight.
#' @param colour The column name as string holding the colour of the circle.
#'   Default: "colour". Example values: "blue", "red", "#3388ff".
#' @param label The column name as string holding the label content of the circle.
#'   Default: "label".
#' @param popup The column name as string holding the popup content of the circle.
#'   Default: "popup".
#' @export
#' @family plugin
#' @examples
#' \dontrun{
#' data("fans_tracks")
#'
#' leaflet_basemap(l_height = 500, l_width = 700) %>%
#'   leaflet::clearBounds() %>%
#'   addCircleSectorMinMax(data = fans_tracks)
#' }
addCircleSectorMinMax <- function(map,
                                  data,
                                  lat = "lat",
                                  lon = "lon",
                                  start_angle = "start_angle",
                                  end_angle = "end_angle",
                                  radius = "radius",
                                  weight = "weight",
                                  colour = "colour",
                                  label = "label",
                                  popup = "popup") {

  # TODO abort if required cols are missing in data
  # TODO warn and swap if max < min bearings
  # TODO warn and treat if (max - min) > 360


  # Interpolate column names in JS onRender function
  js_string <- glue::glue("
    function(el, x, data) {{
        for (var i = 0; i < data.{lon}.length; i++) {{
            L.circle(
                [data['{lat}'][i], data['{lon}'][i]], {{
	            color: data['{colour}'][i],
	            radius: data['{radius}'][i],
	            weight: data['{weight}'][i]
                }})
        .setAngles(data['{start_angle}'][i], data['{end_angle}'][i])
        .bindTooltip(data['{label}'][i])
    	.bindPopup(data['{popup}'][i])
    	.addTo(this);
    }}
 }}")

  map %>%
    registerPlugin(circlePlugin()) %>%
    htmlwidgets::onRender(js_string, data = data) %>%
    leaflet::expandLimits(dplyr::pull(data, lat), dplyr::pull(data, lon))
}

#' Add Circle sectors to a Leaflet map from a dataframe using bearing and spread
#'
#' This methor wraps the `setSector` method of
#' [Leaflet.Circle-sector](https://github.com/kluizeberg/Leaflet.Circle-sector),
#' a Leaflet plugin extending [L.Circle](https://leafletjs.com/index.html#circle).
#'
#' @param map A leaflet map
#' @param data A data frame where each row represents on circle sector and
#'   columns for lat, lon, min, mid, max.
#' @param lat The column name as string holding the Latitude of the circle mid
#'   point on the map in WGS 84 decimal degrees. Default: "lat".
#' @param lon The column name as string holding the Longitude of the circle mid
#'   point on the map in WGS 84 decimal degrees. Default: "lon".
#' @param bearing The column name as string holding the main bearing of the sector
#'   in decimal degrees, counted clockwise from North. Default: "bearing".
#' @param angle max The column name as string holding the angle of the sector
#'   in decimal degrees, which will be centered on the main direction `mid`.
#'   Default: "angle".
#' @param radius The column name as string holding the radius of the circle in
#'   metres. Default: "radius".
#' @param weight The column name as string holding the weight of the circle.
#'   Default: "weight.
#' @param colour The column name as string holding the colour of the circle.
#'   Default: "colour". Example values: "blue", "red", "#3388ff".
#' @param label The column name as string holding the label content of the circle.
#'   Default: "label".
#' @param popup The column name as string holding the popup content of the circle.
#'   Default: "popup".
#' @export
#' @export
#' @family plugin
#' @examples
#' \dontrun{
#' data("fans_mean")
#'
#' leaflet_basemap(l_height = 500, l_width = 700) %>%
#'   leaflet::clearBounds() %>%
#'   addCircleSectorMid(data = fans_mean)
#' }
addCircleSectorMid <- function(map,
                               data,
                               lat = "lat",
                               lon = "lon",
                               bearing = "bearing",
                               angle = "angle",
                               radius = "radius",
                               weight = "weight",
                               colour = "colour",
                               label = "label",
                               popup = "popup") {

  # TODO abort if required cols are missing in data
  # TODO warn and swap if max < min bearings
  # TODO warn and treat if mid outside [0:360]

  # Interpolate column names in JS onRender function
  js_string <- glue::glue("
    function(el, x, data) {{
        for (var i = 0; i < data.{lon}.length; i++) {{
            L.circle(
                [data['{lat}'][i], data['{lon}'][i]], {{
	            color: data['{colour}'][i],
	            radius: data['{radius}'][i],
	            weight: data['{weight}'][i]
                }})
        .setSector(data['{bearing}'][i], data['{angle}'][i])
        .bindTooltip(data['{label}'][i])
    	.bindPopup(data['{popup}'][i])
    	.addTo(this);
    }}
 }}")


  map %>%
    registerPlugin(circlePlugin()) %>%
    htmlwidgets::onRender(js_string, data = data) %>%
    leaflet::expandLimits(dplyr::pull(data, lat), dplyr::pull(data, lon))
}

# usethis::use_test("addCircleSector")  # nolint
