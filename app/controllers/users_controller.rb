class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @user = User.new
  end

  def create
    # you cannot pass the form parameters directly to the function... instead make a method to do it
    @user = User.new(form_params)
    if @user.save
      session[:user_id] = @user.id 
      flash[:success] = "Welcome to the Alpha Blog #{@user.username} ."
      redirect_to user_path(@user)
    else 
      flash[:danger] = "process is not completed"
      redirect_to root_path
    end  

  end

  def show
    # #set_user() is called here from the before:
    #paginate all the articles of this user
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    #set_user() is called here from the before:
  end

  def update
    #set_user() is called here from the before:
    
    if @user.update(form_params)
      flash[:success] = "User was updated successfully."
      redirect_to articles_path
    else
      render :edit, user: @user 

    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end


  private
 # function to find the @user based on the params[:id]
 # we will use this function for update
  def set_user
     @user = User.find(params[:id])
  end

  def form_params
    params.require(:user).permit(:username, :email, :password)
  end
  def require_same_user
    if current_user != @user  && !current_user.admin?
      flash[:danger] = "You are not allowed to make actions"
      redirect_to root_path
    end
  end
end