#' Turtle hatchling nest emergences: Main fan of tracks
#'
#' Nest fans are described by
#' * encounter_source_id A UUID for the TurtleNestEncounter
#' * encounter_when Datetime of the encounter
#' * encounter_latitude Latitude of the encounter in decimal degrees WGS84
#' * encounter_laongitude Longitude of the encounter in decimal degrees WGS84
#' * encounter_name The nest tag if known, a unique ID for the nest
#' * encounter_species The species of turtle which laid that nest
#' * bearing_leftmost_track_degrees The leftmost fan angle bearing
#' * bearing_rightmost_track_degrees The rightmost fan angle bearing
#' * no_tracks_main_group The number of hatchling tracks in the main group of
#'   tracks, best estimate
#' * no_tracks_main_group_min The number of hatchling tracks in the main group of
#'   tracks, lowest estimate
#' * no_tracks_main_group_max The number of hatchling tracks in the main group of
#'   tracks, highest estimate
#' * outlier_tracks_present Whether outlier tracks were present
#' * path_to_sea_comments Any comments on the path to sea, e.g. whether obstructed
#' * hatchling_emergence_time_known Whether the exact time of the emergence is known
#' * light_sources_present
#' * hatchling_emergence_time
#' * hatchling_emergence_time_accuracy
#' * cloud_cover_at_emergence
#' * datetime
#' * calendar_date_awst
#' * calendar_date_awst_text
#' * calendar_year
#' * turtle_date
#' * turtle_date_awst_text
#' * season
#' * season_week
#' * iso_week
#'
#' @family included
"fans"

#' Turtle hatchling nest emergences: Individual outlier tracks
#'
#' With the same base columns as in dataset fans:
#' * bearing_outlier_track_degrees The compass bearing of the outlier track 5m
#'   from the nest in degrees
#' * outlier_group_size The number of tracks in the outlier group, typically 1
#' * outlier_track_comment Any further comments on the outlier track
#'
#' @family included
"outliers"

#' Turtle hatchling nest emergences: Known light sources
#'
#' With the same base columns as fans:
#' * bearing_light_degrees
#' * light_source_type
#' * light_source_description
#'
#' @family included
"lights"


#' A data frame ready to be used in `addCircleSectorMinMax`
#'
#' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * start_angle
#' * end_angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"fans_tracks"


#' A data frame ready to be used in `addCircleSectorMid`
#'
#' #' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * mid
#' * angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"fans_mean"



#' A data frame ready to be used in `addCircleSectorMid`
#'
#' #' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * mid
#' * angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"fans_water"


#' A data frame ready to be used in `addCircleSectorMid`
#'
#' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * mid
#' * angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"outlier_segments"


#' A data frame ready to be used in `addCircleSectorMid`
#'
#' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * mid
#' * angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"light_segments_artificial"


#' A data frame ready to be used in `addCircleSectorMid`
#'
#' This data frame is created from `fans` in `inst/generate_data.R`.
#'
#' Columns:
#' * lat
#' * lon
#' * mid
#' * angle
#' * radius
#' * weight
#' * colour
#' * popup
#'
#' @family included
"light_segments_natural"
