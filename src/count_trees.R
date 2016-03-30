# Load required libraries
library(sp)     # SpatialLinesDataFrame, over()
library(rgdal)  # ReadOGR(), spTransform()
library(rgeos)  # gBuffer()
library(dplyr)  # %>%, group_by, summarise, left_join, etc

# Read sidewalks GeoJSON into a SpatialLinesDataFrame
sidewalks <- readOGR("data/sidewalk-grades-geoJSON-latest.json", "OGRGeoJSON")

# Load street trees shapefile
trees <- readOGR("/Users/miles/edu/sliderule/data_wrangling/Trees/StatePlane", "Trees")
# trees.wgs84 <- readOGR("/Users/miles/sliderule/data_wrangling/Trees/WGS84", "Trees")

# Reproject sidewalks to align with trees
sidewalks <- spTransform(sidewalks, CRS(proj4string(trees)))

# Buffer sidewalks by 20 feet
sidewalk_buffers <- gBuffer(sidewalks, width=20, byid=TRUE)

# Identify which sidewalk each tree adjoins
trees$sidewalk_objectid <- over(trees, sidewalk_buffers)$sidewalk_objectid
## BUG: each tree is attributed to one sidewalk at most,
##      despite that some sidewalk buffers may overlap

# Count trees near each sidewalk
sidewalk_tree_counts <- data.frame(trees) %>%
  group_by(sidewalk_objectid) %>%
  summarise(tree_count = n())

# Add tree count as column in sidewalks data frame
sidewalk_ids <- data.frame(sidewalk_objectid = sidewalks$sidewalk_objectid)
sidewalks$tree_count <- left_join(sidewalk_ids, sidewalk_tree_counts)$tree_count

# Change NAs to 0
na.zero <- function(x) {ifelse(is.na(x), 0, x)}
sidewalks$tree_count <- as.numeric(lapply(sidewalks$tree_count, na.zero))

# Find lengths of sidewalks
sidewalks$length <- SpatialLinesLengths(sidewalks)

# Normalize tree count by length
sidewalks$trees_per_ft <- sidewalks$tree_count / sidewalks$length

