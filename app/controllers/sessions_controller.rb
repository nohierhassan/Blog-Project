class SessionsController < ApplicationController
  def new

  end

  def create
    # grab the user based on the params passed from new()
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Sign in successfully" # use flash[] to show the message in another request
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Your login information is not correct"
      render 'new' #use flash.now[] to show the message in the same request

    end



  end

  def destroy
    # set the session[:user_id]= nil to indicate that the user is logged out
    session[:user_id] = nil
    flash[:success] = "You are successfully logged out"
    redirect_to articles_path

  end

end