class IndoorMapsController < ApplicationController


def indoor_map
   @indoor_map = IndoorMap.new
end 

def index
  
  @indoor_maps = IndoorMap.find(:all)
  
end

#params
#poi_id
def new

   @poi = Poi.find(:first, :conditions => {:id => params[:poi_id]})
   @building = Building.find(:first, :conditions => {:poi_id => @poi.id})
   @indoor_maps = IndoorMap.find(:all, :conditions => {:building_id => @building.id})
   @indoor_map = IndoorMap.new
  
end


def create
  
  
  
  @indoor_map = IndoorMap.new(params[:indoor_map])
  im = IndoorMap.find(:first, :conditions => {:building_id => @indoor_map.building.id, :floor => @indoor_map.floor})
  if !im.nil?
    im.update_attributes(params[:indoor_map])
    respond_to do |format|
      if im.save
        @poi_id = im.building.poi.id
        format.html { redirect_to(:controller => "indoor_maps", :action => "new", :poi_id => im.building.poi.id) }
        
      else
        format.html { redirect_to(:controller => "indoor_maps", :action => "new", :poi_id => im.building.poi.id, :notice => 'No se pudo crear el mapa interior') }
      end
     end
  else
  
  respond_to do |format|
      if @indoor_map.save
        @poi_id = @indoor_map.building.poi.id
        format.html { redirect_to(:controller => "indoor_maps", :action => "new", :poi_id => @indoor_map.building.poi.id) }
        
      else
        format.html { redirect_to(:controller => "indoor_maps", :action => "new", :poi_id => @indoor_map.building.poi.id, :notice => 'No se pudo crear el mapa interior') }
      end
    end
  end
  
end

#params
# id : id of the map
def delete_map

 map = IndoorMap.find(:first, :conditions => {:id => params[:id]})
 building = map.building
 
 if building.poi.user.id == session[:user]
    map.destroy
  end
 
 redirect_to(:controller => "indoor_maps", :action => "new", :poi_id => building.poi.id) 
 

end

end
