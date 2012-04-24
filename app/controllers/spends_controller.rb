class SpendsController < ApplicationController
  # GET /spends
  # GET /spends.xml
  def index
    if params[:year] && params[:month] 
      year = params[:year]
      month = params[:month]
    end
    
    
    year = Time.now.year unless year
    month = Time.now.month unless month
    
    @period_date = DateTime.new(year.to_i, month.to_i, 1)     
    @period_date = DateTime.now.beginning_of_month() unless @period_date
    
    #@period_date = DateTime.new(period)
    @prev_period = @period_date - 1.month
    @next_period = @period_date + 1.month
    
    @spends = Spend.at_month @period_date
    
    if params[:with_tag]
       @spends = @spends.tagged_as(params[:with_tag])
    end

    @sum = @spends.sum(:ammount)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spends }
    end
  end

  # GET /spends/1
  # GET /spends/1.xml
  def show
    @spend = Spend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spend }
    end
  end

  # GET /spends/new
  # GET /spends/new.xml
  def new
    @spend = Spend.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spend }
      format.js 
    end
  end

  # GET /spends/1/edit
  def edit
    @spend = Spend.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @spend }
      format.js 
    end
  end

  # POST /spends
  # POST /spends.xml
  def create
    @spend = Spend.new(params[:spend])
    tags = from_tags_listing(params[:tags_listing])
    @spend.tags = tags
    respond_to do |format|
      if @spend.save
        format.html { redirect_to(:action => 'index', :notice => 'Spend was successfully created.') }
        format.xml  { render :xml => @spend, :status => :created, :location => @spend }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spend.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /spends/1
  # PUT /spends/1.xml
  def update
    @spend = Spend.find(params[:id])
    tags = from_tags_listing(params[:tags_listing])
    @spend.tags = tags
    respond_to do |format|
      if @spend.update_attributes(params[:spend])
        format.html { redirect_to(:action => 'index', :notice => 'Spend was successfully updated.') }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spend.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /spends/1
  # DELETE /spends/1.xml
  def destroy
    @spend = Spend.find(params[:id])
    @spend.destroy

    respond_to do |format|
      format.html { redirect_to(spends_url) }
      format.xml  { head :ok }
      format.js
    end
  end
end
