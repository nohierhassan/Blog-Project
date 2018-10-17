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
    @user = User.find(params[:id]) # as you pass the id in the url
  end

  def edit
    # @user is the parameter to pass to the edit page it self (we edit the passed object in the url)
   
    @user = User.find(params[:id]) 
  end

  def update  # update() called when the patch action in called
    @user = User.find(params[:id])
    if @user.update(form_params)
      flash[:success] = "User was updated successfully."
      redirect_to articles_path
    else
      render :edit, user: @user 

    end
  end

  def index
    @users = User.all
  end


  private

  # def set_article
  #   @article = Article.find(params[:id])
  # end
  def form_params
    params.require(:user).permit(:username, :email, :password)
  end


end