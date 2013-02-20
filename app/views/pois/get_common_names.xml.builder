xml.instruct!
xml.pois do
  @pois.each do |poi|
    xml.poi do
      xml.name poi.name
    end
  end
end
