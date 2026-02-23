library(terra)

suitability_raw <- rast("C:/MGEM/FCOR599/geodatabase/second_version/suitabilitySurfaces_v2/suitability_raw.tif")
suitability_final <- rast("C:/MGEM/FCOR599/geodatabase/second_version/suitabilitySurfaces_v2/FinalSuitability.tif")
mask <- rast("C:/MGEM/FCOR599/geodatabase/project_working.gdb/final_mask.tif")

#aggregate and reproject for web viewing 

#raw suitability 
suit_raw_agg <- aggregate(suitability_raw, fact=33, fun=mean) # 30m × 33 ~ 1km
suit_raw_web <- project(suit_raw_agg, "EPSG:4326")
writeRaster(suit_raw_web, "C:/Users/kenzthom.stu/OneDrive - UBC/GIT/E-Portfolio/myData/suitability_raw_web.tif", overwrite=TRUE)

#classified suitability 
suit_final_agg <- aggregate(suitability_final, fact=33, fun="modal", na.rm = TRUE) #modal to preserve class
suit_final_web <- project(suit_final_agg, "EPSG:4326", method = "near") #near to preserve class
suit_final_web[is.nan(suit_final_web)] <- NA
writeRaster(suit_final_web, "C:/Users/kenzthom.stu/OneDrive - UBC/GIT/E-Portfolio/myData/suitability_final_web.tif", overwrite=TRUE)

#mask
mask_agg <- aggregate(mask, fact = 33, fun = max)
mask_web <- project(mask_agg, "EPSG:4326")
writeRaster(mask_web, "C:/Users/kenzthom.stu/OneDrive - UBC/GIT/E-Portfolio/myData/mask_web.tif", overwrite = TRUE)



