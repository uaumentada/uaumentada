xml.instruct!
xml.constructions do
  xml.lastUpdate @update.strftime("%Y%m%d%H%M%S")
  @pois.each do |poi|
    xml.construction("name" => poi.name) do
      xml.info poi.description
      xml.centerCoordinates poi.lat.to_s + "," + poi.lng.to_s
      xml.polygonCoordinates("count" => poi.building.vertices.count)
      poi.building.vertices.each do |vertex|
      	xml.coordinate vertex.lat.to_s + "," + vertex.lng.to_s
      end
      xml.floors("total" => poi.building.floors, "images" => poi.building.indoor_maps.count) do
      	poi.building.indoor_maps.each do |indoor|
      		xml.floor(indoor.image.url, "level" => indoor.floor )
      	end
      end
    end
  end
end
