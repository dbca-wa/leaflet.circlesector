library(wastdr)
data("wastd_data")
data_thv <- wastd_data %>%
  wastdr::filter_wastd_turtledata(area_name = "Thevenard Island")

fans <- data_thv$nest_fans %>% wastdr::filter_realspecies()
outliers <- data_thv$nest_fan_outliers %>% wastdr::filter_realspecies()
lights <- data_thv$nest_lightsources %>% wastdr::filter_realspecies()

usethis::use_data(fans, compress = "xz", overwrite = TRUE)
usethis::use_data(outliers, compress = "xz", overwrite = TRUE)
usethis::use_data(lights, compress = "xz", overwrite = TRUE)


# Transmute data to default column names and values (radius, colour)
fans_tracks <- fans %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    start_angle = bearing_leftmost_track_degrees,
    end_angle = bearing_rightmost_track_degrees,
    radius = 10,
    weight = 2,
    colour = "blue",
    label = glue::glue(
      "{no_tracks_main_group} tracks, ",
      "path: {stringr::str_replace_all(path_to_sea_comments, 'None', '')}"
    ),
    popup = glue::glue(
      "<h3>{no_tracks_main_group} tracks ",
      "<small>{no_tracks_main_group_min}-{no_tracks_main_group_max}</small></h3>",
      "Path to sea: {stringr::str_replace_all(path_to_sea_comments, 'None', '')}"
    )
  )

# The main direction to water is a 20m blue line
fans_mean <- fans %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    bearing = bearing_leftmost_track_degrees + (
      (bearing_leftmost_track_degrees - bearing_rightmost_track_degrees) / 2),
    angle = 1,
    radius = 15,
    weight = 1,
    colour = "blue",
    label = glue::glue("Mean bearing: {bearing} deg"),
    popup = glue::glue("Mean bearing: {bearing} deg")
  )


# The main direction to water is a 20m black line
fans_water <- fans %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    bearing = bearing_to_water_degrees,
    angle = 1,
    radius = 15,
    weight = 1,
    colour = "black",
    label = glue::glue("Bearing to water: {bearing} deg"),
    popup = glue::glue("Bearing to water: {bearing} deg")
  )


# Outlier tracks are 12m red lines
outlier_segments <- outliers %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    bearing = bearing_outlier_track_degrees,
    angle = 2,
    radius = 12,
    weight = 1,
    colour = "red",
    label = glue::glue("{outlier_group_size} track(s) {bearing} deg {outlier_track_comment}"),
    popup = glue::glue("<h3>{outlier_group_size} track(s)</h3>",
                       "Bearing: {bearing} deg<br/>",
                       "{outlier_track_comment}")
  )


# Known light sources are 100m orange lines
light_segments_artificial <- lights %>%
  dplyr::filter(light_source_type == "artificial") %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    bearing = bearing_light_degrees,
    angle = 1,
    radius = 100,
    weight = 2,
    colour = "#FFC300",
    label = glue::glue("{light_source_description}"),
    popup = glue::glue("<h3>{light_source_description}</h3>",
                       "Artifical light source<br/>",
                       "Bearing {bearing} deg")
  )

light_segments_natural <- lights %>%
  dplyr::filter(light_source_type == "natural") %>%
  dplyr::transmute(
    lat = encounter_latitude,
    lon = encounter_longitude,
    bearing = bearing_light_degrees,
    angle = 1,
    radius = 100,
    weight = 2,
    colour = "#f0ebc2",
    label = glue::glue("{light_source_description}"),
    popup = glue::glue("<h3>{light_source_description}</h3>",
                       "Natural light source<br/>",
                       "Bearing {bearing} deg")
  )

usethis::use_data(fans_tracks, compress = "xz", overwrite = TRUE)
usethis::use_data(fans_mean, compress = "xz", overwrite = TRUE)
usethis::use_data(fans_water, compress = "xz", overwrite = TRUE)
usethis::use_data(outlier_segments, compress = "xz", overwrite = TRUE)
usethis::use_data(light_segments_artificial, compress = "xz", overwrite = TRUE)
usethis::use_data(light_segments_natural, compress = "xz", overwrite = TRUE)

curl::curl_download(
  url = "https://raw.githubusercontent.com/kluizeberg/Leaflet.Circle-sector/master/leaflet.circle-sector.js",
  destfile = here::here("inst/Leaflet.Circle-sector-1.6/leaflet.circle-sector.js")
)
