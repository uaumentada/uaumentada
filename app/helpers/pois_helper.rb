module PoisHelper

#Returns the last update date between: Building Pois, Building, IndoorMaps and Vertices (polygons)
def get_last_update_date
  poi_type = PoiType.find(:first, :conditions => {:name => "Edificios"})
  indoor = IndoorMap.find(:first, :order => "updated_at DESC")
  if !indoor.nil?
    last = Array.new(4)
  else 
    last = Array.new(3)
  end  
  
  last[0] = Poi.find(:first, :conditions => {:poi_type_id => poi_type.id}, :order => "updated_at DESC").updated_at
  last[1] = Building.find(:first, :order => "updated_at DESC").updated_at
  last[2] = Vertex.find(:first, :order => "updated_at DESC").updated_at
   if !indoor.nil?
    last[3] = indoor.updated_at
  end
  
  
  update = last[0]
  last.each do |l|
    if update.to_datetime < l.to_datetime
       update = l
    end
  end
  logger.info "Last polygon.xml update: #{update.to_date}"
  update.to_date
  
end

end
