library(dismo)
library(XML)
library(rgdal)
geocode("Seoul, South Korea")
points(geocode("Seoul, South Korea")[3:4])
plot(gmap(extent(unlist(geocode("Seoul, South Korea"))[5:8]),type="satellite"))

# http://bcb.dfci.harvard.edu/~aedin/courses/R/CDC/maps.html
library(ggmap)
geocode("Seoul")
geocode("Yonsei University")
geocode("Yonsei University",output = 'more')
geocode("Yonsei University",output = 'all')


violent_crimes <- subset(crime, offense != "auto theft" & offense != "theft" & offense != "burglary")
                           

# rank violent crimes
violent_crimes$offense <- factor(violent_crimes$offense, levels = c("robbery", 
                                                                    "aggravated assault", "rape", "murder"))

# restrict to downtown
violent_crimes <- subset(violent_crimes, -95.39681 <= lon & lon <= -95.34188 & 29.73631 <= lat & lat <= 29.784)
HoustonMap <- qmap('houston', zoom = 14,color = 'bw', legend = 'topleft')
HoustonMap +geom_point(aes(x = lon, y = lat, size = offense,colour = offense), data = violent_crimes )


############density layer


houston <- get_map('houston', zoom = 14) 
HoustonMap <- ggmap(houston, extent = 'device', legend = 'topleft')

HoustonMap + stat_density2d(aes(x = lon, y = lat, 
                                fill = ..level.. , alpha = ..level..),size = 2, bins = 4, 
                            data = violent_crimes, geom = 'polygon') +

 scale_fill_gradient('Violent\nCrime\nDensity') +
  scale_alpha(range = c(.4, .75), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10))

library(maptools)

# http://www.diva-gis.org/gdata 
# 에 들어가서 자료 다운로드
# 여기서는 South Korea 의 administrative areas
level1 = readShapeSpatial("D:\\data\\gis\\KOR_adm\\KOR_adm0.shp")
level2 = readShapeSpatial("D:\\data\\gis\\KOR_adm\\KOR_adm1.shp")
level3 = readShapeSpatial("D:\\data\\gis\\KOR_adm\\KOR_adm2.shp")
river = readShapeSpatial("D:\\data\\gis\\KOR_wat\\KOR_water_lines_dcw.shp")
road = readShapeSpatial("D:\\data\\gis\\KOR_rds\\KOR_roads.shp")
rail = readShapeSpatial("D:\\data\\gis\\KOR_rrd\\KOR_rails.shp")
plot(level1)
plot(level2, border = "gray")
# locator()
plot(level2,xlim = c(126,128),ylim = c(36,39))
plot(level3)
lines(river,col="blue")
lines(road, col="gray")
lines(rail, col = "brown")

spl = read.csv("vis_sample.csv")
spl_seoul = read.csv("vis_sample_seoul.csv")
# 저번에 썼던거
points(spl$longitude, spl$latitude, col= "#e2373f", cex = 0.5)



