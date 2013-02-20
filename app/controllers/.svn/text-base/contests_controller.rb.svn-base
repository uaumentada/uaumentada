class ContestsController < ApplicationController
   helper_method :sort_column, :sort_direction, :has_permission
    include ApplicationHelper
  # GET /contests
  # GET /contests.xml
  # univ = email extension of university to use as filter
  def index
  
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
  
    if !univ.nil?
      @contests = Contest.joins(:user).where("end_date > ? AND users.university_id = ?", Date.today, univ.id)
    else
      @contests = Contest.where("end_date > ? ", Date.today)
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contests }
      format.json # index.json.erb
    end
  end
  
  #Selects contests that belong to a user
  def my_contests
    @contests = Contest.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction ).find(:all, :conditions => {:user_id => session[:user]})
@contests = Kaminari.paginate_array(@contests).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    respond_to do |format|
      format.html { render "index"}
      format.xml  { render :xml => @contests }
    end
  end

  # GET /contests/1
  # GET /contests/1.xml
  def show
    @contest = Contest.find(params[:id])
    
    if has_permission(@contest.user)
      respond_to do |format|
        format.html # show.html.erb
        #format.xml  { render :xml => @contest }
        format.json #show.json.erb
      end
    elsif params[:mobile]
     respond_to do |format|
        format.json #show.json.erb
      end
    else #no tiene permiso
      render "no_permission"
    end
  end

  # GET /contests/new
  # GET /contests/new.xml
  def new
    @contest = Contest.new
    @contest.init_date = Date.today
    @contest.end_date = Date.today
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contest }
    end
  end

  # GET /contests/1/edit
  def edit
    
    @contest = Contest.find(params[:id])
      if has_permission(@contest.user)
        render
      else
        render "no_permission"
      end
  end

  # POST /contests
  # POST /contests.xml
  def create
    @contest = Contest.new(params[:contest])
    user = User.find(session[:user])
    @contest.user = user
    
    respond_to do |format|
      if @contest.save
        format.html { redirect_to(@contest, :notice => 'Concurso creado satisfactoriamente.') }
        format.xml  { render :xml => @contest, :status => :created, :location => @contest }
      else
         @contest.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "new" }
        #format.html { render :action => "new" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contests/1
  # PUT /contests/1.xml
  def update
    @contest = Contest.find(params[:id])
    if params[:delete_image]
      @contest.image = nil
      @contest.save
    end

    respond_to do |format|
      if @contest.update_attributes(params[:contest])
        format.html { redirect_to(@contest, :notice => 'Concurso actualizado satisfactoriamente.') }
        format.xml  { head :ok }
      else
        @contest.errors.full_messages.each do |e|
          flash[:notice] = e;
        end
        format.html { redirect_to :action => "edit" }
        #format.html { render :action => "edit" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.xml
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "my_contests") }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def sort_column
    Contest.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
 
  
end
