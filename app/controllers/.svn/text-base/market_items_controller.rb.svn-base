# encoding: utf-8
class MarketItemsController < ApplicationController
       helper_method :sort_column, :sort_direction
           include ApplicationHelper
  # GET /market_items
  # GET /market_items.xml
  # params:
  # univ : filter by email extension
  # campus : filter by campus
  def index

  campus = get_campus_id(params[:campus])
  
  @market_items = []
  if  !campus.nil? #filter by campus (that implicitly involves university)
    @market_items = MarketItem.search(params[:searchbox]).find(:all, :conditions => ["campus_id = ?", campus.id], :order => "LOWER("+sort_column+ ") " + sort_direction)  
  elsif !params[:univ].nil? #filter by university
    univ = nil
    if !params[:univ].nil?
      univ = University.where("email = ?", params[:univ]).first
    end
    @market_items = MarketItem.joins(:campus).search(params[:searchbox]).find(:all, :conditions => ["campus.university_id = ?", univ.id], :order => "LOWER("+sort_column+ ") " + sort_direction)
  elsif campus.nil? #show all
    @market_items = MarketItem.search(params[:searchbox]).order("LOWER("+sort_column+ ") " + sort_direction ).all
  else #only filter by campus
    @market_items = MarketItem.search(params[:searchbox]).find(:all, :conditions => {:campus_id => campus.id}, :order => "LOWER("+sort_column+ ") " + sort_direction)
  end
  
  @market_items = Kaminari.paginate_array(@market_items).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
  
    respond_to do |format|
      format.html # index.html.erb
     # format.xml  { render :xml => @market_items }
     format.json #index.json.erb
    end
  end

  # params:
  # user: filter by user --when called from mobile application
  def my_items
  
  @market_items = []
  if !session[:user].nil? #used from web application
    @market_items = MarketItem.find(:all, :conditions => {:user_id => session[:user]})
  elsif !params[:user].nil? || !params[:user] == "" #used from mobile application
    user = User.find(:first, :conditions =>{:email => params[:user]})
    @market_items = MarketItem.find(:all, :conditions => {:user_id => user})
  end
  
  @market_items = Kaminari.paginate_array(@market_items).page(params[:page]).per(Pucaumentada::Application::PER_PAGE)
  
    respond_to do |format|
     format.html # index.html.erb
     # format.xml  { render :xml => @market_items }
     format.json #index.json.erb
    end
  end


  # GET /market_items/1
  # GET /market_items/1.xml
  def show
    @market_item = MarketItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @market_item }
      format.json #show.json.erb
    end
  end

  # GET /market_items/new
  # GET /market_items/new.xml
  def new
    @market_item = MarketItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @market_item }
    end
  end

# params:
# title
# description
# price
# username
# campus
def new_item

  user = User.find(:first, :conditions => { :email => params[:username]})
  reason = "something wrong"
  if !user.nil?
    campus = nil;
    if !params[:campus].nil?
      campus = Campus.find(:first, :conditions => { :name => params[:campus]})
      if campus.nil?
        reason = "Cannot find campus"
      end
    end

    item = MarketItem.new
    item.title = params[:title]
    item.description = params[:description]
    item.price = params[:price].to_i
    item.user = user
    item.campus = campus

    if item.save
      render :xml => {:result => "true"}.to_xml
    else
      render :xml => {:result => "false", :reason => reason}.to_xml
    end
  else #user invalid
    render :xml => {:result => "false", :reason => "invalid user"}.to_xml
  end
end

# params:
# title
# description
# price
# username
# campus
# id
def edit_item

  item = MarketItem.find(params[:id])

  reason = "something wrong"
    if !params[:campus].nil?
      campus = Campus.find(:first, :conditions => { :name => params[:campus]})
      if campus.nil?
        reason = "Cannot find campus"
      end
    end

    item.title = params[:title]
    item.description = params[:description]
    item.price = params[:price].to_i
    item.campus = campus

    if item.save
      render :xml => {:result => "true"}.to_xml
    else
      render :xml => {:result => "false", :reason => reason}.to_xml
    end
end

# params:
# id : id of the item to be deleted
def delete_item

   if !params[:id].nil?
    @market_item = MarketItem.find(params[:id])
    if !@market_item.nil?
      @market_item.destroy
      render :xml => {:result => "true"}.to_xml
    else
      render :xml => {:result => "false"}.to_xml
    end
   else #no id
    render :xml => {:result => "false"}.to_xml
  end

end

  # GET /market_items/1/edit
  def edit
    @market_item = MarketItem.find(params[:id])
    if has_permission(@market_item.user)
      render
    else
      render "no_permission"
    end
  end

  # POST /market_items
  # POST /market_items.xml
  def create
    @market_item = MarketItem.new(params[:market_item])
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @market_item.campus_id = campus.id
    
    respond_to do |format|
      if @market_item.save
        format.html { redirect_to(@market_item, :notice => 'El item fue creado satisfactoriamente') }
        format.xml  { render :xml => @market_item, :status => :created, :location => @market_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @market_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /market_items/1
  # PUT /market_items/1.xml
  def update
    @market_item = MarketItem.find(params[:id])
    
    #Set campus of poi by decoding lat and long from
    campus = params[:campus][:name]
    loc = campus.split(',')
    campus = Campus.find(:first, :conditions => {:lat => loc[0], :lng => loc[1] })
    @market_item.campus_id = campus.id

    respond_to do |format|
      if @market_item.update_attributes(params[:market_item])
        format.html { redirect_to(@market_item, :notice => 'El artículo fue actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @market_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /market_items/1
  # DELETE /market_items/1.xml
  def destroy
    @market_item = MarketItem.find(params[:id])
    @market_item.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "my_items") }
      format.xml  { head :ok }
    end
  end
  
    private

  def sort_column
    MarketItem.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
end
