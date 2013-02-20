class MenusController < ApplicationController
     helper_method :sort_column, :sort_direction
       include MenusHelper
  # GET /menus
  # GET /menus.xml
  #
  # Params:
  # poi_id : diner_id
  def index
    
    @menu = nil
    @poi_id = nil
    @poi = nil
    if !params[:poi_id].nil?
      @poi_id = params[:poi_id]
      @poi = Poi.find(:first, :conditions => {:id => @poi_id})
      
      if !@poi.nil? && @poi.user_id == session[:user]      
        @menus = Menu.order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :conditions => {:poi_id => params[:poi_id]})
        respond_to do |format|
          format.html # index.html.erb
        end
     elsif !@poi.nil?
        @menus = Menu.order("LOWER("+sort_column+ ") " + sort_direction).find(:all, :conditions => {:poi_id => params[:poi_id]})
        respond_to do |format|
          format.json # index.json.erb        
        end
      else
        @menus = []
        respond_to do |format|
          format.html # index.html.erb
          format.json # index.json.erb
          format.xml  { render :xml => @menus }
        end  
      end
      
    else
      @menus = []
      respond_to do |format|
        format.html # index.html.erb
        format.json # index.json.erb
        format.xml  { render :xml => @menus }
      end
    end
  end

  # GET /mobile_menus
  # GET /mobile_menus.xml
  #
  # Params:
  # poi_id : diner_id
  def mobile_menus
    
    poi_id = nil
    poi = nil
    if !params[:poi_id].nil?
      poi_id = params[:poi_id]
      poi = Poi.find(:first, :conditions => {:id => poi_id})
      
      if !poi.nil?
        @menus = get_menus(DateTime.now.cwday())
      else #if poi doesn't exists
        @menus = []
      end
      
    else #if no poi_id is provided
      @menus = []
    end
    
      respond_to do |format|
        format.json 
      end
    
  end

  # GET /menus/1
  # GET /menus/1.xml
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.xml
  # Params
  # poi_id : id of the diner
  def new
    @menu = Menu.new
    @menu.init_date = DateTime.now
    @menu.date = DateTime.now + 1.hours
    
    @poi = Poi.find(:first, :conditions => {:id => params[:poi_id]})
    @poi_id = params[:poi_id]

    if !@poi.nil? && @poi.user_id == session[:user]      
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @menu }
      end
    else
      render "no_permission"
    end
     
  end

  def no_permission
    
  end
  
  
  # GET /menus/1/edit
  # params:
  # poi_id : diner the menu belongs to
  def edit
    logger.info " Menu edit"
    @menu = Menu.find(params[:id])
    @poi_id = params[:poi_id]
    @poi = Poi.find(:first, :conditions => {:id => @poi_id})
  end



  # POST /menus
  # POST /menus.xml
  def create
    allow_dot(params[:menu][:price])
    @menu = Menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to(@menu, :notice => 'Menu creado satisfactoriamente.') }
        format.xml  { render :xml => @menu, :status => :created, :location => @menu }
      else
         @menu.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "new", :poi_id => @menu.poi_id }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    
    allow_dot(params[:menu][:price])
    @menu = Menu.find(params[:id])
    if params[:delete_image]
      @menu.image = nil
      @menu.save
    end
    respond_to do |format|
      if @menu.update_attributes(params[:menu])
         
        format.html { redirect_to(@menu, :notice => 'Menu actualizado satisfactoriamente.') }
        format.xml  { head :ok }
      else
         
        @menu.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "edit", :poi_id => @menu.poi_id}
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @menu = Menu.find(params[:id])
    @poi_id = @menu.poi_id
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "index", :poi_id => @poi_id) }
      format.xml  { head :ok }
    end
  end
  
  private
  def sort_column
    Menu.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
  def allow_dot(number_string)
    number_string.sub!(".", "")
  end
  
end
