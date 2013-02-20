class VertexController < ApplicationController
  
  #params
  # building_id || poi_id : id of the building or the poi
  # notice : message passed on when render from another action, could be null
  def new_building
    
    @notice = params[:notice]
    @building = nil    
    if !params[:building_id].nil?
      @building = Building.find(:first, :conditions => {:id => params[:building_id]})
    else #params[:poi_id]
      @building = Building.find(:first, :conditions => {:poi_id => params[:poi_id]})
    end

    
  end
  
  def create_polygon
     
     if params[:lat].nil? || params[:lng].nil?
       redirect_to :controller => "vertex", :action => "new_building", :building_id => params[:building_id], :notice => "Debes seleccionar puntos en el mapa"
     else
     
     
     #Delete any previously created polygon for this building
     vertices = Vertex.find(:all, :conditions => {:building_id => params[:building_id]})
     if !vertices.nil?
      vertices.each  do |v|
        v.destroy
      end
     end
     
     
    lats = params[:lat]
    lngs = params[:lng]
    total = (lats.size - 1) 
    ok = true 
    for i in 0..total
      vertex = Vertex.new
      
      vertex.lat = lats[i.to_s]
      vertex.lng = lngs[i.to_s]
      vertex.building_id = params[:building_id]
      if !vertex.save
        ok = false
      end
      
    end
  
    if !ok
      vertices = Vertex.find(:all, :conditions => {:building_id => params[:building_id]})
      vertices.each  do |v|
        v.destroy
      end
      redirect_to :controller => "vertex", :action => "new_building", :building_id => params[:building_id]
    else
       redirect_to :controller => "vertex", :action => "show", :building_id => params[:building_id]  
    end 
    
    end
      
  end
  
  #Shows the poligon corresponding to the vertex
  #params
  # building_id || poi_id
  def show
    
    @building = nil    
    if !params[:building_id].nil?
      @building = Building.find(:first, :conditions => {:id => params[:building_id]})
    else #params[:poi_id]
      @building = Building.find(:first, :conditions => {:poi_id => params[:poi_id]})
    end
    
    @vertex = Vertex.find(:all, :conditions => {:building_id => @building.id})
    @poi = @building.poi
      
    render 'show_polygon'
    
  end
  
  
end
