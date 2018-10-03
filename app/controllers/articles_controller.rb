class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
  end
  
  def create
    #render plain: params[:article].inspect
    # you cannot pass the parameters of the form directly instead make a method to do that
    @article = Article.new(form_params)
    @article.save
    redirect_to articles_show(@article)
  end
  private
    def form_params
      params.require(:article).permit(:title, :description)
    end


end
