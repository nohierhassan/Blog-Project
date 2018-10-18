class ApplicationController < ActionController::Base

helper_method :current_user, :logged_in? # in order to use them in the html.reb

def current_user
  # trying to get the current user
  #use the memoization pattern if the user already exists
  current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def logged_in?
  !!current_user  # wether true or false

end

def require_user
  if !logged_in?
    flash[:danger] = "You have to be logged in "
    redirect_to login_path
  end
end

def require_same_user
  
  if current_user != @article.user
    debugger
    flash[:danger] = "You are not allowed to make actions"
    redirect_to login_path
  end
end

end
