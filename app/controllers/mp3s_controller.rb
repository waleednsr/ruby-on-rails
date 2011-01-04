class Mp3sController < ApplicationController
  # GET /mp3s
  # GET /mp3s.xml
  before_filter :login_required, :except=>[:index, :show ]
  load_and_authorize_resource
  def index
  
  if params[:search]
@mp3s=Mp3.find(:all, :conditions=>['name LIKE?',"%#{params[:search]}%"])
  else
    @mp3s = Mp3.paginate(:per_page=>5, :page=>params[:page])
  end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mp3s }
    end
  end

  # GET /mp3s/1
  # GET /mp3s/1.xml
  def show
    @mp3 = Mp3.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mp3 }
    end
  end

  # GET /mp3s/new
  # GET /mp3s/new.xml
  def new
    @mp3 = Mp3.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mp3 }
    end
  end

  # GET /mp3s/1/edit
  def edit
    @mp3 = Mp3.find(params[:id])
  end

  # POST /mp3s
  # POST /mp3s.xml
  def create
    @mp3 = current_user.mp3s.create(params[:mp3])

    respond_to do |format|
      if @mp3.save
        flash[:notice] = 'Mp3 was successfully created.'
        format.html { redirect_to(@mp3) }
        format.xml  { render :xml => @mp3, :status => :created, :location => @mp3 }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mp3.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mp3s/1
  # PUT /mp3s/1.xml
  def update
    @mp3 = Mp3.find(params[:id])

    respond_to do |format|
      if @mp3.update_attributes(params[:mp3])
        flash[:notice] = 'Mp3 was successfully updated.'
        format.html { redirect_to(@mp3) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mp3.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mp3s/1
  # DELETE /mp3s/1.xml
  def destroy
    @mp3 = Mp3.find(params[:id])
    @mp3.destroy

    respond_to do |format|
      format.html { redirect_to(mp3s_url) }
      format.xml  { head :ok }
    end
  end
end
