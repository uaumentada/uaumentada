# encoding: utf-8
class PoisController < ApplicationController
    include PoisHelper
    include ApplicationHelper
     helper_method :sort_column, :sort_direction
     
  # GET /pois
  # GET /pois.xml
  def index
    
    @pois = []
    if sort_column == "poi_type_id" 
      @pois = Poi.search(params[:searchbox]).find(:all, :joins => :poi_type, :order => "LOWER("+'poi_types.name'+ ") " + sort_direction)
    else
      @pois = Poi.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction )
    end
    
    @pois = Kaminari.paginate_array(@pois).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pois }
    end
  end

  # GET /pois/1
  # GET /pois/1.xml
  def show
    @poi = Poi.find(params[:id])
    if has_permission(@poi.user) || (session[:admin] && same_university(@poi.campus.university))
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @poi }
      end
    else
      render "no_permission"
    end
  end

  # GET /pois/new
  # GET /pois/new.xml
  def new
    @poi = Poi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poi }
    end
  end

  # GET /pois/1/edit
  def edit
    @poi = Poi.find(params[:id])
    if has_permission(@poi.user)
      render
    else
      render "no_permission"
    end
  end

  # POST /pois
  # POST /pois.xml
  def create
    @poi = Poi.new(params[:poi])
    
    @poi_type = nil
    if params[:poi_type][:name] != ""
      @poi_type = PoiType.find(:first, :conditions => {:name => params[:poi_type][:name]})
      @poi.poi_type = @poi_type
   end
    
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @poi.campus_id = campus.id
    
    #Set user that created the poi
    user = User.find(session[:user])
    @poi.user = user

    respond_to do |format|
      if @poi.save
        
        #Create a building if poi created was a building
        if !@poi_type.nil? && @poi_type.name == 'Edificios'
          @building = Building.new
          @building.poi = @poi
          @building.floors = params[:building_floors]
          @building.save
        end
        
        @pois = Poi.all
        @pois = Kaminari.paginate_array(@pois).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
        format.html { render :action => "show", :notice => 'El punto fue creado satisfactoriamente' }
        format.xml  { render :xml => @poi, :status => :created, :location => @poi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pois/1
  # PUT /pois/1.xml
  def update
    @poi = Poi.find(params[:id])
    if params[:delete_icon]
      @poi.icon = nil
      @poi.save
    end
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @poi.campus = campus
    
    respond_to do |format|
      if @poi.update_attributes(params[:poi])
        format.html { redirect_to(@poi, :notice => 'Actualizado correctamente') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pois/1
  # DELETE /pois/1.xml
  def destroy
    @poi = Poi.find(params[:id])
    @poi.destroy

    respond_to do |format|
      format.html { redirect_to(pois_url) }
      format.xml  { head :ok }
    end
  end
  
  def destroy_poi
     @poi = Poi.find(params[:id])
     if !@poi.nil?
     @poi.destroy
     end

    respond_to do |format|
      if params[:from] == "my_diners"
        format.html{ redirect_to '/my_diners_clean'}
      elsif params[:from] == "my_buildings"
        format.html{ redirect_to '/my_buildings'}
      elsif params[:from] == "all_buildings"
        format.html{ redirect_to '/all_buildings'}
      else
        format.html { redirect_to(:action => "index") }
        format.xml  { head :ok }
      end
    end
  end
  
  #MOBILE
  #Returns the list of one type pf pois indicated by the param
  # Parameters:
  # *type = name of the pois to filter
  # *univ = email of the university of the pois
  def get_pois
    
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    
    campus = get_campus_id(params[:campus])
    
    @type = PoiType.find(:first, :conditions => { :name => params[:type] })
    @pois = nil
    if @type != nil && !univ.nil? && !campus.nil?
      @pois = Poi.joins(:campus).find(:all, :conditions => [ "poi_type_id = ? AND campus_id = ? AND campus.university_id = ?", @type.id, campus.id, univ.id])
    elsif @type != nil && !univ.nil?
      @pois = Poi.joins(:campus).find(:all, :conditions => [ "poi_type_id = ? AND campus.university_id = ?", @type.id, univ.id])    
        
    else
      @pois = []
    end

    respond_to do |format|
       format.html { render :action => "index" }
       format.xml  { render :xml => @pois }
       ActiveRecord::Base.include_root_in_json = false
       format.json #get_pois.json.erb
    end
  end

  def get_common_names
     
     @pois = PoiType.find(:all, :order => 'name asc')
     respond_to do |format|
      format.json  { render :action => "get_common_names"}
    end
  
  end
  
  def my_diners_clean
    
    poi_type = PoiType.find(:first, :conditions => ["name like ?", "Casinos y Cafeterías"])
    @pois = Poi.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :conditions => {:poi_type_id => poi_type.id, :user_id => session[:user]})
   
   @pois = Kaminari.paginate_array(@pois).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
   
    respond_to do |format|
      format.html 
    end
  end
  
  #Create a poi forcing type Diner
  def new_diner

    @poi_type = PoiType.find(:first, :conditions => ["name like ?", "Casinos y Cafeterías"])
    @poi = Poi.new
    
    respond_to do |format|
      format.html
    end
    
  end
  
  #Create the diner point, redirects the user to specific url different from pois
  def create_diner
      
    @poi = Poi.new(params[:poi])
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @poi.campus_id = campus.id
    
    #Set user that created the poi
    user = User.find(session[:user])
    @poi.user = user

    respond_to do |format|
      if @poi.save
        
        poi_type = PoiType.find(:first, :conditions => ["name like ?", "Casinos y Cafeterías"])
        @pois = Poi.find(:all, :conditions => {:poi_type_id => poi_type.id, :user_id => session[:user]})
    
        format.html { redirect_to :action => "my_diners_clean", :notice => 'El punto fue creado satisfactoriamente' }
        format.xml  { render :xml => @poi, :status => :created, :location => @poi }
      else
        format.html { render :action => "new_diner" }
        format.xml  { render :xml => @poi.errors, :status => :unprocessable_entity }
      end
    end
    end
  
  #id diner to edit
  def edit_diner
    @poi = Poi.find(:first, :joins => :campus, :conditions => {:id => params[:id]})
    @poi_type = @poi.poi_type
    if has_permission(@poi.user)
      render
    else
      render "no_permission"
    end
  end
  
  #Returns the list of all diners
  # *univ = email of university
  # *campus = campus selection
  def get_diners
    
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    

   campus = get_campus_id(params[:campus])
  
    poi_type = PoiType.find(:first, :conditions => ["name like ?", "Casinos y Cafeterías"])
    
    if !campus.nil? && !params[:univ].nil?
      @diners = Poi.joins(:campus).find(:all, :conditions => ["poi_type_id = ? AND campus.university_id = ? AND campus_id = ?", poi_type.id, univ.id, campus.id ])
    elsif !campus.nil?
      @diners = Poi.joins(:campus).find(:all, :conditions => ["poi_type_id = ? AND campus_id = ?", poi_type.id, campus.id ])
    elsif !params[:univ].nil?
      @diners = Poi.joins(:campus).find(:all, :conditions => ["poi_type_id = ? AND campus.university_id = ?", poi_type.id, univ.id ])
    else
      @diners = Poi.find(:all, :conditions => ["poi_type_id = ? ", poi_type.id])
    end
   
   respond_to do |format|
      format.json #get_diners.json.erb
   end
   
  end
  
  #Params:
  # id : poi to show
  def get_poi
    poi = Poi.find(params[:id])
   
   respond_to do |format|
    format.json #poi.json.erb
    end
   
  end
  
  #BUILDINGS
  #Show buildings created by the user logged in
  def my_buildings
    
    poi_type = PoiType.find(:first, :conditions => ["name like ?", "Edificios"])
    
    @pois = Poi.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :conditions => {:poi_type_id => poi_type.id, :user_id => session[:user]})
    
    @pois = Kaminari.paginate_array(@pois).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    
    @my_buildings = true
    
    respond_to do |format|
      format.html 
    end
  end
   #Show buildings created by the user logged in
  def all_buildings
    
    poi_type = PoiType.find(:first, :conditions => ["name like ?", "Edificios"])
    if !session[:super_admin].nil? #show all pois created
      @pois = Poi.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :conditions => {:poi_type_id => poi_type.id})
    else #show all pois from the same university
      university = User.find(session[:user]).university.id
      @pois = Poi.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :include => {:campus => :university}, :conditions => ["poi_type_id = ? and campus.university_id = ?", poi_type.id, university ])
    end
    @pois = Kaminari.paginate_array(@pois).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    
    @my_buildings = false
    
    render "all_buildings"
  end
  
  #Create a poi forcing type Building
  def new_building

    @poi_type = PoiType.find(:first, :conditions => ["name like ?", "Edificios"])
    @poi = Poi.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
    
  end
  
  def edit_building
    @poi = Poi.find(:first, :joins => :campus, :conditions => {:id => params[:id]})
    @poi_type = @poi.poi_type
    if has_permission(@poi.user)
      render
    else
      render "no_permission"
    end
  end
  
  #Create the building point, redirects the user to specific url different from pois
  def create_building
      
    @poi = Poi.new(params[:poi])
    @building = Building.new
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @poi.campus = campus
    
    #Set user that created the poi
    user = User.find(session[:user])
    @poi.user = user


    respond_to do |format|
      if @poi.save
        @building.poi = @poi
        @building.floors = params[:building_floors]
        @building.save
        
        poi_type = PoiType.find(:first, :conditions => ["name like ?", "Edificios"])
        @pois = Poi.find(:all, :conditions => {:poi_type_id => poi_type.id, :user_id => session[:user]})
    
        format.html { redirect_to(@poi, :notice => 'Edificio fue creado exitosamente.') }
        format.xml  { render :xml => @poi, :status => :created, :location => @poi }
      else
        format.html { render :action => "new_building" }
        format.xml  { render :xml => @poi.errors, :status => :unprocessable_entity }
      end
    end
    end
  
  def update_building
    @poi = Poi.find(params[:id])
    if params[:delete_icon]
      @poi.icon = nil
      @poi.save
    end
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @poi.campus = campus
    
    respond_to do |format|
      if @poi.update_attributes(params[:poi])
        @building = @poi.building
        @building.floors = params[:building_floors]
        @building.save
        format.html { redirect_to(@poi, :notice => 'Edificio fue actualizado exitosamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poi.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #Returns the list of all buildings
  def get_buildings
    poi_type = PoiType.find(:first, :conditions => ["name like ?", "Edificios"])
    @buildings = Poi.find(:all, :conditions => {:poi_type_id => poi_type.id})
   
   respond_to do |format|
      format.json #get_buildings.json.erb
   end
   
  end

  #MOBILE API
  #GET ALL POLYGONS
  #only renders xml
  def get_polygons
    
    poi_type = PoiType.find(:first, :conditions => {:name => "Edificios"})
    @pois = Poi.find(:all, :conditions => {:poi_type_id => poi_type.id})
    #@update = Poi.find(:first, :conditions => {:poi_type_id => poi_type.id}, :order => "updated_at DESC")
    @update = get_last_update_date
    
    respond_to do |format|
      format.xml {render :action => "get_polygons"}
    end
    
  end
  
  #Renders the last update
  # params
  # date : date to compare with
  def new_update_available
    logger.info "Last user update: #{params[:date].to_date}"
    update = get_last_update_date
    
    
    
    if params[:date].to_date <= update  #new update available  
      render :xml => {:result => true}.to_xml
    else
      render :xml => {:result => false}.to_xml
    end
  end
  
  
  private

  def sort_column
    Poi.column_names.include?(params[:sort]) ? params[:sort] : "pois.name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end

end
