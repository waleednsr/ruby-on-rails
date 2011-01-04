class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  before_filter :login_required, :except=>[:index, :show] 
  load_and_authorize_resource
  def index
  if params[:search]
  @articles=Article.find(:all, :conditions=>['name LIKE?',"%#{params[:search]}%"])
   else
 @articles = Article.paginate(:per_page=>5, :page=>params[:page])
end

  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end
def rate
@article = Article.find(params[:id])
@article.rate(params[:stars], current_user, params[:dimension])
render :update do |page|
page.replace_html @article.wrapper_dom_id(params), ratings_for(@article, params.merge(:wrap => false))
page.visual_effect :highlight, @car.wrapper_dom_id(params)
end
end
  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
	@article.add_rating Rating.new(:rating => 1)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = current_user.articles.create(params[:article])
    @article.update_attribute(:author, current_user.name)
      respond_to do |format|
      if verify_recaptcha && @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
	    flash[:error] = "Your captcha entry was invalid"
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
	@article.update_attribute(:author, current_user.email)

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
  
  end
