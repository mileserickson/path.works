# Run count_trees.R first #

# Load 911 calls
calls_raw <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")

# Summarize by location
calls_grouped <- calls_raw %>%
  filter(!is.na(Longitude)) %>%
  filter(!is.na(Latitude)) %>%
  group_by(Longitude, Latitude, Event.Clearance.Group) %>%
  summarise(call_count = n())

# Identify potentially hazardous call groups
is_hazardous_call <- function(x) {
  x %in% c("ASSAULTS", "DRIVE BY (NO INJURY)", "HAZARDS", "HOMICIDE", "LEWD CONDUCT", "MENTAL HEALTH",
                  "NARCOTICS COMPLAINTS", "PERSON DOWN/INJURY", "LIQUOR VIOLATION", "PROWLER", "RECKLESS BURNING",
                  "ROBBERY", "TRESPASS", "VICE CALLS", "WEAPONS CALLS")
}
calls_grouped$is_hazardous <- lapply(calls_grouped$Event.Clearance.Group, is_hazardous_call)

# Count total calls and hazardous calls for each location
calls_total <- calls_grouped %>%
  group_by(Longitude, Latitude) %>%
  summarise(total_calls = sum(call_count), hazardous_calls = sum(call_count * as.numeric(is_hazardous)))

# Calculate percentage of potentially hazardous calls
calls_total$hazard_ratio <- calls_total$hazardous_calls / calls_total$total_calls

# Convert calls_total to a SpatialPointDataFrame
calls_total <- data.frame(calls_total)
coordinates(calls_total) <- ~Longitude+Latitude
proj4string(calls_total) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# Project calls_total to align with sidewalks
calls_total <- spTransform(calls_total, CRS(proj4string(sidewalks)))

# Output Shapefiles
writeOGR(calls_total, dsn="/Users/miles/Documents/pathworks", layer="calls_total", driver="ESRI Shapefile")
writeOGR(sidewalks, dsn="/Users/miles/Documents/pathworks", layer="sidewalks", driver="ESRI Shapefile")
writeOGR(trees, dsn="/Users/miles/Documents/pathworks", layer="trees", drive="ESRI Shapefile")

# Buffer sidewalks by 50 feet
#sidewalk_buffers_50 <- gBuffer(sidewalks, width=50, byid=TRUE)

# Find calls within each buffer zone
#for(i in 1:50) {
#  sidewalk_calls <- over(calls_total, sidewalk_buffers_50[i, ])
#}

# Cleanup
rm(calls_raw)
rm(is_hazardous_call)
