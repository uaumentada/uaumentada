class ProfessorsController < ApplicationController
  include ApplicationHelper
  # GET /professors
  # GET /professors.xml
  # params:
  # *status : t or f, to filter by status (in sqllite)
  #          1 or 0, to filter by status (in MYSQL)
  # *univ : email extension where the professors belong to
  # *campus : campus del profesor
  def index
  
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    
    campus = get_campus_id(params[:campus])

    if !params[:status].nil? && !campus.nil?
      @professors = Professor.joins(:user, :poi).find(:all, :conditions => ["status = ? AND poi.campus_id = ?", params[:status], campus.id])
  
    elsif !params[:status].nil? && !params[:univ].nil?
      @professors = Professor.joins(:user, :poi).find(:all, :conditions => ["status = ? AND users.university_id = ?", params[:status], univ.id])
    else
      @professors = Professor.joins(:poi).all
    end
     
    respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @professors }
      format.json #json.html.erb
    end
  end

  # GET /professors/1
  # GET /professors/1.xml
  def show
    @professor = Professor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @professor }
    end
  end

  # GET /professors/new
  # GET /professors/new.xml
  def new
    @professor = Professor.new
    @professor.user = User.find(session[:user])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @professor }
    end
  end

  # GET /professors/1/edit
  def edit
    @professor = Professor.find(params[:id])
  end

  # POST /professors
  # POST /professors.xml
  def create
    @professor = Professor.new(params[:professor])

    respond_to do |format|
      if @professor.save
        format.html { redirect_to(@professor, :notice => 'Professor was successfully created.') }
        format.xml  { render :xml => @professor, :status => :created, :location => @professor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @professor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /professors/1
  # PUT /professors/1.xml
  def update
    @professor = Professor.find(params[:id])

    respond_to do |format|
      if @professor.update_attributes(params[:professor])
        format.html { redirect_to(@professor, :notice => 'Professor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @professor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /professors/1
  # DELETE /professors/1.xml
  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy

    redirect_to :action => "petitions"
  end
  
  #/checkin
  def checkin

    professor = Professor.find(:first, :conditions => {:user_id => session[:user]})
    if !professor.nil?
       @status = professor.status
       @poi_exists = false;
       
       if professor.poi.nil?
          @poi_exists = false;
       else
          @poi_exists = true;
          @poi = Poi.find(professor.poi_id)
       end
    end
    
  end

  #Changes status from a professor 
  # /toggle
  def toggle
    
    professor = Professor.find(:first, :conditions => {:user_id => session[:user]})
    if !professor.nil?
        professor.status = !professor.status
        professor.save
    end

    redirect_to :action => "checkin"

  end

  #petition the privilege of professor
  def petition
   
    @prof = Professor.new
    user = User.find(session[:user])
    @prof.user_id = user.id
    if @prof.save
      redirect_to :controller => 'users', :action => 'show', :id => session[:user], :notice => 'se ha realizado la peticion'
    else
      redirect_to :controller => 'users', :action => 'show', :id => session[:user], :notice => 'no se ha realizado'
    end
  end

  #get list of all remaining petitions to grant professor privilege
  def petitions
    if session[:super_admin]
      @professors = Professor.find(:all, :joins => [:user => :university], :conditions => {:approved => false})
    else
      user = User.find(session[:user])
      @professors = Professor.find(:all, :joins => [:user => :university], :conditions => {:approved => false, :universities => {:email => user.university.email }})
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @professors }
    end
  end

  #selects all professors offices 
  def assign_poi

    @prof_id = params[:prof_id]
    poi_type = PoiType.find(:first, :conditions => {:name => "Oficinas de Profesores"})
    @pois = Poi.find(:all, :conditions => {:poi_type_id => poi_type.id})

  end

  #Assign's a poi and a user to a professor and updates the user's privilege.
  #params
  # poi_id
  # prof_id
  def assign
   poi = Poi.find(params[:poi_id])
   prof = Professor.find(params[:prof_id])
   prof.poi = poi
   prof.approved = true;
   prof.save
  
   privilege = Privilege.find(:first, :conditions => {:description => "professor"})
   prof.user.privileges << privilege 
   if prof.user.save
       redirect_to(:action => "petitions", :notice => 'Se asigna correctamente.') 
   else
      redirect_to(:action => "petitions", :notice => 'No se pudo asignar')
   end

  end

end
