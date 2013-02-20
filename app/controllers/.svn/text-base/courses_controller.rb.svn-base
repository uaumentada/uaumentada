class CoursesController < ApplicationController
        include ApplicationHelper
  # GET /courses
  # GET /courses.xml
  def index
    @courses = Course.all

    if session[:admin] || session[:super_admin]
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @courses }
      end
    else
      render "no_permission"
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])

    if has_permission(@course.user)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @course }
      end
    else
      render "no_permission"
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
        if has_permission(@course.user)
          render
        else
          render "no_permission"
        end
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    @course.user_id = User.find(session[:user]).id

    respond_to do |format|
      if @course.save
        @courses = Course.all
        format.html{ redirect_to :action => "user_courses" }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        flash[:notice] = 'El curso no se pudo crear, intente nuevamente' 
        format.html { render :action => "new"}
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    if has_permission(@course.user)
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html{ redirect_to :action => "user_courses" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :notice => 'El curso no se pudo actualizar, intente nuevamente' }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
    else
      render "no_permission"
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    
    @surveys = Survey.find(:all, :conditions => {'course_id' => @course.id })
    @surveys.each do |survey|
      survey.course_id = nil
      survey.save
    end
    
    @course.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'user_courses' }
      format.xml  { head :ok }
    end
  end

#With XML format returns the list of all available courses
def get_courses

    @courses = Course.all

    respond_to do |format|
    format.xml  { render :xml => @courses }
    end

end

#Returns the list of courses where the user is subscribed
def get_user_courses

   @user = User.find(:first, :conditions => {'email' => params[:email]})
   if !@user.nil?
   @usercourses = UserCourse.find(:all, :conditions => { 'user_id' => @user.id })

   @courses = []
   @usercourses.each do |uc|
	@courses << Course.find(uc.course_id)
   end
   else
   	@courses = []

   end

    respond_to do |format|
    format.xml  { render :xml => @courses }
    end

end

#Subscribes a user to a course
#
# Parameters:
# *email : user_email to sign up
# *course : initials of the course to sign up.
def subscribe_course
    
	@course = Course.find(:first, :conditions => {'initials' => params[:course]})
 	@user = User.find(:first, :conditions => {'email' => params[:email]})

	existing = UserCourse.find(:first, :conditions => {'user_id' => @user.id, 'course_id' => @course.id})
	#Add the ascociation only if it does not exist yet
	if existing.nil?
		@assoc = UserCourse.new
		@assoc.user_id = @user.id
		@assoc.course_id = @course.id
		@assoc.save
	end

	@courses = Course.all
	render 'assocs'
end

#Unsubscribes a user to a course
#
# Parameters:
# *email : user_email to sign up
# *course : initials of the course to sign up.
def unsubscribe_course

	@course = Course.find(:first, :conditions => {'initials' => params[:course]})
 	@user = User.find(:first, :conditions => {'email' => params[:email]})

	@assocs = UserCourse.find(:all, :conditions => {'user_id' => @user, 'course_id' => @course})
	@assocs.each do |assoc|
		assoc.destroy
	end

	@courses = Course.all
	render 'assocs'

end

def user_courses
  
  @courses = Course.find(:all, :conditions => {'user_id' => session[:user]})
  
end


end
