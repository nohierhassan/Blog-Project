class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # you cannot pass the form parameters directly to the function... instead make a method to do it
    @user = User.new(form_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog #{@user.username} ."
      redirect_to articles_path
    else 
      render :new
    end  

  end

  def show
  end


  private

  # def set_article
  #   @article = Article.find(params[:id])
  # end
  def form_params
    params.require(:user).permit(:username, :email, :password)
  end


end