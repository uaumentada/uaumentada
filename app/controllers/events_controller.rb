class EventsController < ApplicationController
   helper_method :sort_column, :sort_direction
       include ApplicationHelper
  # GET /events
  # GET /events.xml
  # GET /events.json
  # Parameters:
  # *univ = university where it belongs
  # *campus = campus to filter
  # *lat = the latitude of where to start searching
  # *lng = the longitude of where to start searching
  # *radius = distance from the center (lat & lng) to search for events
  # *category = category of the event
  def index

    category = nil
    if !params[:category].nil?
      category = Category.where("name = ?", params[:category]).first
    end
    
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    
    campus = get_campus_id(params[:campus])

    @events = []
    if(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil? && !category.nil? && !univ.nil? && campus.nil?) #filtrado por categoria
      #Event.geocoded
      #puts params[:lat].to_f
      #lat=-33.425329&lng=-70.604895&radius=20.0'
     @events = Event.joins(:campus).near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km }).where("end_date > ? AND category_id = ? AND campus.university_id = ?", Date.today, category.id, univ.id)
     @events.include_root_in_json = false
    elsif(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil? && !category.nil? && !campus.nil?) #filtrado por categoria y campus
     @events = Event.joins(:campus).near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km }).where("end_date > ? AND category_id = ? AND campus_id = ?", Date.today, category.id, campus.id)
     @events.include_root_in_json = false    
    elsif(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil?)
     @events = Event.near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km }).where("end_date > ?", Date.today)
     @events.include_root_in_json = false
    elsif !campus.nil? && !category.nil?
     @events = Event.joins(:campus).where("end_date > ? AND category_id = ? AND campus_id = ?", Date.today, category.id, campus.id)
     @events.include_root_in_json = false
    elsif !univ.nil? && !category.nil?
     @events = Event.joins(:campus).where("end_date > ? AND category_id = ? AND campus.university_id = ?", Date.today, category.id, univ.id)
     @events.include_root_in_json = false
    elsif !category.nil?
     @events = Event.where("end_date > ? AND category_id = ?", Date.today, category.id)
    else
      @events = Event.where("end_date > ?", Date.today)
    end

    @events = Kaminari.paginate_array(@events).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json #index.json.erb
    end
  end

  #Muestra los eventos particulares del usuario registrado
  def user_events
    events = []
    if sort_column == "campus_id"
      events = Event.search(params[:searchbox]).find(:all, :joins => :campus, :order => "LOWER("+'campus.name'+ ") " + sort_direction, :conditions => {:user_id => session[:user]})
    else
      events = Event.search(params[:searchbox]).find(:all, :conditions => {:user_id => session[:user]}, :order => "LOWER("+sort_column+ ") " + sort_direction)
      
    end
    
    @events = Kaminari.paginate_array(events).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    
    respond_to do |format|
         format.html { render :action => "index" }
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    if has_permission(@event.user)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
        else #no tiene permiso
      render "no_permission"
    end
    
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.init_date = DateTime.now
    @event.end_date = DateTime.now + 1.hours


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
      @event = Event.find(params[:id])
    if has_permission(@event.user)
      render
    else #no tiene permiso
      render "no_permission"
    end
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user_id = session[:user]
    @campus = Campus.new(params[:campus])
    loc = @campus.name.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @event.campus = campus;
    

    respond_to do |format|
      if @event.save
        format.html { redirect_to(:user_events, :notice => 'Evento creado exitosamente.') }
        #format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        @event.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "new" }
        #format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    
    if !params[:delete_image].nil?
      @event.image = nil
      @event.save
    end
    
    @campus = Campus.new(params[:campus])
    loc = @campus.name.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @event.campus_id = campus.id;
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Evento actualizado exitosamente.') }
        format.xml  { head :ok }
      else
        @event.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "edit" }
        #format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to :action => "user_events" }
      format.xml  { head :ok }
    end
  end
  
    private
  
  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
end
