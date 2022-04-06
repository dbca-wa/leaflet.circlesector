test_that("leaflet_basemap works", {
  themap <- leaflet_basemap()
  expect_s3_class(themap, "leaflet")
})
