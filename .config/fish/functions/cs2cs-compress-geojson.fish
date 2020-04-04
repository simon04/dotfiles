function cs2cs-compress-geojson
  ogr2ogr -f GeoJSON -lco RFC7946=YES -lco COORDINATE_PRECISION=4 $argv
end
