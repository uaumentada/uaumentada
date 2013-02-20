# encoding: utf-8
class UsersController < ApplicationController
     helper_method :sort_column, :sort_direction
  # GET /users
  # GET /users.xml
  def index
    @users = nil
    if !session[:super_admin].nil? && sort_column == "university_id"
      @nonull = User.find(:all, :joins => :university, :conditions => "university_id is not null", :order => "LOWER(" +'universities.name'+ ") " + sort_direction)
      @yesnull = User.where("university_id is null")
      if sort_direction == "asc"
        @users = @nonull+@yesnull
      else
        @users = @yesnull+@nonull
      end
    elsif !session[:admin].nil? && !session[:university].nil? && sort_column == "university_id"
      @users = User.find(:all, :joins => :university, :conditions => {:university_id => session[:university]}, :order => "LOWER(" + 'universities.name'+ ") " + sort_direction)
    elsif !session[:admin].nil? && !session[:university].nil? && sort_column
      @users = User.find(:all, :conditions => {:university_id => session[:university]}, :order => "LOWER(" + sort_column+ ") " + sort_direction)
    elsif !session[:admin].nil? && !session[:university].nil? #no sort_column
      @users = User.find(:all, :conditions => {:university_id => session[:university]})
    elsif !session[:super_admin].nil?
      @users = User.order("LOWER(" + sort_column+ ") " + sort_direction ).all
    end

    

    if !@users.nil?
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
      respond_to do |format|
        format.html # index.html.erb
      end
    else          
      render :action => "no_permission"
    end
  end

  #Displays a no permission view
  def no_permission

  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @session = session[:user]
    @id = params[:id]
    @user = User.find(params[:id])
    
    #only same user can see their details
    # a super_admin
    # or an admin from the same university
    if session[:user] == params[:id].to_i || !session[:super_admin].nil? || !session[:admin].nil? && session[:university] == @user.university.id
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
         format.html {render :action => "no_permission"}
      end
    end
  end

  # GET /profile/1
  def profile
    @session = session[:user]
    @id = params[:id]
    @user = User.find(params[:id])
    
    #only same user can see their details
    # a super_admin
    # or an admin from the same university
    if session[:user] == params[:id].to_i || !session[:super_admin].nil? || !session[:admin].nil? && session[:university] == @user.university.id
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
         format.html {render :action => "no_permission"}
      end
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if !session[:university].nil?
      @university = University.find(session[:university])
    end
    
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def new_admin
    if !session[:university].nil?
      @university = University.find(session[:university])
    end
    
    @user = User.new

    respond_to do |format|
      format.html # new_admin.html.erb
      format.xml  { render :xml => @user }
    end
  end

  #GET /users/1/edit
  def edit
    if !session[:university].nil?
      @university = University.find(session[:university])
    end
  
    @user = User.find(params[:id])
  end

  # GET /editprofile/:id
  def edit_profile
   if session[:user] == params[:id].to_i || !session[:super_admin].nil? || session[:university] == @user.univesity
      @user = User.find(params[:id])
   else
      render :action => "no_permission"
   end
  end

  # GET /editpassword/:id
  def edit_password
    if session[:user] == params[:id].to_i
      @user = User.new
      @id = params[:id]
    else
      render :action => "no_permission"
    end
  end

  # POST /users
  # POST /users.xml
  #create user
  def create
    @user = User.new(params[:user])
    university = University.find(params[:university][:id])
    @user.university_id = university.id
    
    privilege = Privilege.find(:first, :conditions => {:description => "special_user"})
    @user.privileges << privilege
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'Usuario creado con éxito.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
    # POST /users
  # POST /users.xml
  #create admin
  def create_admin
    @user = User.new(params[:user])
    university = University.find(params[:university][:id])
    @user.university_id = university.id
    
    privilege = Privilege.find(:first, :conditions => {:description => "admin"})
    @user.privileges << privilege
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'Administrador creado con exito.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

#for admins and superadmins, other users should not be able to change password
  def change_password
    @user = User.find(params[:id])
    oldpass = params[:old_pass]
    @data = User.new(params[:user])
    
    #if(oldpass.size < 6)
     #  redirect_to :action => "edit_password", :id => params[:id], notice => 'Su nueva contrasena es muy corta, no se ha actualizado' 
    #end

    if(@user.password.to_s == oldpass.to_s)
      if  @user.update_attributes(:password => params[:user][:password],:password_confirmation => params[:user][:password_confirmation])
       # @user.password = @data.password
        #@user.confirm_password = @data.confirm_password
        #if @user.save
	       redirect_to(:controller => 'users', :action => "profile", :id => @user.id, :notice => 'Contraseña cambiada.') 
        else
           redirect_to(:controller => 'users', :action => "edit_password", :id => @user.id, :notice => 'La nueva contraseña y la confirmación no coinciden')
        end
    else
	     redirect_to(:controller => 'users', :action => "edit_password", :id => @user.id, :notice => 'Tu contraseña antigua no coincide. Intenta nuevamente') 
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update_profile
    @user = User.find(params[:id])
    
    if !params[:university].nil? && !params[:university][:id].nil?
      university = University.find(params[:university][:id])
      @user.university_id = university.id
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:controller => 'users', :action => "profile", :id => @user.id, :notice => 'Usuario actualizado con éxito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    
    if !params[:university].nil? && !params[:university][:id].nil?
      university = University.find(params[:university][:id])
      @user.university_id = university.id
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Usuario actualizado con éxito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    
    #Only destroy is different from current logged user
    if session[:user] != params[:id]
      @user = User.find(params[:id])
      @user.destroy
    end
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

#Creates a new user with view_survey privileges.
#Request is sent from mobile device.
#def new_mobile

 # @user = User.new({ :name => params[:name], :email => params[:email], :password => params[:password] })
  #@user.save

  #@privilege = Privilege.find(:first, :conditions => {:description => "view_survey"})
  #if @privilege.nil?
  #   Privilege.create({ :description => "view_survey"})
  #end	

  #@new_privilege = User_privilege.new
  #@new_privilege.user_id = @user.id
  #@new_privilege.privilege_id = @privilege.id
  #@new_privilege.save

#redirect_to :action => 'index'

#end

# params:
# user
# password
def mobile_signup
 if !params[:user].nil? && !params[:password].nil?
    
    @user = User.new
    @user.name = "test"
    @user.email = params[:user]
    @user.password = params[:password]

      if @user.save
        render :xml => {:result => "true"}.to_xml
      elsif !User.find(:first, :conditions => { :email => params[:user] }).nil?
        render :xml => {:result => "false", :reason => "user already exists"}.to_xml
       else
        render :xml => {:result => "false"}.to_xml
      end
 else
    render :xml => {:result => "false", :reason => "Some data is missing (user, email or password)"}.to_xml
 end
end

  private
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end

end
