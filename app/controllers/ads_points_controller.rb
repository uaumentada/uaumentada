class AdsPointsController < ApplicationController
helper_method :sort_column, :sort_direction
    include ApplicationHelper
  # GET /ads_points
  # GET /ads_points.xml
  def index
    #@ads_points = AdsPoint.page(params[:page]).per(Pucaumentada::Application::PER_PAGE)   
    
    campus = get_campus_id(params[:campus])
    
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    
    if(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil? && !campus.nil?) #filter by campus
      @all_ads = AdsPoint.near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km }).where("campus_id = ?", campus.id)
    #elsif(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil? && !univ.nil?) #filter by univ
     # @all_ads = AdsPoint.near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km })ins(:campus).where("campus.university_id = ?", univ.id)
    elsif(!params[:lat].nil? && !params[:lng].nil? && !params[:radius].nil?)
      @all_ads = AdsPoint.near([params[:lat].to_f, params[:lng].to_f], params[:radius].to_f, { :units => :km })
    elsif sort_column == "campus_id"
      ads = AdsPoint.find(:all, :joins => :campus, :order => "LOWER("+'campus.name'+ ") " + sort_direction)
      @all_ads = Kaminari.paginate_array(ads).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    else #Show all
      ads = AdsPoint.find(:all, :joins => :campus, :order => "LOWER("+sort_column+") " + sort_direction)
      @all_ads = Kaminari.paginate_array(ads).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    end
    
    @ads_points = []
    @all_ads.each do |ad| 
      if campus.nil? && !univ.nil? && ad.campus.university.id == univ.id && ad.events.size + ad.contests.size > 0 
        @ads_points << ad
      elsif ad.events.size + ad.contests.size > 0
        @ads_points << ad
      end
    end
    
    #@ads_points = Kaminari.paginate_array(@ads_points).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
    respond_to do |format|
      format.html # index.html.erb
      format.json #index.json.erb
    end
  end

  #params
  # event_id
  def index_ads_events
    @ads_points = AdsPoint.all
    @event = Event.find(params[:event_id])
    
  end
  
  #params
  # contest_id
  def index_ads_contests
    @ads_points = AdsPoint.all
    @contest = Contest.find(params[:contest_id])
    
  end

  #Assigns a ad_point to an event
  #Params
  # event_id :user to be assigned a privilege
  # ads_point_id : privilege to be assigned
  def assign_ad_to_event
    @event = Event.find(params[:event_id])
    @event.ads_points << AdsPoint.find(params[:ads_point_id])
    @event.save
    
    redirect_to :action => "index_ads_events", :event_id => @event.id
  end
  
  #Removes an ad_point from an event
  #Params
  # event_id :user to be removed a privilege
  # ads_point_id : privilege to be removed
  def remove_ad_from_event
     @event = Event.find(params[:event_id])
     @ads_point = AdsPoint.find(params[:ads_point_id])

     @event.ads_points.delete(@ads_point)
     @event.save
     
     redirect_to :action => "index_ads_events", :event_id => @event.id
  end
  
    #Assigns a ad_point to an event
  #Params
  # contest_id :user to be assigned a privilege
  # ads_point_id : privilege to be assigned
  def assign_ad_to_contest
    @contest = Contest.find(params[:contest_id])
    @contest.ads_points << AdsPoint.find(params[:ads_point_id])
    @contest.save
    
    redirect_to :action => "index_ads_contests", :contest_id => @contest.id
  end
  
  #Removes an ad_point from an event
  #Params
  # event_id :user to be removed a privilege
  # ads_point_id : privilege to be removed
  def remove_ad_from_contest
     @contest = Contest.find(params[:contest_id])
     @ads_point = AdsPoint.find(params[:ads_point_id])

     @contest.ads_points.delete(@ads_point)
     @contest.save
     
     redirect_to :action => "index_ads_contests", :contest_id => @contest.id
  end

  # GET /ads_points/1
  # GET /ads_points/1.xml
  def show
    @ads_point = AdsPoint.find(:first, :conditions => {:id => params[:id]}, :include => [:events, :contests])

    respond_to do |format|
      format.html # show.html.erb
      format.json #show.json.erb
    end
  end

  # GET /ads_points/new
  # GET /ads_points/new.xml
  def new
    @ads_point = AdsPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ads_point }
    end
  end

  # GET /ads_points/1/edit
  def edit
    @ads_point = AdsPoint.find(params[:id])
  end

  # POST /ads_points
  # POST /ads_points.xml
  def create
    @ads_point = AdsPoint.new(params[:ads_point])
    @campus = Campus.new(params[:campus])
    loc = @campus.name.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @ads_point.campus_id = campus.id;

    respond_to do |format|
      if @ads_point.save
        format.html { redirect_to(@ads_point, :notice => 'Punto de publicidad creado satisfactoriamente.') }
        format.xml  { render :xml => @ads_point, :status => :created, :location => @ads_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ads_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ads_points/1
  # PUT /ads_points/1.xml
  def update
    @ads_point = AdsPoint.find(params[:id])
    @campus = Campus.new(params[:campus])
    loc = @campus.name.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @ads_point.campus_id = campus.id;
    
    respond_to do |format|
      if @ads_point.update_attributes(params[:ads_point])
        format.html { redirect_to(@ads_point, :notice => 'Punto de publicidad creado satisfactoriamente') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ads_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ads_points/1
  # DELETE /ads_points/1.xml
  def destroy
    @ads_point = AdsPoint.find(params[:id])
    @ads_point.destroy

    respond_to do |format|
      format.html { redirect_to(ads_points_url) }
      format.xml  { head :ok }
    end
  end
  
    private
  
  def sort_column
    AdsPoint.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
end
