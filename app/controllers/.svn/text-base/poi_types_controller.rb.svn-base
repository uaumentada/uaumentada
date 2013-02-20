class PoiTypesController < ApplicationController
       helper_method :sort_column, :sort_direction
  # GET /poi_types
  # GET /poi_types.xml
  def index
    @poi_types = PoiType.order(sort_column+ " " + sort_direction ).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poi_types }
      format.json 
    end
  end

  # GET /poi_types/1
  # GET /poi_types/1.xml
  def show
    @poi_type = PoiType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poi_type }
    end
  end

  # GET /poi_types/new
  # GET /poi_types/new.xml
  def new
    @poi_type = PoiType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poi_type }
    end
  end

  # GET /poi_types/1/edit
  def edit
    @poi_type = PoiType.find(params[:id])
  end

  # POST /poi_types
  # POST /poi_types.xml
  def create
    @poi_type = PoiType.new(params[:poi_type])

    respond_to do |format|
      if @poi_type.save
        format.html { redirect_to(@poi_type, :notice => 'Poi type was successfully created.') }
        format.xml  { render :xml => @poi_type, :status => :created, :location => @poi_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poi_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poi_types/1
  # PUT /poi_types/1.xml
  def update
    @poi_type = PoiType.find(params[:id])

    respond_to do |format|
      if @poi_type.update_attributes(params[:poi_type])
        format.html { redirect_to(@poi_type, :notice => 'Poi type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poi_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_types/1
  # DELETE /poi_types/1.xml
  def destroy
    @poi_type = PoiType.find(params[:id])
    @poi_type.destroy

    respond_to do |format|
      format.html { redirect_to(poi_types_url) }
      format.xml  { head :ok }
    end
  end
  
   private
  
  def sort_column
    PoiType.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end
  
end
