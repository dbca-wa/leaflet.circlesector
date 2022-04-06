test_that("addCircleSectorMinMax returns a leaflet map", {
    data("fans_tracks")
    themap <- leaflet_basemap(l_height = 500, l_width = 700) %>%
        addCircleSectorMinMax(data = fans_tracks)

    expect_s3_class(themap, "leaflet")
})

test_that("addCircleSectorMid returns a leaflet map", {
    data("fans_mean")
    themap <- leaflet_basemap(l_height = 500, l_width = 700) %>%
        addCircleSectorMid(data = fans_mean)

    expect_s3_class(themap, "leaflet")
})
