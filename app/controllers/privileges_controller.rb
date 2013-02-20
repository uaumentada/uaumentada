class PrivilegesController < ApplicationController
  # GET /privileges
  # GET /privileges.xml
  def index
    @privileges = Privilege.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @privileges }
    end
  end

  # GET /privileges/1
  # GET /privileges/1.xml
  def show
    @privilege = Privilege.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @privilege }
    end
  end

  # GET /privileges/new
  # GET /privileges/new.xml
  def new
    @privilege = Privilege.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @privilege }
    end
  end

  # GET /privileges/1/edit
  def edit
    @privilege = Privilege.find(params[:id])
  end

  # POST /privileges
  # POST /privileges.xml
  def create
    @privilege = Privilege.new(params[:privilege])

    respond_to do |format|
      if @privilege.save
        format.html { redirect_to(@privilege, :notice => 'Privilege was successfully created.') }
        format.xml  { render :xml => @privilege, :status => :created, :location => @privilege }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @privilege.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /privileges/1
  # PUT /privileges/1.xml
  def update
    @privilege = Privilege.find(params[:id])

    respond_to do |format|
      if @privilege.update_attributes(params[:privilege])
        format.html { redirect_to(@privilege, :notice => 'Privilege was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @privilege.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /privileges/1
  # DELETE /privileges/1.xml
  def destroy
    @privilege = Privilege.find(params[:id])
    @privilege.destroy

    respond_to do |format|
      format.html { redirect_to(privileges_url) }
      format.xml  { head :ok }
    end
  end
  
  #Shows all the privileges one user has
  # Params:
  # user_id : show privileges of this user
  def user_privileges
    
    @user = User.find(params[:user_id])
    @privileges = @user.privileges
    @all_privileges = Privilege.order("description asc").all
    
  end
  
  #Assigns a privilege from a user
  #Params
  # user_id :user to be assigned a privilege
  # privilege_id : privilege to be assigned
  def assign
    @user = User.find(params[:user_id])
    @priv = Privilege.find(params[:privilege_id])
    if @priv.description != "professor"
       @user.privileges << @priv
    else #create professor petition if professor privilege wants to be assigned
      @prof = Professor.new
      @prof.user_id = @user.id
      @prof.save
    end
    
    @user.save
    
    redirect_to :action => "user_privileges", :user_id => @user.id
  end
  
  #Removes a privilege from a user
  #Params
  # user_id :user to be removed a privilege
  # privilege_id : privilege to be removed
  def remove_privilege
     @user = User.find(params[:user_id])
     @privilege = Privilege.find(params[:privilege_id])

     @user.privileges.delete(@privilege)
     @user.save
     
     redirect_to :action => "user_privileges", :user_id => @user.id
  end
  
end
