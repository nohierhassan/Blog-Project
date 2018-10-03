class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  def create
    #render plain: params[:article].inspect
    # you cannot pass the parameters of the form directly instead make a method to do that
    @article = Article.new(form_params)
    if @article.save
      flash[:notice] = "Your article has been created"
      redirect_to article_path(@article)
    else 
      render :new   # new is the url -->to show again to the user
    end
  end

  def edit
    @article = Article.find(params[:id])
    
  end
  def update
    @article = Article.find(params[:id]) # you have to create an empty obj first
    if @article.update(form_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # recive the id of the article to show as a parameter
  def show
    @article = Article.find(params[:id]) 
  end

  private
  def form_params
    params.require(:article).permit(:title, :description)
  end
  
  

end
