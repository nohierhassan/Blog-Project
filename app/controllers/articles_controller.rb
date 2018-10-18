class ArticlesController < ApplicationController
  # this line will allow the actions to call the set_article method first

  # you are able to use all the bellow methods as they are in ApplicationController 
  # which they inherit from
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end
  def create
    #render plain: params[:article].inspect
    # you cannot pass the parameters of the form directly instead make a method to do that
    @article = Article.new(form_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Your article has been created"
      redirect_to article_path(@article)
    else 
      render :new   # new is the url -->to show again to the user
    end
  end

  def edit
    #@article = Article.find(params[:id])
    
  end
  def update
    #@article = Article.find(params[:id]) # you have to create an empty obj first
    if @article.update(form_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      puts "7amoooooooooooooooooo"
     render :edit, article: @article 
    end
  end

  # recive the id of the article to show as a parameter
  def show
    #@article = Article.find(params[:id]) 
  end
  
  def destroy
    #@article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "The Article has been deleted"
    redirect_to articles_path

  end

# adding the index action (for listing all articles)
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def form_params
    params.require(:article).permit(:title, :description)
  end
  

end
