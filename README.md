# path.works
Mapping Seattle for pedestrian delight.

## Introduction
When I moved back to Seattle in September 2015, I had a half-hour one-way walking commute between home and Downtown Seattle. (Although frequent bus service was available in the area, taking the bus was no faster than walking due to heavy traffic congestion and needing to walk to/from the bus stop.) However, I found it challenging to identify the best walking route.

**TODO** (insert map showing point A, point B, and routes suggested by Google Maps)

All of the "shortest" routes suggested by Google Maps were in some way unpleasant: each involved some combination of steep hills, freeway underpasses, and walking alongside noisy streets. I eventually discovered a genuinely pleasant walking route through a process of trial and error over the course of a few weeks. It was only a few minutes longer than the shortest route, but it was a much more delightful walk. After discovering this more pleasant route, I favored it over shorter routes and used it on a daily basis despite that it was longer.

**TODO** (insert map showing delightful route between point A and point B)

**TODO** (insert photographs contrasting unpleasant freeway underpass with reasonably pleasant freeway overpass)

The goal of this project is to provide an algorithm to score pedestrian routes according to "pedestrian delight." The output of this scoring algorithm could be used to recommend optimally safe and pleasant routes for pedestrians to travel between two points within Seattle.

## Target Audience

*Urban residents* care about this problem because they need to make decisions between walking and other modes of transportation such as driving, using transit, or taking Uber. If urban travelers have better access to information about enjoyable walking routes, they may choose to walk more frequently instead of driving or riding in a vehicle.

*Local governments* generally favor initiatives that improve public health and reduce traffic congestion. If travelers switch from driving to walking because they have better information about safe and enjoyable walking routes, they will experience the health benefits of daily exercise and fewer cars will be on the road.

*Online map services* such as Google Maps generally indicate that walking directions are still "experimental" or "in beta." These services are still in development and need fundamental improvements before they can be offered to the public without reservation. An ideal outcome of this project would be for Google Maps and/or other map services to incorporate "delight scoring" into their pedestrian routing algorithms.

## Data Sources

* Sidewalk data (City of Seattle)
* Street trees (City of Seattle)
* Zoning (City of Seattle)
* OpenStreetMap (including street sizes/types) for Seattle
* Crime/911 data (City of Seattle)
* Census data for block groups in Seattle
* TIGER shapefiles for Census block groups

## Project Deliverables

* Source code (in this repository) documenting a reproducible process for obtaining and organizing the necessary geospatial data.

* A map of Seattle classifying streets according to the algorithm.
