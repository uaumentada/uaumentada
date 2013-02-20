class CampusController < ApplicationController
     helper_method :sort_column, :sort_direction
     
  # GET /campus
  # GET /campus.xml
  # params:
  # university_id : id or email of the university we want the campuses
  def index
    if !params[:university_id].nil? #search by id
      if  is_number?(params[:university_id])
        @university = University.find(params[:university_id])
      elsif   !params[:university_id].nil? #university_id is not a number, rather an email like uc.cl
        @university = University.find(:first, :conditions => {:email => params[:university_id]})
      end
      @campus = Campus.find(:all, :conditions => {:university_id => @university.id}, :order => "LOWER("+sort_column+ ") " + sort_direction)
      if @university.nil? #search by email
        @university = University.find(:first, :conditions => {:email => params[:university_id]}, :order => "LOWER("+sort_column+ ") " + sort_direction)
        if !@university.nil? #university exists, proceed to show campuses
          @campus = Campus.find(:all, :conditions => {:university_id => @university.id}, :order => "LOWER("+sort_column+ ") " + sort_direction)
        else
          @campus = []
        end
      end
    
    elsif params[:university_id].nil? && session[:super_admin] #show all, super admin does not have a university assigned
      @campus = Campus.order("LOWER("+sort_column+ ") " + sort_direction).all
    else #show none
      @campus = []
    end
    
    @campus = Kaminari.paginate_array(@campus).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campus }
      format.json 
    end
  end

  #Checks if object is a number
  def is_number?(object)
    true if Float(object) rescue false
  end

  # GET /campus/1
  # GET /campus/1.xml
  def show
    @campu = Campus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campu }
    end
  end

  # GET /campus/new
  # GET /campus/new.xml
  # Params
  # university_id : university this new campus belongs to
  def new
    @campu = Campus.new
    @university = University.find(params[:university_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campu }
    end
  end

  # GET /campus/1/edit
  def edit
    @campu = Campus.find(params[:id])
  end

  # POST /campus
  # POST /campus.xml
  def create
    @campu = Campus.new(params[:campus])

    respond_to do |format|
      if @campu.save
        format.html { redirect_to :action => 'show', :id => @campu.id, :notice => 'Campus fue creado satisfactoriamente.' }
        format.xml  { render :xml => @campu, :status => :created, :location => @campu }
      else
        format.html { render :action => "new", :university_id => @university.id }
        format.xml  { render :xml => @campu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campus/1
  # PUT /campus/1.xml
  def update
    @campu = Campus.find(params[:id])

    respond_to do |format|
      if @campu.update_attributes(params[:campus])
        format.html { redirect_to :action => 'show', :id => @campu.id, :notice => 'El campus fue actualizado satisfactoriamente.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campus/1
  # DELETE /campus/1.xml
  def destroy
    @campu = Campus.find(params[:id])
    @campu.destroy

    respond_to do |format|
      format.html { redirect_to(campus_url) }
      format.xml  { head :ok }
    end
  end
  
    def sort_column
    Campus.column_names.include?(params[:sort]) ? params[:sort] : "Name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
end
