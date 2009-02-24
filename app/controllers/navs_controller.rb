class NavsController < ApplicationController
  # GET /navs
  # GET /navs.xml
  def index
    @navs = Nav.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @navs }
    end
  end

  # GET /navs/1
  # GET /navs/1.xml
  def show
    @nav = Nav.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nav }
    end
  end

  # GET /navs/new
  # GET /navs/new.xml
  def new
    @nav = Nav.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nav }
    end
  end

  # GET /navs/1/edit
  def edit
    @nav = Nav.find(params[:id])
  end

  # POST /navs
  # POST /navs.xml
  def create
    @nav = Nav.new(params[:nav])

    respond_to do |format|
      if @nav.save
        flash[:notice] = 'Nav was successfully created.'
        format.html { redirect_to(@nav) }
        format.xml  { render :xml => @nav, :status => :created, :location => @nav }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nav.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /navs/1
  # PUT /navs/1.xml
  def update
    @nav = Nav.find(params[:id])

    respond_to do |format|
      if @nav.update_attributes(params[:nav])
        flash[:notice] = 'Nav was successfully updated.'
        format.html { redirect_to(@nav) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nav.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /navs/1
  # DELETE /navs/1.xml
  def destroy
    @nav = Nav.find(params[:id])
    @nav.destroy

    respond_to do |format|
      format.html { redirect_to(navs_url) }
      format.xml  { head :ok }
    end
  end
end
