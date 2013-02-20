class SurveysController < ApplicationController
     helper_method :sort_column, :sort_direction
         include ApplicationHelper
  # GET /surveys
  # GET /surveys.xml
  def index
   # @surveys = Survey.all
  @surveys = Survey.search(params[:searchbox]).find(:all, :conditions => {:user_id => session[:user]})

  @surveys = Kaminari.paginate_array(@surveys).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end
  
 
#Entrega el listado de encuestas del usuario registrado
def user_surveys
   @surveys = Survey.search(params[:searchbox]).find(:all, :conditions => {:user_id => session[:user]}, :order => "LOWER("+sort_column+ ") " + sort_direction)
   @answers = Answer.find(:all)
   
   @surveys = Kaminari.paginate_array(@surveys).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
   
    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @surveys }
    end
end

#Returns an xml file containing the surveys for a course
#
# Parameters:
# *initials : Curso del cual se desean buscar las encuestas
def get_course_surveys
  @course = Course.find(:first, :conditions => { :initials => params['initials']})
  @survey = []
  if @course
    @surveys = Survey.find(:all, :conditions => {:course_id => @course.id})
  end
  
  respond_to do |format|
      format.html { render :action => "get_public_surveys" }
      format.xml  { render :action => "get_public_surveys"}
  end
  
end

#univ : email extension to filter public surveys (e.g. uc.cl)
def get_public_surveys

    u = University.find(:first, :conditions => {:email => params[:univ]})

    @surveys = Survey.find(:all, :conditions => {:university_id => u.id, :privacy_level => 3}) #privacy_level 3 == publica

    respond_to do |format|
    # format.html { render :action => "index" }
    	 format.xml  #get_public_surveys.xml.builder #{ render :xml => @surveys }
    end
end

def get_geolocalized
  
  @surveys = []
  if(params[:lat] != nil && params[:lng] != nil && params[:radius] != nil)
      #Survey.geocoded
      #puts params[:lat].to_f
      #lat=-33.425329&lng=-70.604895&radius=20.0
     @surveys = Survey.near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km }).where("privacy_level = ?", '4')
     #@surveys.include_root_in_json = false
    else
      @surveys = Survey.find(:all, :conditions => {:privacy_level => 4}) #privacy_level 4 == geolocalizada
    end
  

  respond_to do |format|
     format.xml  #get_geolocalized.xml.builder #{ render :xml => @surveys }
  end
  
end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])
    if has_permission(@survey.user)
     respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @survey }
      end
    else
      render "no_permission"
    end
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new
    @courses = Course.find(:all, :conditions => {:user_id => session[:user] })

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end


  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
    @courses = Course.find(:all, :conditions => {:user_id => session[:user] })	

  if has_permission(@survey.user)
    render
  else
    render "no_permission"
  end

  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])
    u = User.find(session[:user])
    @survey.user_id = u.id
    @survey.university = u.university
#    @survey.save

#In case create fails
@courses = Course.find(:all, :conditions => {:user_id => session[:user] })

if @survey.privacy_level== Survey.privacy['Curso']
    if(!params[:initials].nil?) #Se entrega un curso nuevo
	   @course = Course.find(:first, :conditions => {'initials' => params[:initials]})
	   if @course.nil? #Si no existe curso con esas iniciales, se crea
		  @course = Course.create({'initials' => params[:initials], 'title' => params[:course_title], 'user_id' => session[:user]})
		  @survey.course_id = @course.id
	   elsif @course.user_id == session[:user] #Si el curso que intenta crear ya pertenece a el, asignarlo
		  @survey.course_id = @course.id
	   else
  		format.html { render :action => "new", :notice => 'El curso que esta tratando de crear ya existe y le pertenece a otra persona' }
	   end
    elsif !params[:course][:id].nil?#Si se selecciono del select
	     @survey.course_id = params[:course][:id]
    end
end
    respond_to do |format|
      if @survey.save
	#session[:survey_id] = @survey.id
        format.html { redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => @survey.id) }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
	
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])
    u = User.find(session[:user])
    @survey.user_id = u.id
    @survey.university = u.university
    
    if has_permission(@survey.user)
    
     @courses = Course.find(:all, :conditions => {:user_id => session[:user] })
     
    @survey.privacy_level = params[:survey][:privacy_level]
    logger.info "Updating survey"
    if @survey.privacy_level== Survey.privacy['Curso']
      logger.info "Privacy level => Curso"
      if(!params[:initials].nil? && params[:initials] != "") #Se entrega un curso nuevo
        @course = Course.find(:first, :conditions => {'initials' => params[:initials]})
        if @course.nil?
          @course = Course.create({'initials' => params[:initials], 'title' => params[:course_title], 'user_id' => session[:user]})
          @survey.course_id = @course.id
        elsif @course.user_id == session[:user] #Si el curso que intenta crear ya pertenece a el, asignarlo
          @survey.course_id = @course.id
        else
          format.html { render :action => "new", :notice => 'El curso que esta tratando de crear ya existe y le pertenece a otra persona' }
        end
      elsif !params[:course][:id].nil? #Si se selecciono del select
        logger.info "Course id selected"
        @survey.course_id = params[:course][:id]
      end
  end

flag = true

      if !@survey.save #if privacy_level was change to course, course had to be selected aswell
        logger.info "Survey Not saved"
        flag = false
      else  
        logger.info "Survey saved"
      end
   

    respond_to do |format|
      if flag && @survey.update_attributes(params[:survey])
        format.html { redirect_to(:action => 'index', :notice => 'Encuesta actualizada exitosamente') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
    
    else
      render "no_permission"
    end
    
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    #@surveys = Survey.find(:all, :conditions => {:user_id => session[:user]})

    respond_to do |format|
      format.html { redirect_to :action => :user_surveys }
      format.xml  { head :ok }
    end
  end

#Make the survey available in mobile devices
def publish

	@survey = Survey.find(params[:survey_id])
	if @survey.privacy_level > 4
		@survey.privacy_level = @survey.privacy_level - 4
	end
	@survey.save

  	@surveys = Survey.find(:all, :conditions => {:user_id => session[:user]})
  	@answers = Answer.find(:all)
  	respond_to do |format|
  	       @surveys = Kaminari.paginate_array(@surveys).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
      		format.html { redirect_to :action => "user_surveys"}
      		format.xml  { render :xml => @surveys }
    	end
end

 def close_survey
	@survey = Survey.find(params[:survey_id])
	if @survey.privacy_level < 5
		@survey.privacy_level = @survey.privacy_level + 4
	end
	@survey.save

  	@surveys = Survey.find(:all, :conditions => {:user_id => session[:user]})
  	@answers = Answer.find(:all)
    	respond_to do |format|
    	 @surveys = Kaminari.paginate_array(@surveys).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
      	format.html { redirect_to :action => "user_surveys" }
      	format.xml  { render :xml => @surveys }
    end
 
 end
 
 #survey_id
 def clone
 
 survey = Survey.find(params[:survey_id])
 
 if has_permission(survey.user)
 #clone to new survey
 new_survey = Survey.new(survey.attributes.merge({:code => nil}))
 new_survey.title = new_survey.title + "_copia"
 new_survey.save
 
 questions = Question.find(:all, :conditions => {:survey_id => params[:survey_id]}, :order => 'question_number')
 questions.each do |question|
   new_q = Question.new(question.attributes)
   new_q.survey_id = new_survey.id
   new_q.save
 end
 
 redirect_to :action => "user_surveys"
 
 else
   render "no_permission"
 end
 
 end

    private
  
  def sort_column
    Survey.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end

end
